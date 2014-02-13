
#import "PianoKeyView.h"

@implementation PianoKeyView

@synthesize delegate;

@synthesize octave;
@synthesize note;

- (id)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

-(NSString *)description {
	return [NSString stringWithFormat:@"PianoKeyView : tag : %d, octave : %d, note : %d", self.tag, octave, note];
}
@end
