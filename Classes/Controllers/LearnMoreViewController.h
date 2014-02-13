
#import <UIKit/UIKit.h>

@class LearnMoreViewController;

@protocol LearnMoreViewControllerDelegate <NSObject>

- (void)didSelectDone:(LearnMoreViewController *)controller;

@end
@interface LearnMoreViewController : UIViewController {
	
	UIScrollView *learnMoreScrollView;
}

@property IBOutlet UIScrollView *learnMoreScrollView;

@property (nonatomic, weak) id <LearnMoreViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
