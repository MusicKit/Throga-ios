
#import <UIKit/UIKit.h>

@class GetStartedViewController;

@protocol GetStartedViewControllerDelegate <NSObject>

- (void)didSelectDone:(GetStartedViewController *)controller;

@end

@interface GetStartedViewController : UIViewController {
	
	UIButton *gymButton;
	UIButton *calculatorButton;
	UIButton *pointsButton;
	UIButton *toolsButton;
}

@property (nonatomic, weak) id <GetStartedViewControllerDelegate> delegate;

@property (nonatomic) IBOutlet UIButton *gymButton;
@property (nonatomic) IBOutlet UIButton *calculatorButton;
@property (nonatomic) IBOutlet UIButton *pointsButton;
@property (nonatomic) IBOutlet UIButton *toolsButton;

- (IBAction)done:(id)sender;

@end
