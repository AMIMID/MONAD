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


//////////pattern////analysis of the ssound-engine synth pattern, to convert some controls to values streams via the control synth

/*(
		~aa=Pdef(\1, Pbind(\instrument, \ospace,
			\dur,Pseq(~dur.abs/14,inf),///////////////////////////////////////////////////duration stays as it triggers the audio synth through the pattern in time, dur will be longer intervals to acomododate stream values on other controls. as such dur here does not define a note but a collection of notes, it can possible seen as one ore more bars, measures.

		\coo,Pseq(~dur,inf),  //sequence for major/minor fundamental multiplier////////

		//\mm,Prand([1,2,3,4,5,6,7,8,9,10],inf),
		\mm,Prand([1,2/1,3/2,4/3],inf),    //lamdoma interval multiplier/////////////////

		\mh,Prand([1],inf),     //spherical harmonic for tone bends//////////////////////

			\pl1,Pseq(~list,inf),    ///coordinate selection/////////////////////////////

			\pl2,Pseq(~list2,inf), ///+1coordinate for distance measurement//////////////

		\lfo,Pbrown(0.01,1/2,0.1,inf), //mag spherical harmonic oscillation/////////////

		\lfo2,Pbrown(0.0001,0.005,0.001,inf), //tone spherical harmonic oscillation/////

		\cell,Pbrown(0.01,1/4,0.1,inf), //speed of 4dimensional oscillation

		\rot_angle,Pseq(~angle,inf),//angle for filed rotation/////////////////////////

		\spread,Pbrown(0.1,2,1,inf),  //spherical harmonic width//////////////////////

		\ripple,Pbrown(0.001,0.1,0.01,inf),  //sphere ripple wave oscillation speed//

		\amount,Prand([4,5,6,7,8],inf),   //sphere ripple waves amount//////////////

		\varamp,Pbrown(0.1,2,0.1,inf), //ripple amp/////////////////////////////////

		\decay,Pbrown(4,8,1,inf),////////////////////////////////////////////////////

		\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),//outpu channel order randomizer///
		\out2,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),/////////////////
		\out3,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),////////////////

			\amp,Pseq(~r,inf);   ///l system////////////////////////////////////////
			//\amp,1;
)))*/