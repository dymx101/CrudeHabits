//
//  GNViewController.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNBaseVC.h"


@interface GNBaseVC () {
    UILabel         *_lblTitle;

}

@end

@implementation GNBaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [FDColor sharedInstance].themeRed;
    
    _lblTitle = [UILabel new];
    _lblTitle.font = [UIFont boldSystemFontOfSize:20];
    _lblTitle.textColor = [UIColor whiteColor];
    _lblTitle.text = @"Crude Habits";
    [self.view addSubview:_lblTitle];
    [_lblTitle alignCenterXWithView:self.view predicate:nil];
    [_lblTitle alignTopEdgeWithView:self.view predicate:@"30"];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
