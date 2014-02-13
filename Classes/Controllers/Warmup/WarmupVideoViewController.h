
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface WarmupVideoViewController : UIViewController {

	UIView *playerView;
	MPMoviePlayerController *player;
	BOOL isMoviePlaying;

}

@end
