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
    UITextView     *_txtvDescription;
}
@property (nonatomic, strong)     UIButton    *btnPlay;
@property (nonatomic, strong)     UIButton    *btnBack;

@end

@implementation GNHelpVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.lblTitle.text = @"How to play";
    
    _txtvDescription = [UITextView new];
    _txtvDescription.font = [UIFont fontWithName:FONT_REGULAR size:15];
    _txtvDescription.textColor = [UIColor whiteColor];
    _txtvDescription.backgroundColor = [UIColor clearColor];
    _txtvDescription.editable = NO;
    _txtvDescription.text = @"1. Divide evenly into two teams and sit in a circle with youteammates sitting every other person.\n\n2. Tap the start button and select your category.\n\n3. After you tap the Play button you'll see a few crude wordsdisplayed on your screen. Describe your words so you can get your team to saythem out loud. You cannot say any part of the words or shout out their firstletters, but you can use verbal clues or physical gestures to explain yourself.If a team breaks the rules then the opposing team is awarded the point for thatround.\n\n4. The team that gets stuck with the phone when the round endslosses. The team that is not holding the phone is awarded one point.\n\n5. The first team to seven points is the Crude Habits winner!Celebrate accordingly.";
    
    [self.view addSubview:_txtvDescription];
    [_txtvDescription alignLeading:@"5" trailing:@"-5" toView:self.view];
    [_txtvDescription alignTopEdgeWithView:self.view predicate:@"70"];
    [_txtvDescription constrainHeight:@"280"];
    
    
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
    [_btnPlay constrainTopSpaceToView:_txtvDescription predicate:@"20"];
    
    
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
