//
//  GNHelpVC.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNHelpVC.h"
#import "GNSelectCategoryVC.h"

@interface GNHelpVC () {
    UILabel     *_lblDescription;
}
@property (nonatomic, strong)     UIButton    *btnPlay;
@property (nonatomic, strong)     UIButton    *btnBack;

@end

@implementation GNHelpVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lblDescription = [UILabel new];
    _lblDescription.font = [UIFont fontWithName:FONT_REGULAR size:15];
    _lblDescription.textColor = [UIColor whiteColor];
    _lblDescription.numberOfLines = 0;
    _lblDescription.textAlignment = NSTextAlignmentCenter;
    _lblDescription.text = @"Have your team sit every other person and get them to say the words you see on the screen - describe it however you want.Describe or act out the word, just don't say the word itself.";
    [self.view addSubview:_lblDescription];
    [_lblDescription alignLeading:@"5" trailing:@"-5" toView:self.view];
    [_lblDescription alignTopEdgeWithView:self.view predicate:@"140"];
    
    
    //////
    _btnPlay = [UIButton new];
    _btnPlay.backgroundColor = [UIColor whiteColor];
    _btnPlay.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];
    [_btnPlay setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
    [_btnPlay setTitle:@"Play" forState:UIControlStateNormal];
    _btnPlay.layer.cornerRadius = 10.f;
    [self.view addSubview:_btnPlay];
    
    [_btnPlay constrainWidth:@"200" height:@"45"];
    [_btnPlay alignCenterXWithView:self.view predicate:@"0"];
    [_btnPlay constrainTopSpaceToView:_lblDescription predicate:@"50"];
    
    
    //////
    _btnBack = [UIButton new];
    _btnBack.backgroundColor = [UIColor whiteColor];
    _btnBack.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];
    [_btnBack setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
    [_btnBack setTitle:@"Back" forState:UIControlStateNormal];
    _btnBack.layer.cornerRadius = 10.f;
    [self.view addSubview:_btnBack];
    
    [_btnBack constrainWidth:@"200" height:@"45"];
    [_btnBack alignCenterXWithView:self.view predicate:@"0"];
    [_btnBack constrainTopSpaceToView:_btnPlay predicate:@"20"];
    
    
    [_btnBack addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnPlay addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
}




#pragma mark - actions
-(void)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)playAction:(id)sender {
    UIViewController *presentingVC = self.presentingViewController;
    [self dismissViewControllerAnimated:NO completion:^{
        GNSelectCategoryVC *vc = [GNSelectCategoryVC new];
        //vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [presentingVC presentViewController:vc animated:NO completion:nil];
    }];
}

@end
