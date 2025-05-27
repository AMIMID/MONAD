~controlBus_m = Bus.control(s, 1);

(

{
var n, tone, sig, degree,m;

	n=SinOsc.kr(0.1,phase:0.degrad).range(24.neg,24).round(1);
		//Out.kr(~controlBus_m.index, n);
	tone=2.pow(n/12);
	n.poll;
	//	m=~controlBus_m.getSynchronous;
//	tone=Scale.major.performDegreeToKey(m,12).poll;
	Out.ar(0,SinOsc.ar(440*tone+n,mul:tone.reciprocal)*0.1);
	Out.ar(1,SinOsc.ar(440*tone,mul:tone.reciprocal)*0.1);

}.play
)