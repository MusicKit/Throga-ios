
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "UIColor+Tools.h"

@class SignInViewController;

@protocol SignInViewControllerDelegate <NSObject>

- (void)didSelectDone:(SignInViewController *)controller;

@end

@interface SignInViewController : UITableViewController <UITextFieldDelegate> {
	
	UIButton *facebookButton;
	UIButton *twitterButton;
	UIButton *signinButton;
	
	UITextField *usernameTextField;
	UITextField *usernamePassword;
	
}

@property (nonatomic, weak) id <SignInViewControllerDelegate> delegate;

@property IBOutlet UIButton *facebookButton;
@property IBOutlet UIButton *twitterButton;
@property IBOutlet UIButton *signinButton;

@property IBOutlet UITextField *usernameTextField;
@property IBOutlet 	UITextField *usernamePassword;

-(IBAction)facebookAction:(id)sender;
-(IBAction)twitterAction:(id)sender;
-(IBAction)signinAction:(id)sender;

-(IBAction)didEndEditing:(id)sender;

-(IBAction)done:(id)sender;

@end

