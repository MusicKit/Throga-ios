
#import "AppDelegate.h"

@implementation AppDelegate

@synthesize throgaDatabase;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	throgaDatabase = [[Database alloc]init];
	[throgaDatabase setupDatabase];

  [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:@"ffffff"]];
  [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"594d86"]];

    
    UIImage *minImage = [[UIImage imageNamed:@"slider-track-fill.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    UIImage *maxImage = [[UIImage imageNamed:@"slider-track.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    UIImage *thumbImage = [UIImage imageNamed:@"slider-cap.png"];
    
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateHighlighted];
    return YES;
}

-(Database *)database {
	return throgaDatabase;
}

@end
