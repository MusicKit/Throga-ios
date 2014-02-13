
#import "CreateAccountViewController.h"

@implementation CreateAccountViewController

- (id)initWithStyle:(UITableViewStyle)style {

    self = [super initWithStyle:style];
    if (self = [super initWithStyle:style]) {
    }
    return self;
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
  label.text = NSLocalizedString(@"Create Account", @"");
  [label sizeToFit];
}

- (IBAction)done:(id)sender {
	
    [self.delegate didSelectDone:self];
}

- (void)didSelectDone:(UIViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

	UINavigationController *navigationController = segue.destinationViewController;
	SingingStylesViewController *controller = [navigationController viewControllers][0];
	controller.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
