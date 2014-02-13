
#import <UIKit/UIKit.h>

@class WorkoutViewController;

@protocol WorkoutViewControllerDelegate <NSObject>

- (void)didSelectDone:(WorkoutViewController *)controller;

@end

@interface WorkoutViewController : UITableViewController {
	
}
@property (nonatomic, weak) id <WorkoutViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
