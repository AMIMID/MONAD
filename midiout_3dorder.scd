MIDIClient.init;

MIDIClient.destinations;
n = MIDIOut.new(0);

n.latency = 0;
n.noteOn.(0,60,30);  ///chan,note,velocity
n.noteOff(0,60);

freq=440.cpsmidi;