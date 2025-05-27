~controlBus_m = Bus.control(s, 1);

(

{
var n1,n2, tone1, tone2, sig, degree,m,scale,nn=8.neg,r;

	scale=15.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};
//scale.postln;
	r=SinOsc.kr(0.1,phase:0.degrad).range(pi.neg,pi);
//n1=SinOsc.kr(0.1,phase:0.degrad).range(7.neg,7).round(1);
	//n1=LFNoise0.kr(1).range(12.neg,12).round(1);
	//n1=SinOsc.kr(0.1,phase:0.degrad).range(12.neg,12).round(1);
	//n2=SinOsc.kr(0.1,phase:90.degrad).range(12.neg,12).round(1);
		//Out.kr(~controlBus_m.index, n);

	n1=Spherical(7,r,MouseX.kr(0,90).round(10).degrad).x.round(1);
	tone1= 2.pow(Select.kr(n1.linlin(7.neg, 7, 0, 14), scale) / 12);
	//tone1=2.pow(n1/12);
	//tone2=2.pow(n2/12);
	n1.poll;
	//	m=~controlBus_m.getSynchronous;
//	tone=Scale.major.performDegreeToKey(m,12).poll;
	//Out.ar(0,SinOsc.ar(440*tone1+n1,phase:0.degrad,mul:tone1.reciprocal)*0.1);
	Out.ar(0,SinOsc.ar(440*tone1,phase:0.degrad,mul:tone1.reciprocal)*0.1);
	//Out.ar(1,SinOsc.ar(440*tone2+n2,phase:90.degrad,mul:tone2.reciprocal)*0.1);
	//Out.ar(1,SinOsc.ar(440*tone2,phase:90.degrad,mul:tone2.reciprocal)*0.1);

}.play
)