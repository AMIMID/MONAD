(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
);

s.waitForBoot{
Buffer.freeAll;

	////bpf sources
//	~c1 = Buffer.readChannel(s,"/home/pett/Desktop/0.wav",channels:0 );
//	~c2 = Buffer.readChannel(s,"/home/pett/Desktop/1.wav",channels:0 );
////	~c3 = Buffer.readChannel(s,"/home/pett/Desktop/2.wav",channels:0 );
//	~c4 = Buffer.readChannel(s,"/home/pett/Desktop/3.wav",channels:0 );
//	~c5 = Buffer.readChannel(s,"/home/pett/Desktop/4.wav",channels:0 );

////////////////////////////////////speaker setup///other
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);


	/////angle
		({
		var angle=0;
		~angle=(360*12).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	);

	///thread
(
		{
	var amp1,amp2,amp3,center=1800/2,pitch4,pitch5,pitch6,pitch7,pitch8,pitch9,dist,harm;
	var ton1,ton2,ton3,fundamental,sph,sph8,varamp=5,freq1,pitch1,pitch2,pitch3,env,n1,n2,n3,magx,magy,magz,mag_x,mag_y,mag_z,magqx,magqy,mag_qx,mag_qy;
	var ratio1,ratio2,ratio3,m=3,mq=2,phase,osc1,osc2,osc3,sphere,scale,nn=29.neg,nnn=15.neg,scale_coo,sig;
	var mod_angle,mod_angle1,mod_angle2,mod_anglez,mag,magxx,q1,q2,waveSpeed = 1, theta,phi,wave,t,scalar;
	var axis,i,j,k,coordinatesx,coordinatesy,coordinatesz,v,v1,qsphe,ii,iii,jj,jjj,kk,kkk,axis1,axis2,axis3,v2,v3;

			////controls
		~amp=1;~az=MouseX.kr(pi.neg,pi);~el=MouseY.kr((pi/2).neg,(pi/2));~lfo=0.1;~spread=1;~ripple=0.1;~waveFreq=5;varamp=~waveFreq.reciprocal*10;
		~coo=0;~cell=0.1;~rot_angle=~angle.[0];~lamdoma=1;//incorporate boolea
		~mh=1;~lfo2=0.1;~octave=1;
			//~buf=0;~rq=0.00001;

///spheres and angles
	sph=Spherical(1,~az,~el);sph8=Spherical(1,(~az+~angle.[0].degrad).wrap(pi.neg,pi),(~el+~angle.[0].degrad).wrap((pi/2).neg,(pi/2)));
	mod_angle=SinOsc.ar(~lfo,0.degrad).range(90.neg.degrad,90.degrad);
	mod_angle1=SinOsc.ar(~lfo,90.degrad).range(90.neg.degrad,90.degrad);
	mod_anglez=SinOsc.ar(~lfo,45.degrad).range(90.neg.degrad,90.degrad);

///distance
q1=Quaternion(0,sph.x,sph.y,sph.z); q2=Quaternion(0,sph8.x,sph8.y,sph8.z);
dist=q1.distance(q2);

			//env=EnvGen.ar(Env.perc(dist.lag(0.1),decay*dist.lag(0.1),amp),doneAction:2,levelScale:0.01);

///scales
//scale=57.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};
scale_coo=29.collect{nnn=nnn+1;Scale.major.performDegreeToKey(nnn,12)};////make boolean
scalar=2.pow(Select.kr(~coo.round(1).linlin(14.neg, 14, 0, 28), scale_coo) / 12);

//fundamental
fundamental=(center)*scalar*~lamdoma;
freq1=(fundamental*~octave);

////spherical harmonics and ripple effect
					(
		magx=((Complex(cos(((sph.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi)),cos((((sph.theta+mod_angle).round(0.00001)*m)).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(~spread)*
	(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(~spread);
				);

magy=((Complex(sin(((sph.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi)),sin(((sph.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(~spread)*
		(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(~spread);
				);

magz=((Complex(cos(((sph.phi+mod_anglez).round(0.00001)*m).wrap((pi/2).neg,(pi/2))),cos(((sph.phi).round(0.00001)*m).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(~spread));

magqx=((((Complex(cos(((sph.theta.round(0.00001)+mod_angle)*mq).wrap(pi.neg,pi)),
cos(((sph.theta.round(0.00001)+mod_angle)*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(~spread);

 magqy=((((Complex(sin(((sph.theta.round(0.00001)+mod_angle1)*mq).wrap(pi.neg,pi)),
sin(((sph.theta.round(0.00001)+mod_angle1)*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(~spread);

	t=SinOsc.kr(~ripple).range(1, 100);
	theta = ~az;
     phi = ~el;
	 wave = varamp*sin(~waveFreq * theta + ~waveFreq * phi - waveSpeed * t);
  magxx=  magx * wave;

				mag_x=magxx.value;mag_y=magy.value;mag_z=magz.value;mag_qx=magqx.value;mag_qy=magqy.value
				);
///phase,tones
						phase=Complex(sph.theta.linlin(pi.neg,pi,1.neg,1),sph.phi.linlin((pi/2).neg,(pi/2),1.neg,1)).theta;
				mod_angle2=SinOsc.ar(~lfo2,phase).range(90.neg.degrad,90.degrad);///harm oscillator phase can vary across tones
			//mod_angle2=LFNoise1.ar(lfo2).range(90.neg.degrad,90.degrad);///harm oscillator phase can vary across tones

harm=((Complex(cos(((sph.phi+mod_angle2).round(0.00001)*~mh).wrap((pi/2).neg,(pi/2))),cos(((sph.phi).round(0.00001)*~mh).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(~spread));

sphere=Spherical(28*harm,~az,~el);

n1=(sphere.x).round(0.00000001);n2=(sphere.y).round(0.00000001);n3=(sphere.z).round(0.00000001);
//ratio1=n1.round(1);ratio2=n2.round(1);ratio3=n3.round(1);
//ton1 = 2.pow(Select.kr(ratio1.linlin(28.neg, 28, 0, 56), scale) / 12);
//ton2 = 2.pow(Select.kr(ratio2.linlin(28.neg, 28, 0, 56), scale) / 12);
//ton3 = 2.pow(Select.kr(ratio3.linlin(28.neg, 28, 0, 56), scale) / 12);
ton1 = 2.pow(n1 / 12);ton2 = 2.pow(n2 / 12);ton3 = 2.pow(n3 / 12);
	amp1=(ton1.reciprocal*~octave.reciprocal*scalar.reciprocal*~lamdoma.reciprocal).round(0.00000001);
	amp2=(ton2.reciprocal*~octave.reciprocal*scalar.reciprocal*~lamdoma.reciprocal).round(0.00000001);
	amp3=(ton3.reciprocal*~octave.reciprocal*scalar.reciprocal*~lamdoma.reciprocal).round(0.00000001);

	pitch1=(freq1*ton1).round(0.0000001);pitch2=(freq1*ton2).round(0.0000001);pitch3=(freq1*ton3).round(0.0000001);

///magnitude and 4d rotation
mag=(Cartesian(mag_x,mag_y,mag_z).rho)+(Cartesian(mag_qx,mag_qy,mag_z).rho);

	v=Quaternion(0,sph.x,sph.y,sph.z);/// vector as quaternion

	coordinatesx=[1,0,0].normalizeSum.sqrt;coordinatesy=[0,1,0].normalizeSum.sqrt;coordinatesz=[0,0,1].normalizeSum.sqrt;

	i=Quaternion(0, coordinatesx.[0], 0, 0);j=Quaternion(0, 0, coordinatesx.[1], 0);k=Quaternion(0, 0, 0, coordinatesx.[2]);
	ii=Quaternion(0, coordinatesy.[0], 0, 0);jj=Quaternion(0, 0, coordinatesy.[1], 0);kk=Quaternion(0, 0, 0, coordinatesy.[2]);
	iii=Quaternion(0, coordinatesz.[0], 0, 0);jjj=Quaternion(0, 0, coordinatesz.[1], 0);kkk=Quaternion(0, 0, 0, coordinatesz.[2]);

axis1=(((i+j+k)*exp(Complex(0,1)*~rot_angle).imag)+exp(Complex(0,1)*~rot_angle).real); ////rotation vector with angle of rotatio and ijk xyz normalized components
v1=axis1*v*axis1.conjugate;

axis2=(((ii+jj+kk)*exp(Complex(0,1)*~rot_angle).imag)+exp(Complex(0,1)*~rot_angle).real);
v2=axis2*v1*axis2.conjugate;

axis3=(((iii+jjj+kkk)*exp(Complex(0,1)*~rot_angle).imag)+exp(Complex(0,1)*~rot_angle).real);
v3=axis3*v2*axis3.conjugate;

qsphe=Cartesian(v3.b,v3.c,v3.d).asSpherical;

///bpf oscillator basics
//sig=PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1,doneAction:2)*0.1;
			// osc1=VBAP.ar(4,BPF.ar(sig,pitch1,mul:amp1*mag,rq:rq),~b.bufnum,qsphe.theta.raddeg,
			// SinOsc.ar(cell,qsphe.phi).range(90.neg,90));
			// osc2=VBAP.ar(4,BPF.ar(sig,pitch2,mul:amp2*mag,rq:rq),~b.bufnum,qsphe.theta.raddeg,
			// SinOsc.ar(cell,qsphe.phi).range(90.neg,90));
			// osc3=VBAP.ar(4,BPF.ar(sig,pitch3,mul:amp3*mag,rq:rq),~b.bufnum,qsphe.theta.raddeg,
			// SinOsc.ar(cell,qsphe.phi).range(90.neg,90));

///oscillators
osc1=VBAP.ar(4,SinOsc.ar(pitch1,mul:amp1*mag,phase:phase),~b.bufnum,qsphe.theta.raddeg,
				SinOsc.ar(~cell,qsphe.phi).range(90.neg,90));
osc2=VBAP.ar(4,SinOsc.ar(pitch2,mul:amp2*mag,phase:phase),~b.bufnum,qsphe.theta.raddeg,
				SinOsc.ar(~cell,qsphe.phi).range(90.neg,90));
osc3=VBAP.ar(4,SinOsc.ar(pitch3,mul:amp3*mag,phase:phase),~b.bufnum,qsphe.theta.raddeg,
				SinOsc.ar(~cell,qsphe.phi).range(90.neg,90));

///ouput channels
Out.ar(0,LeakDC.ar(osc3,mul:0.01));
Out.ar(0,LeakDC.ar(osc2,mul:0.01));
Out.ar(0,LeakDC.ar(osc1,mul:0.01));

}.play;
);



s.meter;s.freqscope;s.scope;
}
)

/////////////control via GUI
(

Window.closeAll;
w=Window.new("gui",Rect.new(100,100,800,600)).front.alwaysOnTop_(true);

~aa = Slider.new(w.view,Rect.new(20,20,500,30));

~bb = Slider.new(w.view,Rect.new(20,60,500,30));

~cc = Slider2D.new(w.view,Rect.new(60,280,600,300));


~ee = Slider.new(w.view,Rect.new(20,140,500,30));

~ff = Slider.new(w.view,Rect.new(20,180,500,30));

~gg = Slider.new(w.view,Rect.new(20,220,500,30));

~on = Button(w,Rect(10,500,30,30)).states_([
			["off",Color.black,Color.gray],["on",Color.white,Color.gray]]).action_({
	arg obj;
	if(
		obj.value==1,{~synth=Synth.new(\ospace,[
	\gain,~aa.value,
	\lfo_amp,~bb.value.linlin(0,1,0.01,20).round(1/32),
	\spread,~ee.value.linlin(0,1,1,20),
	\ripple,~ff.value.linlin(0,1,0.0001,0.5),
	\amount,~gg.value.linlin(0,1,1,100).round(1),
\elevation,~cc.x.linlin(0,1,180.neg.degrad,180.degrad),
	\azimuth,~cc.y.linlin(0,1,90.neg.degrad,90.degrad)]).register},
		{~synth.free}
)});
(
a = StaticText(w, Rect(530,20,200, 20));
a.string = "gain";
b = StaticText(w, Rect(530,60,200, 20));
b.string = "spherical harmonic amp lfo";
d = StaticText(w, Rect(530,140,200, 20));
d.string = "spherical harmonic width";
e = StaticText(w, Rect(530,180,200, 20));
e.string = "ripple speed";
f = StaticText(w, Rect(530,220,200, 20));
f.string = "ripple waves";
g = StaticText(w, Rect(670,400,100, 70));
g.string = "3d tone coordinate (x_azimuth,
y_elevation)";
);

(
~aa.value_(1).action_({
	arg obj;
					var gain;
	obj.value.postln;
	gain=obj.value;
	if(~synth.isPlaying,{~synth.set(\gain,gain)});
});
);
(
~bb.value_(1).action_({
	arg obj;
			var lfo_amp;
	lfo_amp=obj.value.linlin(0,1,0.01,20).round(1/32);
				lfo_amp.value.postln;
		if(~synth.isPlaying,{~synth.set(\lfo_amp,lfo_amp)});
});
);
(
~cc.action_({
	arg obj;
			var az,el;
	az=obj.x.linlin(0,1,180.neg.degrad,180.degrad);
	el=obj.y.linlin(0,1,90.neg.degrad,90.degrad);
			if(~synth.isPlaying,{~synth.set(\azimuth,az,\elevation,el)});
});
);
(
~ee.action_({
	arg obj;
			var spread;
			spread=obj.value.linlin(0,1,1,20);
				spread.value.postln;
if(~synth.isPlaying,{~synth.set(\spread,spread)});
});
);
	(
~ff.action_({
	arg obj;
			var ripple;
			ripple=obj.value.linlin(0,1,0.0001,0.5);
				ripple.value.postln;
if(~synth.isPlaying,{~synth.set(\ripple,ripple)});
});
);
			(
~gg.action_({
	arg obj;
			var amount;
				amount=obj.value.linlin(0,1,1,100).round(1);
				amount.value.postln;
if(~synth.isPlaying,{~synth.set(\amount,amount)});
});
);
	);
	//s.meter;
}
)


s.record(numChannels:4);
