
#import <UIKit/UIKit.h>

//@protocol PianoKeyViewDelegate <NSObject>
//-(void)playAudioForKeyView:(UIView *)keyView withNoteValue:(NSInteger)noteValue;
//@end

@interface PianoKeyView : UIView {
  
  id delegate;
  
	NSInteger octave;
	NSInteger note;
}
@property id delegate;
@property NSInteger octave;
@property NSInteger note;

@end
