
#import "SignInViewController.h"

@implementation SignInViewController

@synthesize facebookButton;
@synthesize twitterButton;
@synthesize signinButton;

@synthesize usernameTextField;
@synthesize usernamePassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

-(IBAction)didEndEditing:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidLoad {

    [super viewDidLoad];

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.backgroundColor = [UIColor clearColor];
  label.font = [UIFont boldSystemFontOfSize:18.0];
  label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
  label.textAlignment = NSTextAlignmentCenter;
  
  label.textColor = [UIColor whiteColor];
  self.navigationItem.titleView = label;
  label.text = NSLocalizedString(@"Sign In", @"");
  [label sizeToFit];
  
	CGFloat borderWidth = 1.0;
	CGFloat cornerRadius = 2.0;
	
	facebookButton.layer.borderColor = [UIColor colorWithHexString:@"1077e1"].CGColor;
	facebookButton.layer.borderWidth = borderWidth;
	facebookButton.layer.cornerRadius = cornerRadius;
	
	twitterButton.layer.borderColor = [UIColor colorWithHexString:@"1077e1"].CGColor;
	twitterButton.layer.borderWidth = borderWidth;
	twitterButton.layer.cornerRadius = cornerRadius;
	
	signinButton.layer.borderColor = [UIColor colorWithHexString:@"1077e1"].CGColor;
	signinButton.layer.borderWidth = borderWidth;
	signinButton.layer.cornerRadius = cornerRadius;

	usernameTextField.delegate = self;
	usernamePassword.delegate = self;
}

- (IBAction)done:(id)sender {
	
    [self.delegate didSelectDone:self];
}

-(IBAction)facebookAction:(id)sender {
	NSLog(@"facebook Selected");
}

-(IBAction)twitterAction:(id)sender {
	NSLog(@"twitter Selected");
}

-(IBAction)signinAction:(id)sender {
	NSLog(@"signin Selected");
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

@end
