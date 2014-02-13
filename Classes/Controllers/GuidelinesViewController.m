//
//  GuidelinesViewController.m
//  Throga-New
//
//  Created by Mick Oyer on 1/17/14.
//  Copyright (c) 2014 Parallel6. All rights reserved.
//

#import "GuidelinesViewController.h"

@interface GuidelinesViewController ()

@end

@implementation GuidelinesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.backgroundColor = [UIColor clearColor];
  label.font = [UIFont boldSystemFontOfSize:18.0];
  label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
  label.textAlignment = NSTextAlignmentCenter;
  
  label.textColor = [UIColor whiteColor];
  self.navigationItem.titleView = label;
  label.text = NSLocalizedString(@"Guidelines", @"");
  [label sizeToFit];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
