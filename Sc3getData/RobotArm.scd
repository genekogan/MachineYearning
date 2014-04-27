// PRINCETON ROBOT ARM

s.boot

(
~buf1 = Buffer.alloc(s, 2048);
~buf2 = Buffer.alloc(s, 2048);
~buf3 = Buffer.alloc(s, 2048);
~buf4 = Buffer.alloc(s, 2048);
~buf5 = Buffer.alloc(s, 2048);
~buf6 = Buffer.alloc(s, 2048);

// fake examples for testing
~example1 = Buffer.read(s, "/Users/Gene/Projects/MachineYearning/media/RobotArm.wav");
~example2 = Buffer.read(s, "/Users/Gene/Projects/MachineYearning/media/draftmasters-01.wav");
~example3 = Buffer.read(s, "/Users/Gene/Projects/MachineYearning/media/draftmasters-02.wav");
~example4 = Buffer.read(s, "/Users/Gene/Projects/MachineYearning/media/RobotArm.wav");
~example5 = Buffer.read(s, "/Users/Gene/Projects/MachineYearning/media/draftmasters-01.wav");
~example6 = Buffer.read(s, "/Users/Gene/Projects/MachineYearning/media/draftmasters-02.wav");

// communicate with processing
m = NetAddr("localhost", 12000);

// parameter buses from processing
~busPitchAmpThresh = Bus.control(s, 1);
~busPitchMedian = Bus.control(s, 1);
~busDecayCoeff = Bus.control(s, 1);
~busOscRate = Bus.control(s, 1);
OSCFunc({arg msg; ~busPitchAmpThresh.set(msg[1]); ("pitchAmpThresh "+msg[1]).postln; }, '/pitchAmpThresh', nil);
OSCFunc({arg msg; ~busPitchMedian.set(msg[1]); ("pitchMedian "+msg[1]).postln; }, '/pitchMedian', nil);
OSCFunc({arg msg; ~busDecayCoeff.set(msg[1]); ("decayCoeff "+msg[1]).postln; }, '/decayCoeff', nil);
OSCFunc({arg msg; ~busOscRate.set(msg[1]); ("oscRate "+msg[1]).postln; }, '/oscRate', nil);

SynthDef(\tracker, {
	var pitchAmpThresh, pitchMedian, decayCoeff, ampThresh, oscRate,
	    in1, in2, in3, in4, in5, in6,
    	freq1, freq2, freq3, freq4, freq5, freq6,
	    env1, env2, env3, env4, env5, env6, vals;

	// get parameters
	pitchAmpThresh = In.kr(~busPitchAmpThresh);
	pitchMedian = In.kr(~busPitchMedian);
	decayCoeff = In.kr(~busDecayCoeff);
	oscRate = In.kr(~busOscRate);

/*
	in1 = PlayBuf.ar(1, ~example1);
	in2 = PlayBuf.ar(1, ~example2);
	in3 = PlayBuf.ar(1, ~example3);
	in4 = PlayBuf.ar(1, ~example4);
	in5 = PlayBuf.ar(1, ~example5);
	in6 = PlayBuf.ar(1, ~example6);
*/
	in1 = SoundIn.ar(0, 1);
	in2 = SoundIn.ar(1, 1);
	in3 = SoundIn.ar(2, 1);
	in4 = SoundIn.ar(3, 1);
	in5 = SoundIn.ar(4, 1);
	in6 = SoundIn.ar(5, 1);

	freq1 = Pitch.kr(in1, ampThreshold: pitchAmpThresh, median: pitchMedian)[0];
	freq2 = Pitch.kr(in2, ampThreshold: pitchAmpThresh, median: pitchMedian)[0];
	freq3 = Pitch.kr(in3, ampThreshold: pitchAmpThresh, median: pitchMedian)[0];
	freq4 = Pitch.kr(in4, ampThreshold: pitchAmpThresh, median: pitchMedian)[0];
	freq5 = Pitch.kr(in5, ampThreshold: pitchAmpThresh, median: pitchMedian)[0];
	freq6 = Pitch.kr(in6, ampThreshold: pitchAmpThresh, median: pitchMedian)[0];

	env1 = EnvFollow.kr(in1, decayCoeff);
	env2 = EnvFollow.kr(in2, decayCoeff);
	env3 = EnvFollow.kr(in3, decayCoeff);
	env4 = EnvFollow.kr(in4, decayCoeff);
	env5 = EnvFollow.kr(in5, decayCoeff);
	env6 = EnvFollow.kr(in6, decayCoeff);

	vals = [env1, env2, env3, env4, env5, env6, freq1, freq2, freq3, freq4, freq5, freq6];
	SendReply.kr(Impulse.kr(oscRate), '/stats', vals, 0);
	Out.ar(0, 2.0*(in1+in2+in3+in4+in5+in6)!2);
	//Out.ar(0, in1!2);
}).add;

OSCFunc({ arg msg;
	m.sendMsg("/robotTracker",
		msg[3], msg[4], msg[5], msg[6], msg[7], msg[8],
		msg[9], msg[10], msg[11], msg[12], msg[13], msg[14]);
}, '/stats');
)

Synth(\tracker);


{ SoundIn.ar([0, 1]) }.play