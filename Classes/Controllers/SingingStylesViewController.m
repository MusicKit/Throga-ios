
#import "SingingStylesViewController.h"

@implementation SingingStylesViewController

- (id)initWithStyle:(UITableViewStyle)style {

    if (self = [super initWithStyle:style]) {
    }
    return self;
}

- (IBAction)done:(id)sender {
	
    [self.delegate didSelectDone:self];
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
  label.text = NSLocalizedString(@"Singing Styles", @"");
  [label sizeToFit];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
