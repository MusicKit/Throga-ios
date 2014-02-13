
#import "ViewController.h"

@implementation ViewController

@synthesize textView;
@synthesize learnMoreButton;
@synthesize getStartedButton;
@synthesize createAccountButton;
@synthesize signInButton;

- (void)didSelectDone:(UIViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

	UINavigationController *navigationController = segue.destinationViewController;
	LearnMoreViewController *controller = [navigationController viewControllers][0];

    if ([segue.identifier isEqualToString:@"Learn More"]) {
        controller.delegate = self;
    }
	
    if ([segue.identifier isEqualToString:@"Get Started"]) {
        controller.delegate = self;
    }
	
    if ([segue.identifier isEqualToString:@"Create Account"]) {
        controller.delegate = self;
    }
	
    if ([segue.identifier isEqualToString:@"Sign In"]) {
        controller.delegate = self;
    }
}

- (void)viewDidLoad {

    [super viewDidLoad];

//	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//	Database *database = appDelegate.throgaDatabase;
//	
//	NSArray *exercises = [database exerciseByTypeID:1];
//	
//	for (Exercise *exercise in exercises) {
//		NSLog(@"%@", exercise);
//	}
//	
	CGFloat borderWidth = 1.0;
	CGFloat cornerRadius = 2.0;
	
	NSArray *buttonArray = [[NSArray alloc]initWithObjects:getStartedButton, createAccountButton, signInButton, learnMoreButton, nil];
	
	for (UIButton *button in buttonArray) {
		button.layer.borderColor = [UIColor lightGrayColor].CGColor;
		button.layer.borderWidth = borderWidth;
		button.layer.cornerRadius = cornerRadius;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
