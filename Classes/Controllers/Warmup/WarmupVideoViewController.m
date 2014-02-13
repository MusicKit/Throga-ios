//
//  WarmupVideoViewController.m
//  Throga-New
//
//  Created by Mick Oyer on 1/27/14.
//  Copyright (c) 2014 Parallel6. All rights reserved.
//

#import "WarmupVideoViewController.h"

@interface WarmupVideoViewController ()

@end

@implementation WarmupVideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated  {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self showMoviePlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)showMoviePlayer {

	playerView = [[UIView alloc]initWithFrame:CGRectMake(0, 66, 320, 416)];
	playerView.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
	[self.view addSubview:playerView];

	NSString *path = [[NSBundle mainBundle] pathForResource:@"warmup_video" ofType:@"m4v" inDirectory:nil];
    player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];

	player.view.frame = CGRectMake(0, 0, playerView.frame.size.width, playerView.frame.size.height);

    [player setScalingMode:MPMovieScalingModeAspectFit];
    [player setShouldAutoplay:NO];
	[player setControlStyle:MPMediaTypeMusicVideo];
	[player prepareToPlay];
	
	[playerView addSubview:[player view]];
}

@end
