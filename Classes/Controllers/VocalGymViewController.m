
#import "VocalGymViewController.h"

@interface VocalGymViewController ()

@end

@implementation VocalGymViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didSelectDone:(UIViewController *)controller {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.backgroundColor = [UIColor clearColor];
  label.font = [UIFont boldSystemFontOfSize:18.0];
  label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
  label.textAlignment = NSTextAlignmentCenter;
  
  label.textColor = [UIColor whiteColor];
  self.navigationItem.titleView = label;
  label.text = NSLocalizedString(@"Vocal Gym", @"");
  [label sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ( [segue.identifier isEqualToString:@"WorkoutMinutes"] ) {
		UINavigationController *navigationController = segue.destinationViewController;
		WorkoutViewController *controller = [navigationController viewControllers][0];
		controller.delegate = self;
	}
	else if ( [segue.identifier isEqualToString:@"WarmupMinutes"] )  {

//		UIButton *button = (UIButton *)sender;
//		WarmupMinutesViewController *controller = segue.destinationViewController;
//		controller.countdownSeconds = button.tag * 60;
	}
}


@end
