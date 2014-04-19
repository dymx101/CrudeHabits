//
//  GNSplashVC.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNSplashVC.h"
#import "GNSplashView.h"
#import "GNHelpVC.h"
#import "GNStartGameVC.h"

@interface GNSplashVC () {
    GNSplashView    *_splashScreen;
}

@end

@implementation GNSplashVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    _splashScreen = [GNSplashView new];
    [self.view addSubview:_splashScreen];
    [_splashScreen alignToView:self.view];
    
    [_splashScreen.btnHowItWorks addTarget:self action:@selector(helpAction:) forControlEvents:UIControlEventTouchUpInside];
    [_splashScreen.btnPlay addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_splashScreen runAnimation];
}

#pragma mark - actions
-(void)helpAction:(id)sender {
    GNHelpVC *vc = [GNHelpVC new];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)playAction:(id)sender {
    GNStartGameVC *vc = [GNStartGameVC new];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
