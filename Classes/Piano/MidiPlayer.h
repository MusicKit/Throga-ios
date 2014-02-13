
#import <Foundation/Foundation.h>
#import <AudioToolbox/MusicPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface MidiPlayer : NSObject

- (BOOL) createAUGraph;
- (void) configureAndStartAudioProcessingGraph: (AUGraph) graph;

-(void)play:(NSString *)fileName withTempo:(NSInteger)tempo forNote:(NSInteger)note;
-(void)stop;
@end
