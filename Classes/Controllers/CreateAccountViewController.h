
#import <UIKit/UIKit.h>

#import "SingingStylesViewController.h"

@class CreateAccountViewController;

@protocol CreateAccountViewControllerDelegate <NSObject>

- (void)didSelectDone:(CreateAccountViewController *)controller;

@end

@interface CreateAccountViewController : UITableViewController <SingingStylesViewControllerDelegate>

@property (nonatomic, weak) id <CreateAccountViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
