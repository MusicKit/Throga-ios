
#import "PianoKeyboardView.h"

@implementation PianoKeyboardView

@synthesize keyDelegate;

@synthesize midiPlayer;
@synthesize audioPlayer;

@synthesize sequenceIsPlaying;
@synthesize countdownIsStopped;

@synthesize currentKeyView;
@synthesize currentExercise;

CGFloat currentVolume;
NSInteger currentSequenceDirection;

- (id)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {

		currentVolume = 0.5;
		sequenceIsPlaying = NO;
		countdownIsStopped = YES;
		
		currentSequenceDirection = SEQUENCE_DIRECTION_UP;
		
		[self layoutOctaves];
	}
	return self;
}

#pragma mark - Layout piano keyboard -

-(void)layoutKeyboardForOctave:(NSInteger)octaveNumber {
	
	NSInteger whiteKeyWidth = 42;
	NSInteger whiteKeyHeight = 120;

	NSInteger blackKeyWidth = 24;
	NSInteger blackKeyHeight = 70;
	
	NSInteger numberOfKeys = 7;

	NSInteger keyLabelHeight = 20;
	NSInteger keyLabelYValue = 100;
	
	if (IS_IPHONE5) {
		keyLabelYValue += 50;
		whiteKeyHeight += 40;
		blackKeyHeight += 30;
	}
	
	// create piano keys
	
	NSInteger keyStart = (octaveNumber * 42 * 7) + 30;
	
	NSMutableArray *pianoKeyViews = [[NSMutableArray alloc]initWithObjects:
								 
		[[PianoKeyView alloc]initWithFrame:CGRectMake( 0 * whiteKeyWidth + (octaveNumber * whiteKeyWidth * numberOfKeys), 0, whiteKeyWidth, whiteKeyHeight)],	// "F"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( keyStart, 0, blackKeyWidth, blackKeyHeight)],															// "F#"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( 1 * whiteKeyWidth + (octaveNumber * whiteKeyWidth * numberOfKeys), 0, whiteKeyWidth, whiteKeyHeight)],	// "G"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( keyStart + whiteKeyWidth, 0, blackKeyWidth, blackKeyHeight)],											// "G#"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( 2 * whiteKeyWidth + (octaveNumber * whiteKeyWidth * numberOfKeys), 0, whiteKeyWidth, whiteKeyHeight)],	// "A"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( keyStart + (whiteKeyWidth * 2), 0, blackKeyWidth, blackKeyHeight)],										// "A#"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( 3 * whiteKeyWidth + (octaveNumber * whiteKeyWidth * numberOfKeys), 0, whiteKeyWidth, whiteKeyHeight)],	// "B"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( 4 * whiteKeyWidth + (octaveNumber * whiteKeyWidth * numberOfKeys), 0, whiteKeyWidth, whiteKeyHeight)],	// "C"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( keyStart + (whiteKeyWidth * 4), 0, blackKeyWidth, blackKeyHeight)],										// "C#"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( 5 * whiteKeyWidth + (octaveNumber * whiteKeyWidth * numberOfKeys), 0, whiteKeyWidth, whiteKeyHeight)],	// "D"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( keyStart + (whiteKeyWidth * 5), 0, blackKeyWidth, blackKeyHeight)],										// "D#"
		[[PianoKeyView alloc]initWithFrame:CGRectMake( 6 * whiteKeyWidth + (octaveNumber * whiteKeyWidth * numberOfKeys), 0, whiteKeyWidth, whiteKeyHeight)],	// "E"
		nil];
	
	// set note and octave and set each view tag to next sequential number

	NSInteger noteValue = 1;
	
	for (PianoKeyView *keyView in pianoKeyViews ) {
		
		keyView.note = noteValue;
		keyView.octave = octaveNumber;
		
		keyView.tag = (octaveNumber * 12) + noteValue;
		[keyView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pianoKeyTapped:)]];
		noteValue += 1;
	}
	
	// set note label
	
	for (PianoKeyView *pianoKey in pianoKeyViews ) {
		switch (pianoKey.note) {
			case 1: {
				UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, keyLabelYValue, whiteKeyWidth, keyLabelHeight)];
				keyLabel.text = [NSString stringWithFormat:@"F%d", octaveNumber + 1];
				keyLabel.textAlignment = NSTextAlignmentCenter;
				keyLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
				[pianoKey addSubview:keyLabel];
				break;
			}
			case 3: {
				UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, keyLabelYValue, whiteKeyWidth, keyLabelHeight)];
				keyLabel.text = [NSString stringWithFormat:@"G%d", octaveNumber + 1];
				keyLabel.textAlignment = NSTextAlignmentCenter;
				keyLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
				[pianoKey addSubview:keyLabel];
				break;
			}
			case 5: {
				UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, keyLabelYValue, whiteKeyWidth, keyLabelHeight)];
				keyLabel.text = [NSString stringWithFormat:@"A%d", octaveNumber + 1];
				keyLabel.textAlignment = NSTextAlignmentCenter;
				keyLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
				[pianoKey addSubview:keyLabel];
				break;
			}
			case 7: {
				UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, keyLabelYValue, whiteKeyWidth, keyLabelHeight)];
				keyLabel.text = [NSString stringWithFormat:@"B%d", octaveNumber + 1];
				keyLabel.textAlignment = NSTextAlignmentCenter;
				keyLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
				[pianoKey addSubview:keyLabel];
				break;
			}
			case 8: {
				UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, keyLabelYValue, whiteKeyWidth, keyLabelHeight)];
				keyLabel.text = [NSString stringWithFormat:@"C%d", octaveNumber + 1];
				keyLabel.textAlignment = NSTextAlignmentCenter;
				keyLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
				[pianoKey addSubview:keyLabel];
				break;
			}
			case 10: {
				UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, keyLabelYValue, whiteKeyWidth, keyLabelHeight)];
				keyLabel.text = [NSString stringWithFormat:@"D%d", octaveNumber + 1];
				keyLabel.textAlignment = NSTextAlignmentCenter;
				keyLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
				[pianoKey addSubview:keyLabel];
				break;
			}
			case 12: {
				UILabel *keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, keyLabelYValue, whiteKeyWidth, keyLabelHeight)];
				keyLabel.text = [NSString stringWithFormat:@"E%d", octaveNumber + 1];
				keyLabel.textAlignment = NSTextAlignmentCenter;
				keyLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
				[pianoKey addSubview:keyLabel];
				break;
			}
			default:
				break;
		}
	}
	
	// add white keys to view
	
	for (PianoKeyView *pianoKey in pianoKeyViews ) {

		switch (pianoKey.note) {
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12: {
				pianoKey.layer.borderColor = [UIColor blackColor].CGColor;
				pianoKey.layer.borderWidth = 0.5;
				[self addSubview:pianoKey];
			}
			default:
				break;
		}
	}

	// add black keys to view
	
	for (PianoKeyView *pianoKey in pianoKeyViews ) {
		switch (pianoKey.note) {
			case 2:
			case 4:
			case 6:
			case 9:
			case 11:
				pianoKey.delegate = self;
				pianoKey.octave = octaveNumber;
				pianoKey.backgroundColor = [UIColor blackColor];
				[self addSubview:pianoKey];
				break;
				
			default:
				break;
		}
	}
}

-(void)layoutOctaves {
	
	for (NSInteger octave = 0; octave < 5; octave++) {
		[self layoutKeyboardForOctave:octave];
	}
}

-(void)resetKeyColors {

	for (UIView *view in [self subviews]) {
		if ([view isKindOfClass:[PianoKeyView class]]) {
			PianoKeyView *keyView = (PianoKeyView *)view;
			switch (keyView.note) {
				case 1:
				case 3:
				case 5:
				case 7:
				case 8:
				case 10:
				case 12:
					keyView.backgroundColor = [UIColor whiteColor];
					for (UIView *subview in [keyView subviews]) {
						if ([subview isKindOfClass:[UILabel class]]) {
							UILabel *textLabel = (UILabel *)subview;
							textLabel.textColor = [UIColor blackColor];
						}
					}
					break;
					
				default:
					keyView.backgroundColor = [UIColor blackColor];
					break;
			}
		}
	}
}

-(void)setColorForCurrentKey {

	[self resetKeyColors];
	
	currentKeyView.backgroundColor = [UIColor blueColor];

	for (UIView *view in [currentKeyView subviews]) {
		if ([view isKindOfClass:[UILabel class]]) {
			UILabel *textLabel = (UILabel *)view;
			textLabel.textColor = [UIColor whiteColor];
		}
	}
}

#pragma mark - Audio -

-(void)scrollKeyboardIfNecessary {
	
	[keyDelegate scrollKeyboardForCurrentKey:currentKeyView andCurrentDirection:currentSequenceDirection];
}

-(void)reverseDirectionIfNecessary {
	
	if (currentKeyView.tag == 60 && currentSequenceDirection == SEQUENCE_DIRECTION_UP) {
		
		[self stopMidiPlayer];
		currentSequenceDirection = SEQUENCE_DIRECTION_DOWN;
		currentKeyView = (PianoKeyView *)[self viewWithTag:59];
		[self startAudioForCurrentKey];
	}
	if (currentKeyView.tag == 1 && currentSequenceDirection == SEQUENCE_DIRECTION_DOWN) {
		
		[self stopMidiPlayer];
		currentSequenceDirection = SEQUENCE_DIRECTION_UP;
		currentKeyView = (PianoKeyView *)[self viewWithTag:2];
		[self startAudioForCurrentKey];
	}
}

-(void)updateKeyboard {

	[self performSelectorOnMainThread:@selector(setColorForCurrentKey) withObject:nil waitUntilDone:YES];
	[self performSelectorOnMainThread:@selector(scrollKeyboardIfNecessary) withObject:nil waitUntilDone:YES];
}

-(void)playAudioFile {

	NSString *noteFile = [NSString stringWithFormat:@"a-%d-%d-%d", currentExercise.id, currentKeyView.octave, currentKeyView.note];
    NSURL *url = [[NSBundle mainBundle] URLForResource:noteFile withExtension:@"aif"];

	if (url) {
		NSLog(@"Audio file exists : %@", url);
		
		audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
		audioPlayer.delegate = self;

		[audioPlayer setVolume:0.5];
		[audioPlayer prepareToPlay];
		[audioPlayer play];
	}
	else {
		NSLog(@"Audio file doesn't exist : %@", noteFile);
	}

}

-(void)playMidiSequence {
	
	midiPlayer = [[MidiPlayer alloc]init];
	
//	NSLog(@">>> %@", currentKeyView);
//	NSLog(@">>> %@", currentExercise);
//	NSLog(@">>> %d", currentSequenceDirection);

	if (currentSequenceDirection == SEQUENCE_DIRECTION_UP) {

		for (NSInteger note = currentKeyView.tag; note <= 60; note++) {
			
			if (sequenceIsPlaying) {

				currentKeyView = (PianoKeyView *)[self viewWithTag:note];
				
				[self performSelectorOnMainThread:@selector(updateKeyboard) withObject:nil waitUntilDone:YES];
				[self performSelectorOnMainThread:@selector(scrollKeyboardIfNecessary) withObject:nil waitUntilDone:YES];

				NSString *midiPattern = [NSString stringWithFormat:@"pattern-%d", currentExercise.id];
				NSInteger tempo = [currentExercise.tempo integerValue];
				
				[self performSelectorOnMainThread:@selector(playAudioFile) withObject:nil waitUntilDone:NO];

				[midiPlayer play:midiPattern withTempo:tempo forNote:note];
				
				[self performSelectorOnMainThread:@selector(reverseDirectionIfNecessary) withObject:nil waitUntilDone:YES];
			}
		}
	}
	else {
		
		for (NSInteger note = currentKeyView.tag; note >= 1; note--) {
			
			if (sequenceIsPlaying) {

				currentKeyView = (PianoKeyView *)[self viewWithTag:note];
					
				[self performSelectorOnMainThread:@selector(setColorForCurrentKey) withObject:nil waitUntilDone:YES];
				[self performSelectorOnMainThread:@selector(scrollKeyboardIfNecessary) withObject:nil waitUntilDone:YES];
			
				NSString *midiPattern = [NSString stringWithFormat:@"pattern-%d", currentExercise.id];
				NSInteger tempo = [currentExercise.tempo integerValue];
				
				[self performSelectorOnMainThread:@selector(playAudioFile) withObject:nil waitUntilDone:NO];
				
				[midiPlayer play:midiPattern withTempo:tempo forNote:note];
				
				[self performSelectorOnMainThread:@selector(reverseDirectionIfNecessary) withObject:nil waitUntilDone:YES];
			}
		}
	}
}

-(void)stopMidiPlayer {

	[midiPlayer stop];
	[audioPlayer stop];

	sequenceIsPlaying = NO;
	[keyDelegate setPlayButtonToStopped];

}

-(void)pianoKeyTapped:(UIGestureRecognizer *)recognizer {

	[self stopMidiPlayer];
	
	currentKeyView = (PianoKeyView *)recognizer.view;
	
	if (countdownIsStopped) {
		[keyDelegate startCountdownTimer];
	}
	[self startAudioForCurrentKey];
}

-(void)setUserVolume:(CGFloat)value {
	
	currentVolume = value;

//	[self.midiPlayer setVolume:currentVolume];
//	[self.audioPlayer setVolume:currentVolume];
}

-(void)startAudioForCurrentKey {
	
	sequenceIsPlaying = YES;
	[keyDelegate setPlayButtonToPlaying];
	
	NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(playMidiSequence) object:nil];
	[thread start];
}

#pragma mark - WarmupViewController Delegates -

-(void)playAudio {

	if (currentKeyView == nil) {
		currentKeyView = (PianoKeyView *)[self viewWithTag:1];
	}
	[self startAudioForCurrentKey];
}

-(void)stopAudio {
	
	[self stopMidiPlayer];
}

-(void)setSequenceDirectionUp {

	if (currentSequenceDirection != SEQUENCE_DIRECTION_UP) {
	
		currentSequenceDirection = SEQUENCE_DIRECTION_UP;

		if (sequenceIsPlaying) {
			[self stopAudio];
			[self playAudio];
		}
	}
}

-(void)setSequenceDirectionDown {

	if (currentSequenceDirection != SEQUENCE_DIRECTION_DOWN) {
		
		currentSequenceDirection = SEQUENCE_DIRECTION_DOWN;

		if (sequenceIsPlaying) {
			[self stopAudio];
			[self playAudio];
		}
	}
}

#pragma mark - AudioPlayer Delegate -

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	
}

@end
