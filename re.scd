(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=4;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*64;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.waitForBoot
)
(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme:cmrc/final/filtered/bees, war.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme:cmrc/final/filtered/bees, war.wav",channels:1 );

)

////speaker setup
/*(
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
);*/

(
{
var  sph1,sph2,sph3,sph4,sph5,sph6,m_x=3,m_y=3,m_z=3,qx,qy,mq=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z,mag_qx,mag_qy;
var az4=0,el4=0,az5=0,el5=0,az6=0,el6=0,az7=0,el7=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx=0,elx=0,azy=0,ely=0,azz=0,elz=0;
var num=1.neg;
var ellipsis=[1,1,1];
var spread=1;
	~dur=[];

durx=(360).collect{
			azx = (azx+1).wrap(180.neg,180);  // Increment azimuth
				elx = (elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphx=(Spherical(1,(azx.degrad),(elx.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).x.round(0.000000001).abs;

	};

dury=(360).collect{
		azy = (azy+1).wrap(180.neg,180);  // Increment azimuth
			ely = (ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphy=(Spherical(1,(azy.degrad),(ely.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).y.round(0.000000001).abs;

	};
durz=(360).collect{
			azz = (azz+1).wrap(180.neg,180);  // Increment azimuth
				elz = (elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphz=(Spherical(1,(azz.degrad),(elz.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).z.round(0.000000001).abs;

	};

~az=(360).collect{

			az1 = (az1+1).wrap(180.neg,180);  // Increment azimuth
				el1 = (el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);

	};

~el=(360).collect{

				az2 = (az2+1).wrap(180.neg,180);  // Increment azimuth
			el2 = (el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};


				360.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];}
}.value;
)


(
SynthDef.new(\o_reverb, {
    var in1,in2,in3,in4,chaina,chainb,chainc,chaind,b=0;
	var chainxx,chainyy,pl1=0,amp,mag,lfo;
	var chainaa,chainbb,chaincc,chaindd,chainee,chainff;
	var ph,frames=512,sig1,sig2,sig3,sig4,spread=1;
	var delay,decay,sph,mod_angle,mod_angle1,m=3,mq=2;
	var magx,magy,magz,mag_x,mag_y,mag_z,magqx,magqy,mag_qx,mag_qy;

     in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:0);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:0);
	// in3 = PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3.bufnum), loop: 0, doneAction:0);
	// in4 = PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4.bufnum), loop: 0, doneAction:0);
	/* in1 = SoundIn.ar(0);in2 = SoundIn.ar(1);
	 in3 = SoundIn.ar(2) in4 = SoundIn.ar(3);*/

	chaina = FFT(LocalBuf(frames), in1);chainb = FFT(LocalBuf(frames), in2);
	//chainc = FFT(LocalBuf(frames), in3);chaind = FFT(LocalBuf(frames), in4);

	lfo=0.1;
	mod_angle=LFNoise1.ar(lfo).range(90.neg.degrad,90.degrad);
	mod_angle1=LFNoise1.ar(lfo).range(90.neg.degrad,90.degrad);

	180.do{

		sph=Spherical(1,~az.[pl1],~el.[pl1]);
		(
		magx=((Complex(cos(((sph.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi)),cos((((sph.theta+mod_angle).round(0.00001)*m)).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
	(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
				);

magy=((Complex(sin(((sph.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi)),sin(((sph.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
				);

magz=((Complex(cos(((sph.phi+mod_angle).round(0.00001)*m).wrap((pi/2).neg,(pi/2))),cos(((sph.phi+mod_angle1).round(0.00001)*m).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

magqx=((((Complex(cos(((sph.theta.round(0.00001)+mod_angle)*mq).wrap(pi.neg,pi)),
cos(((sph.theta.round(0.00001)+mod_angle)*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);

 magqy=((((Complex(sin(((sph.theta.round(0.00001)+mod_angle1)*mq).wrap(pi.neg,pi)),
sin(((sph.theta.round(0.00001)+mod_angle1)*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);

				mag_x=magx.value;mag_y=magy.value;mag_z=magz.value;mag_qx=magqx.value;mag_qy=magqy.value
				);

mag=(Cartesian(mag_x,mag_y,mag_z).rho)+(Cartesian(mag_qx,mag_qy,mag_z).rho);
ph=Complex(sph.theta.linlin(pi.neg,pi,1.neg,1),sph.phi.linlin((pi/2).neg,(pi/2),1.neg,1)).theta;

chainaa = chaina.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
chainbb = chainb.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
//chaincc = chainc.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
//chaindd = chaind.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
b=b+1;

		/////for use in case of simple mono inputs
/*chainaa = chaina.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+ph)).theta]; },
frombin: b, tobin: b, zeroothers: 1);

chainbb = chainb.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+ph)).theta]; },
frombin: b, tobin: b, zeroothers: 1);

chaincc = chainc.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+ph)).theta]; },
frombin: b, tobin: b, zeroothers: 1);

chaindd = chaind.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+ph)).theta]; },
frombin: b, tobin: b, zeroothers: 1);

chainee = chaine.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+ph)).theta]; },
frombin: b, tobin: b, zeroothers: 1);

chainff = chainf.pvcollect(frames,
{|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+phase1)).theta]; },
frombin: b, tobin: b, zeroothers: 1);*/

delay=1;
decay=ph;

sig1=CombC.ar(IFFT(chainaa),maxdelaytime:delay,delaytime:delay,decaytime:decay);
sig2=CombC.ar(IFFT(chainbb),maxdelaytime:delay,delaytime:delay,decaytime:decay);
//sig3=CombC.ar(IFFT(chaincc),maxdelaytime:delay,delaytime:delay,decaytime:decay);
//sig4=CombC.ar(IFFT(chaindd),maxdelaytime:delay,delaytime:delay,decaytime:decay);

Out.ar(0,LeakDC.ar(sig1));Out.ar(1,LeakDC.ar(sig2));
//Out.ar(2,LeakDC.ar(sig3));Out.ar(3,LeakDC.ar(sig4));

pl1=pl1+1;};
}).add;
)


Synth(\o_reverb);
s.record(numChannels:4);
