
#import <UIKit/UIKit.h>

@class SingingStylesViewController;

@protocol SingingStylesViewControllerDelegate <NSObject>

- (void)didSelectDone:(SingingStylesViewController *)controller;

@end

@interface SingingStylesViewController : UITableViewController

@property (nonatomic, weak) id <SingingStylesViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
