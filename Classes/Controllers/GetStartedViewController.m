
#import "GetStartedViewController.h"

@implementation GetStartedViewController

@synthesize gymButton;
@synthesize calculatorButton;
@synthesize pointsButton;
@synthesize toolsButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (IBAction)done:(id)sender {
	
    [self.delegate didSelectDone:self];
}


- (void)viewDidLoad {

    [super viewDidLoad];
	
	if (IS_IPHONE5 == NO) {
		gymButton.bounds = CGRectMake(gymButton.frame.origin.x, gymButton.frame.origin.y, 50, 50);
		[gymButton setNeedsUpdateConstraints];
	}

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.backgroundColor = [UIColor clearColor];
  label.font = [UIFont boldSystemFontOfSize:18.0];
  label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
  label.textAlignment = NSTextAlignmentCenter;

  label.textColor = [UIColor whiteColor];
  self.navigationItem.titleView = label;
  label.text = NSLocalizedString(@"Get Started", @"");
  [label sizeToFit];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
