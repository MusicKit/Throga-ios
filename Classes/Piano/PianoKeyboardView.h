
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "PianoKeyView.h"
#import "UIColor+Tools.h"
#import "MidiPlayer.h"

#import "Database.h"

#define SEQUENCE_DIRECTION_UP 1
#define SEQUENCE_DIRECTION_DOWN 2

@protocol PianoKeyboardViewDelegate <NSObject>
//-(void)setSequenceIsPlaying;

-(void)startCountdownTimer;
-(void)stopCountdownTimer;
//-(void)togglePlayButton;
-(void)setPlayButtonToPlaying;
-(void)setPlayButtonToStopped;

-(void)scrollKeyboardForCurrentKey:(PianoKeyView *)keyView andCurrentDirection:(NSInteger)direction;

@end

@interface PianoKeyboardView : UIScrollView <AVAudioPlayerDelegate> {

	id keyDelegate;
	
	PianoKeyView *currentKeyView;
	
	MidiPlayer *midiPlayer;
	AVAudioPlayer *audioPlayer;
	
	Exercise *currentExercise;

	BOOL sequenceIsPlaying;
	BOOL countdownIsStopped;

//	NSInteger sequenceDirection;
}

@property id keyDelegate;

@property BOOL sequenceIsPlaying;
@property BOOL countdownIsStopped;

//@property NSInteger sequenceDirection;

@property PianoKeyView *currentKeyView;

@property (nonatomic, strong) AVAudioPlayer *notePlayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (nonatomic, strong) MidiPlayer *midiPlayer;

@property (nonatomic, strong) Exercise *currentExercise;

-(void)stopAudio;
-(void)playAudio;

-(void)setSequenceDirectionUp;
-(void)setSequenceDirectionDown;

-(void)setUserVolume:(CGFloat)value;
-(void)resetKeyColors;

@end
