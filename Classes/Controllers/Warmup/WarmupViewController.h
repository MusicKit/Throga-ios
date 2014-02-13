
#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "PianoKeyboardView.h"

@interface WarmupViewController : UIViewController <UIScrollViewDelegate, PianoKeyboardViewDelegate> {
	
	id delegate;
	id keyDelegate;
	
	UIView *keyboardView;
	PianoKeyboardView *pianoKeyboardView;
	
	UIButton *playButton;
	
	NSInteger countdownSeconds;
	UILabel *minutesSecondsCounter;
	
	NSInteger currentNote;
	NSInteger currentOctave;
	
	UISlider *volumeSlider;
	
	UIView *flexibilityBarView;
	UIView *breathingBarView;
	UIView *intonationBarView;
	UIView *rangeBarView;
	UIView *toneBarView;
	UIView *articulationBarView;
	UIView *strengthBarView;

	UIButton *upArrowButton;
	UIButton *downArrowButton;

	UIButton *previousExerciseButton;
	UIButton *nextExerciseButton;
	
	UILabel *exerciseName;
	UILabel *exerciseFormant;
	UILabel *exerciseFeature;
	UILabel *exerciseVariable;
	
	UILabel *octaveNumber;
//	BOOL sequenceIsStopped;
	BOOL sequenceIsPlaying;
	
}
@property id delegate;
@property id keyDelegate;

@property IBOutlet UIView *keyboardView;
@property PianoKeyboardView *pianoKeyboardView;

@property IBOutlet UILabel *minutesSecondsCounter;
@property NSInteger countdownSeconds;

@property IBOutlet UIButton *playButton;

@property NSInteger currentNote;
@property NSInteger currentOctave;

@property IBOutlet UIButton *upArrowButton;
@property IBOutlet UIButton *downArrowButton;

@property IBOutlet UISlider *volumeSlider;

@property IBOutlet UIView *flexibilityBarView;
@property IBOutlet UIView *breathingBarView;
@property IBOutlet UIView *intonationBarView;
@property IBOutlet UIView *rangeBarView;
@property IBOutlet UIView *toneBarView;
@property IBOutlet UIView *articulationBarView;
@property IBOutlet UIView *strengthBarView;

@property IBOutlet UILabel *exerciseName;
@property IBOutlet UILabel *exerciseFormant;
@property IBOutlet UILabel *exerciseFeature;
@property IBOutlet UILabel *exerciseVariable;

@property IBOutlet UILabel *octaveNumber;

@property IBOutlet UIButton *previousExerciseButton;
@property IBOutlet UIButton *nextExerciseButton;

-(IBAction)didSelectPlayOrPause:(id)sender;
-(IBAction)didSelectUpArrow:(id)sender;
-(IBAction)didSelectDownArrow:(id)sender;

-(IBAction)didSelectPreviousExercise:(id)sender;
-(IBAction)didSelectNextExercise:(id)sender;


@end
