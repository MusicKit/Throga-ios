
#import <UIKit/UIKit.h>

#import "Database.h"

#import "UIColor+Tools.h"

#define DATABASE @"throga"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
	
	Database *throgaDatabase;
}

@property (strong, nonatomic) UIWindow *window;
@property Database *throgaDatabase;

@end
