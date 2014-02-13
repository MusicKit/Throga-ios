
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "LearnMoreViewController.h"
#import "GetStartedViewController.h"
#import "CreateAccountViewController.h"
#import "SignInViewController.h"

#import "AppDelegate.h"
#import "Database.h"

@interface ViewController : UIViewController <LearnMoreViewControllerDelegate, GetStartedViewControllerDelegate, CreateAccountViewControllerDelegate> {
	
	UITextView *textView;
	UIButton *learnMoreButton;
	UIButton *getStartedButton;
	UIButton *createAccountButton;
	UIButton *signInButton;
}
@property IBOutlet UITextView *textView;
@property IBOutlet UIButton *learnMoreButton;
@property IBOutlet UIButton *getStartedButton;
@property IBOutlet UIButton *createAccountButton;
@property IBOutlet UIButton *signInButton;

@end
