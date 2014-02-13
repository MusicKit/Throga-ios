
#import "MidiPlayer.h"

@interface MidiPlayer ()

@property (readwrite) AUGraph   processingGraph;
@property (readwrite) AudioUnit samplerUnit;
@property (readwrite) AudioUnit ioUnit;
@property (readwrite) Float64 graphSampleRate;

@property (readwrite) MusicPlayer musicPlayer;
@property (readwrite) MusicSequence sequence;

@end

@implementation MidiPlayer

@synthesize processingGraph     = _processingGraph;
@synthesize samplerUnit         = _samplerUnit;
@synthesize ioUnit              = _ioUnit;
@synthesize graphSampleRate		= _graphSampleRate;

@synthesize musicPlayer			= _musicPlayer;
@synthesize sequence			= _sequence;

NSInteger noteOffset = 0;

-(MidiPlayer *)init {
	
	// setup audio session
	[self setupAudioSession];
	
	// create the audio processing graph
	[self createAUGraph];
    [self configureAndStartAudioProcessingGraph: self.processingGraph];

	return self;
}

- (BOOL) setupAudioSession
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    NSError *audioSessionError = nil;
	
    [audioSession setCategory: AVAudioSessionCategoryPlayback error: &audioSessionError];
    if (audioSessionError != nil) {NSLog (@"Error setting audio session category."); return NO;}
    
    _graphSampleRate = 44100.0;
    
    [audioSession setPreferredSampleRate:_graphSampleRate error:&audioSessionError];
    if (audioSessionError != nil) {NSLog (@"Error setting preferred hardware sample rate."); return NO;}
    
    // Activate the audio session
    [audioSession setActive: YES error: &audioSessionError];
    if (audioSessionError != nil) {NSLog (@"Error activating the audio session."); return NO;}

    _graphSampleRate = [audioSession sampleRate];
    
    return YES;
}

- (BOOL) createAUGraph {
	
	OSStatus result = noErr;

	AUNode samplerNode, ioNode;

	AudioComponentDescription cd = {};
	cd.componentManufacturer     = kAudioUnitManufacturer_Apple;

	// Sampler
	cd.componentType = kAudioUnitType_MusicDevice;
	cd.componentSubType = kAudioUnitSubType_Sampler;
	
	// new AUGraph
	result = NewAUGraph (&_processingGraph);
	if (result != noErr) NSLog(@"Unable to create AUGraph. Error code: %d '%.4s'", (int) result, (const char *)&result);

	// add sampler node to AUGraph
	result = AUGraphAddNode (self.processingGraph, &cd, &samplerNode);
	if (result != noErr) NSLog(@"Unable to add sampler unit. Error code: %d '%.4s'", (int) result, (const char *)&result);

	// Output
	cd.componentType = kAudioUnitType_Output;
	cd.componentSubType = kAudioUnitSubType_RemoteIO;
	
	// add output node to AUGraph
	result = AUGraphAddNode (self.processingGraph, &cd, &ioNode);
	if (result != noErr) NSLog(@"Unable to add Output unit. Error code: %d '%.4s'", (int) result, (const char *)&result);

	// open AUGraph
	result = AUGraphOpen (self.processingGraph);
	if (result != noErr) NSLog(@"Unable to open AUGraph. Error code: %d '%.4s'", (int) result, (const char *)&result);

	// connect sample to AUGraph
	result = AUGraphConnectNodeInput (self.processingGraph, samplerNode, 0, ioNode, 0);
	if (result != noErr) NSLog(@"Unable to connect Input Node. Error code: %d '%.4s'", (int) result, (const char *)&result);

	// get reference to sample node
	result = AUGraphNodeInfo (self.processingGraph, samplerNode, 0, &_samplerUnit);
	if (result != noErr) NSLog(@"Unable to get Node info from sampler.. Error code: %d '%.4s'", (int) result, (const char *)&result);

	// get reference to output node
	result = AUGraphNodeInfo (self.processingGraph, ioNode, 0, &_ioUnit);
	if (result != noErr) NSLog(@"Unable to get Node info from ioUnit. Error code: %d '%.4s'", (int) result, (const char *)&result);

	return YES;

}

- (void) configureAndStartAudioProcessingGraph: (AUGraph) graph {

    OSStatus result = noErr;

    if (graph) {
		
		// initialize AUGraph
		result = AUGraphInitialize (graph);
		if (result != noErr) NSLog(@"Unable to initialize AUGraph. Error code: %d '%.4s'", (int) result, (const char *)&result);

		// start AUGraph
        result = AUGraphStart (graph);
		if (result != noErr) NSLog(@"Unable to start AUGraph. Error code: %d '%.4s'", (int) result, (const char *)&result);
	}
}

-(OSStatus) loadFromDLSOrSoundFont: (NSURL *)bankURL withPatch: (int)presetNumber {
    
    OSStatus result = noErr;
    
    // fill out a bank preset data structure
    AUSamplerBankPresetData bpdata;
	
    bpdata.bankURL  = (__bridge CFURLRef) bankURL;
    bpdata.bankMSB  = kAUSampler_DefaultMelodicBankMSB;
    bpdata.bankLSB  = kAUSampler_DefaultBankLSB;
    bpdata.presetID = (UInt8) presetNumber;
    
    // set the kAUSamplerProperty_LoadPresetFromBank property
    result = AudioUnitSetProperty(self.samplerUnit,
                                  kAUSamplerProperty_LoadPresetFromBank,
                                  kAudioUnitScope_Global,
                                  0,
                                  &bpdata,
                                  sizeof(bpdata));
    
    // check for errors
    NSCAssert (result == noErr,
               @"Unable to set the preset property on the Sampler. Error code:%d '%.4s'",
               (int) result,
               (const char *)&result);
    
    return result;
}

-(void)play:(NSString *)fileName withTempo:(NSInteger)tempo forNote:(NSInteger)note {
	
    OSStatus result = noErr;

//	NSLog(@"Playing : Tempo : %d, note: %d", tempo, note);

	noteOffset = note;
	
    MIDIClientRef virtualMidi;

    NewMusicSequence(&_sequence);

    NSString *midiFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mid"];

    NSURL * midiFileURL = [NSURL fileURLWithPath:midiFilePath];
    
    MusicSequenceFileLoad(_sequence, (__bridge CFURLRef) midiFileURL, 0, 0);
    
    NewMusicPlayer(&_musicPlayer);

    result = MIDIClientCreate(CFSTR("Virtual Client"), MyMIDINotifyProc, NULL, &virtualMidi);
	if (result != noErr) NSLog(@"Unable to create Virtual Client. Error code: %d '%.4s'", (int) result, (const char *)&result);
	
    MIDIEndpointRef virtualEndpoint;
    result = MIDIDestinationCreate(virtualMidi, (CFStringRef)@"Virtual Destination", MyMIDIReadProc, self.samplerUnit, &virtualEndpoint);
	if (result != noErr) NSLog(@"Unable to create Virtual Destination for Virtual Client. Error code: %d '%.4s'", (int) result, (const char *)&result);
	

    MusicSequenceSetMIDIEndpoint(_sequence, virtualEndpoint);

    NSURL *presetURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MiniPiano" ofType:@"SF2"]];
    [self loadFromDLSOrSoundFont: (NSURL *)presetURL withPatch: (int)1];

    MusicPlayerSetSequence(_musicPlayer, _sequence);
	
	MusicTrack tempoTrack;
	if (MusicSequenceGetTempoTrack(_sequence, &tempoTrack) != noErr) {
		if (result != noErr) NSLog(@"Unable to get Tempo track. Error code: %d '%.4s'", (int) result, (const char *)&result);
	}
	
	MusicTrackClear(tempoTrack, 0, 1);
	if (MusicTrackNewExtendedTempoEvent(tempoTrack, 0.0, tempo) != noErr) {
		if (result != noErr) NSLog(@"Unable to set Tempo track. Error code: %d '%.4s'", (int) result, (const char *)&result);
	}
	
    MusicPlayerPreroll(_musicPlayer);

    MusicPlayerStart(_musicPlayer);

    MusicTrack t;
    MusicTimeStamp len;
    UInt32 sz = sizeof(MusicTimeStamp);
    MusicSequenceGetIndTrack(_sequence, 1, &t);
    MusicTrackGetProperty(t, kSequenceTrackProperty_TrackLength, &len, &sz);

    while (1) { // kill time until the music is over
        usleep (2 * 1000 * 1000);
        MusicTimeStamp now = 0;
        MusicPlayerGetTime (_musicPlayer, &now);
        if (now >= len)
            break;
	}

	if (_musicPlayer != nil) {
		MusicPlayerStop(_musicPlayer);
	}
	if (_sequence != nil) {
		DisposeMusicSequence(_sequence);
	}
	if (_musicPlayer != nil) {
		DisposeMusicPlayer(_musicPlayer);
	}
//    MusicPlayerStop(_musicPlayer);
//    DisposeMusicSequence(_sequence);
//    DisposeMusicPlayer(_musicPlayer);
}

void MyMIDINotifyProc (const MIDINotification  *message, void *refCon) {
	NSLog(@"MIDI Notify, messageId = %d", (int)message->messageID);
}

-(void)stop {

	if (_musicPlayer != nil) {
		MusicPlayerStop(_musicPlayer);
	}
	if (_sequence != nil) {
		DisposeMusicSequence(_sequence);
	}
	if (_musicPlayer != nil) {
		DisposeMusicPlayer(_musicPlayer);
	}
}


static void MyMIDIReadProc(const MIDIPacketList *pktlist, void *refCon, void *connRefCon) {
    
    OSStatus result = noErr;

    AudioUnit *player = (AudioUnit*) refCon;
    
    MIDIPacket *packet = (MIDIPacket *)pktlist->packet;
	
    for (int i=0; i < pktlist->numPackets; i++) {

        Byte midiStatus = packet->data[0];

        Byte midiCommand = midiStatus >> 4;
        
        if (midiCommand == 0x09) {
			
            Byte note = packet->data[1] & 0x7F;
            Byte velocity = packet->data[2] & 0x7F;
			
			note = note + noteOffset;
			
            result = MusicDeviceMIDIEvent ((MusicDeviceComponent)player, midiStatus, note, velocity, 0);
			if (result != noErr) NSLog(@"Unable to play MusicDeviceMIDIEvent. Error code: %d '%.4s'", (int) result, (const char *)&result);
        }
        packet = MIDIPacketNext(packet);
    }
}

@end

















