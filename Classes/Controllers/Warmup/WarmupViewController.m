
#import "WarmupViewController.h"

@implementation WarmupViewController

@synthesize delegate;

@synthesize keyboardView;
@synthesize pianoKeyboardView;

@synthesize playButton;

@synthesize countdownSeconds;
@synthesize minutesSecondsCounter;

@synthesize keyDelegate;

@synthesize currentOctave;
@synthesize currentNote;

@synthesize volumeSlider;

@synthesize flexibilityBarView;
@synthesize breathingBarView;
@synthesize intonationBarView;
@synthesize rangeBarView;
@synthesize toneBarView;
@synthesize articulationBarView;
@synthesize strengthBarView;

@synthesize exerciseName;
@synthesize exerciseFormant;
@synthesize exerciseFeature;
@synthesize exerciseVariable;

@synthesize octaveNumber;

@synthesize upArrowButton;
@synthesize downArrowButton;

@synthesize previousExerciseButton;
@synthesize nextExerciseButton;

NSTimer *countdownTimer;
NSInteger elapsedSeconds;

NSArray *exercises;
NSInteger currentExerciseIndex;

#define BAR_1_COLOR @"072c71"
#define BAR_2_COLOR @"0a3fa2"
#define BAR_3_COLOR @"1d5ccd"
#define BAR_4_COLOR @"3f8fe4"
#define BAR_5_COLOR @"1ca0de"
#define BAR_6_COLOR @"57b8e6"
#define BAR_7_COLOR @"96d5f0"

#define STOPPED 1
#define PLAYING 2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		sequenceIsPlaying = NO;
    }
    return self;
}

#pragma mark - Exercises -

-(void)showExerciseInfo {
	
	CGRect frame;
	
	Exercise *exercise = [exercises objectAtIndex:currentExerciseIndex];
	
	exerciseName.text = exercise.name;
	exerciseFormant.text = exercise.formant;
	exerciseFeature.text = exercise.feature;
	
	NSMutableDictionary *barValues = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
									  [NSNumber numberWithInt:exercise.flexibility], @"flexibility",
									  [NSNumber numberWithInt:exercise.breathing], @"breathing",
									  [NSNumber numberWithInt:exercise.intonation], @"intonation",
									  [NSNumber numberWithInt:exercise.range], @"range",
									  [NSNumber numberWithInt:exercise.tone], @"tone",
									  [NSNumber numberWithInt:exercise.articulation], @"articulation",
									  [NSNumber numberWithInt:exercise.strength],@"strength",
									  nil];
	
	NSArray *barArray = [barValues keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
		
		if ([obj1 integerValue] > [obj2 integerValue]) {
			return (NSComparisonResult)NSOrderedAscending;
		}
		if ([obj1 integerValue] < [obj2 integerValue]) {
			return (NSComparisonResult)NSOrderedDescending;
		}
		return (NSComparisonResult)NSOrderedSame;
	}];
	
	NSMutableDictionary *barFrames =[[NSMutableDictionary alloc]initWithObjectsAndKeys:
									 flexibilityBarView, @"flexibility",
									 breathingBarView, @"breathing",
									 intonationBarView, @"intonation",
									 rangeBarView, @"range",
									 toneBarView, @"tone",
									 articulationBarView, @"articulation",
									 strengthBarView,@"strength",
									 nil];
	
	UIColor *barColor;
	NSInteger position = 0;
	
	// color code the seven bars
	
	for (NSString *name in barArray) {
		
		switch (position) {
			case 0:
				barColor = [UIColor colorWithHexString:BAR_1_COLOR];
				break;
			case 1:
				barColor = [UIColor colorWithHexString:BAR_2_COLOR];
				break;
			case 2:
				barColor = [UIColor colorWithHexString:BAR_3_COLOR];
				break;
			case 3:
				barColor = [UIColor colorWithHexString:BAR_4_COLOR];
				break;
			case 4:
				barColor = [UIColor colorWithHexString:BAR_5_COLOR];
				break;
			case 5:
				barColor = [UIColor colorWithHexString:BAR_6_COLOR];
				break;
			case 6:
				barColor = [UIColor colorWithHexString:BAR_7_COLOR];
				break;
			default:
				break;
		}
		
		NSString *barName = [barArray objectAtIndex:position];
		UIView *barFrame = [barFrames objectForKey:barName];
		barFrame.backgroundColor = barColor;
		position += 1;
	}
	
	NSInteger frameOrigin = 55;
	NSInteger frameHeight = 2;
	
	frame = flexibilityBarView.frame;
	frame.origin.y = frameOrigin;
	frame.size.height = frameHeight;
	flexibilityBarView.frame = CGRectMake(frame.origin.x, frame.origin.y - exercise.flexibility, frame.size.width, frame.size.height + exercise.flexibility);
	
	frame = breathingBarView.frame;
	frame.origin.y = frameOrigin;
	frame.size.height = frameHeight;
	breathingBarView.frame = CGRectMake(frame.origin.x, frame.origin.y - exercise.breathing, frame.size.width, frame.size.height + exercise.breathing);
	
	frame = intonationBarView.frame;
	frame.origin.y = frameOrigin;
	frame.size.height = frameHeight;
	intonationBarView.frame = CGRectMake(frame.origin.x, frame.origin.y - exercise.intonation, frame.size.width, frame.size.height + exercise.intonation);
	
	frame = rangeBarView.frame;
	frame.origin.y = frameOrigin;
	frame.size.height = frameHeight;
	rangeBarView.frame = CGRectMake(frame.origin.x, frame.origin.y - exercise.range, frame.size.width, frame.size.height + exercise.range);
	
	frame = toneBarView.frame;
	frame.origin.y = frameOrigin;
	frame.size.height = frameHeight;
	toneBarView.frame = CGRectMake(frame.origin.x, frame.origin.y - exercise.tone, frame.size.width, frame.size.height + exercise.tone);
	
	frame = articulationBarView.frame;
	frame.origin.y = frameOrigin;
	frame.size.height = frameHeight;
	articulationBarView.frame = CGRectMake(frame.origin.x, frame.origin.y - exercise.articulation, frame.size.width, frame.size.height + exercise.articulation);
	
	frame = strengthBarView.frame;
	frame.origin.y = frameOrigin;
	frame.size.height = frameHeight;
	strengthBarView.frame = CGRectMake(frame.origin.x, frame.origin.y - exercise.strength, frame.size.width, frame.size.height + exercise.strength);
}

#pragma mark - Actions -

-(void)setPlayButtonToPlaying {
	
	[playButton setImage:[UIImage imageNamed:@"pause_icon.png"] forState:UIControlStateNormal];
	playButton.tag = PLAYING;
}

-(void)setPlayButtonToStopped {
	
	[playButton setImage:[UIImage imageNamed:@"play_icon.png"] forState:UIControlStateNormal];
	playButton.tag = STOPPED;
}

-(IBAction)didSelectPlayOrPause:(id)sender {
	
	if (playButton.tag == PLAYING) {
//		playButton.tag = STOPPED;
//		[playButton setImage:[UIImage imageNamed:@"play_icon.png"] forState:UIControlStateNormal];

		[self setPlayButtonToStopped];
		[pianoKeyboardView stopAudio];
		[self stopCountdownTimer];
	}
	else {
//		playButton.tag = PLAYING;
//		[playButton setImage:[UIImage imageNamed:@"pause_icon.png"] forState:UIControlStateNormal];

		[self setPlayButtonToPlaying];
		[pianoKeyboardView playAudio];
		[self startCountdownTimer];
	}
}

-(IBAction)didSelectUpArrow:(id)sender {
	
	[upArrowButton setImage:[UIImage imageNamed:@"up_arrow_gray.png"] forState:UIControlStateNormal];
	[downArrowButton setImage:[UIImage imageNamed:@"down_arrow_white.png"] forState:UIControlStateNormal];
	
	[pianoKeyboardView setSequenceDirectionUp];
}

-(IBAction)didSelectDownArrow:(id)sender {
	
	[upArrowButton setImage:[UIImage imageNamed:@"up_arrow_white.png"] forState:UIControlStateNormal];
	[downArrowButton setImage:[UIImage imageNamed:@"down_arrow_gray.png"] forState:UIControlStateNormal];
	
	[pianoKeyboardView setSequenceDirectionDown];
}

-(IBAction)didSelectNextExercise:(id)sender {
	
	currentExerciseIndex += 1;
	
	if (currentExerciseIndex > 0) {
		previousExerciseButton.enabled = YES;
		[previousExerciseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
	}
	else {
		previousExerciseButton.enabled = NO;
		[previousExerciseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
	}
	
	if (currentExerciseIndex < [exercises count] - 1) {
		nextExerciseButton.enabled = YES;
		[nextExerciseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	else {
		nextExerciseButton.enabled = NO;
		[nextExerciseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
	}
	[self showExerciseInfo];
	[pianoKeyboardView setCurrentExercise:[exercises objectAtIndex:currentExerciseIndex]];
	
	[pianoKeyboardView stopAudio];
	[self stopCountdownTimer];
}

-(IBAction)didSelectPreviousExercise:(id)sender {
	
	currentExerciseIndex -= 1;
	
	if (currentExerciseIndex < 1) {
		previousExerciseButton.enabled = NO;
		[previousExerciseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
	}
	else {
		nextExerciseButton.enabled = YES;
		[nextExerciseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
	[self showExerciseInfo];
	[pianoKeyboardView setCurrentExercise:[exercises objectAtIndex:currentExerciseIndex]];
	
	[pianoKeyboardView stopAudio];
	[self stopCountdownTimer];
	//	[pianoKeyboardView playAudio];
}

-(void)sliderUpdated:(id)sender {
	
	UISlider *slider = sender;
	
	[pianoKeyboardView setUserVolume:slider.value];
}

#pragma mark - Countdown Timer -

-(void)showAlertView {
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Throga" message: @"Congratulations!  You've completed the exercise" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	[alert show];
	
	[pianoKeyboardView resetKeyColors];
}

- (void)updateCountdownTimer {
	
	elapsedSeconds = elapsedSeconds - 1;
	
	if (elapsedSeconds < 0) {
		
		minutesSecondsCounter.text = [NSString stringWithFormat:@"%2d:%02d", 0, 0];
		[countdownTimer invalidate];
		[pianoKeyboardView stopAudio];
		
		[self showAlertView];
	}
	else {
		NSInteger minutes = elapsedSeconds / 60;
		NSInteger seconds = elapsedSeconds % 60;
		
		minutesSecondsCounter.text = [NSString stringWithFormat:@"%2d:%02d", minutes, seconds];
	}
}

-(void)startCountdownTimer {
	
	[countdownTimer invalidate];
	
	if (elapsedSeconds <= 0) {
		elapsedSeconds = countdownSeconds;
	}
	
	countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1
													  target:self
													selector:@selector(updateCountdownTimer)
													userInfo:nil
													 repeats:YES];
}

-(void)stopCountdownTimer {
	
	[countdownTimer invalidate];
}

#pragma mark - View Lifecycle -

- (void)viewDidAppear:(BOOL)animated {
	
    [super viewDidAppear:animated];
	
	[self showExerciseInfo];
}

- (void)viewDidDisappear:(BOOL)animated {
	
    [super viewDidDisappear:animated];
	[pianoKeyboardView stopAudio];
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:18.0];
	label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
	label.textAlignment = NSTextAlignmentCenter;
	label.textColor = [UIColor whiteColor];

	self.navigationItem.titleView = label;
	label.text = NSLocalizedString(@"Warmup", @"");
	[label sizeToFit];
	
	[self setPlayButtonToStopped];
	
	previousExerciseButton.enabled = NO;
	[previousExerciseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
	
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	Database *database = appDelegate.throgaDatabase;
	
	exercises = [database exerciseByTypeID:1];
	
	[volumeSlider addTarget:self action:@selector(sliderUpdated:) forControlEvents:UIControlEventValueChanged];
	
	// debug purposes
//	if (countdownSeconds == 60) {
//		countdownSeconds = 10;
//	}
	
	elapsedSeconds = countdownSeconds;
	
	NSInteger minutes = elapsedSeconds / 60;
	NSInteger seconds = elapsedSeconds % 60;
	
	minutesSecondsCounter.text = [NSString stringWithFormat:@"%2d:%02d", minutes, seconds];
	
	keyboardView.backgroundColor = [UIColor whiteColor];
	
	if (IS_IPHONE5) {
		pianoKeyboardView = [[PianoKeyboardView alloc]initWithFrame:CGRectMake(0, 0, 42 * 7, 150 + 40)];
	}
	else {
		pianoKeyboardView = [[PianoKeyboardView alloc]initWithFrame:CGRectMake(0, 0, 42 * 7, 150)];
	}
  	pianoKeyboardView.keyDelegate = self;
	
	pianoKeyboardView.pagingEnabled = YES;
	pianoKeyboardView.contentSize = CGSizeMake(42 * 7 * 5, 150);
	pianoKeyboardView.delegate = self;
	
	pianoKeyboardView.currentExercise = [exercises objectAtIndex:0];
	
	[keyboardView addSubview:pianoKeyboardView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	
	NSInteger octave = 0;
	
	if (scrollView.contentOffset.x < 42 * 7) {
		octave = 0;
	}
	else if (scrollView.contentOffset.x < 42 * 7 * 2) {
		octave = 1;
	}
	else if (scrollView.contentOffset.x < 42 * 7 * 3) {
		octave = 2;
	}
	else if (scrollView.contentOffset.x < 42 * 7 * 4) {
		octave = 3;
	}
	else if (scrollView.contentOffset.x < 42 * 7 * 5) {
		octave = 4;
	}
	octaveNumber.text = [NSString stringWithFormat:@"%d", octave + 1];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	if (currentKeyView != nil) {
		currentKeyView.backgroundColor = [UIColor blueColor];
		for (UIView *view in [currentKeyView subviews]) {
			if ([view isKindOfClass:[UILabel class]]) {
				UILabel *textLabel = (UILabel *)view;
				textLabel.textColor = [UIColor whiteColor];
			}
		}
	}
}

PianoKeyView *currentKeyView;

-(void)scrollKeyboardForCurrentKey:(PianoKeyView *)keyView andCurrentDirection:(NSInteger)direction {
	
	//	// shift scrollview forward or backward if necessary
	//
	if ( (direction == SEQUENCE_DIRECTION_UP && keyView.note == 1) || (direction == SEQUENCE_DIRECTION_DOWN && keyView.note == 12) ) {
		
		NSLog(@"scroll keyboard : %d", direction);
		
		CGPoint keyboardOffset = CGPointMake(42 * 7 * keyView.octave, pianoKeyboardView.contentOffset.y);
		[pianoKeyboardView setContentOffset:keyboardOffset animated:YES];
		currentKeyView = keyView;
	}
}

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
}

@end
