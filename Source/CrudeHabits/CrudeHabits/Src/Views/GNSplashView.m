//
//  GNSplashView.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNSplashView.h"

@interface GNSplashView () {
    UILabel     *_lblC;
    UILabel     *_lblH;
}

@end

@implementation GNSplashView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lblC = [UILabel new];
        _lblC.font = [UIFont fontWithName:FONT_REGULAR size:200];
        _lblC.textColor = [UIColor whiteColor];
        _lblC.text = @"C";
        _lblC.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lblC];
        
        //_lblC.frame = CGRectMake(10, 80, 160, 180);

        [_lblC alignCenterXWithView:self predicate:@"-50"];
        [_lblC alignTopEdgeWithView:self predicate:@"80"];
        
        _lblH = [UILabel new];
        UIFont  *font = [UIFont fontWithName:FONT_REGULAR size:200];
        _lblH.font = font;
        _lblH.textColor = [UIColor whiteColor];
        _lblH.text = @"H";
        _lblH.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lblH];
        
        //_lblH.frame = CGRectMake(140, 80, 160, 180);

        [_lblH alignCenterXWithView:self predicate:@"43"];
        [_lblH alignCenterYWithView:_lblC predicate:@"-16"];
        
        
        
        //////
        _btnPlay = [UIButton new];
        _btnPlay.backgroundColor = [UIColor whiteColor];
        _btnPlay.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];
        [_btnPlay setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
        [_btnPlay setTitle:@"Play" forState:UIControlStateNormal];
        _btnPlay.layer.cornerRadius = 10.f;
        [self addSubview:_btnPlay];
        
        [_btnPlay constrainWidth:@"200" height:@"45"];
        [_btnPlay alignCenterXWithView:self predicate:@"0"];
        [_btnPlay constrainTopSpaceToView:_lblC predicate:@"50"];
        
        
        //////
        _btnHowItWorks = [UIButton new];
        _btnHowItWorks.backgroundColor = [UIColor whiteColor];
        _btnHowItWorks.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:20];
        [_btnHowItWorks setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
        [_btnHowItWorks setTitle:@"How it works" forState:UIControlStateNormal];
        _btnHowItWorks.layer.cornerRadius = 10.f;
        [self addSubview:_btnHowItWorks];
        
        [_btnHowItWorks constrainWidth:@"200" height:@"45"];
        [_btnHowItWorks alignCenterXWithView:self predicate:@"0"];
        [_btnHowItWorks constrainTopSpaceToView:_btnPlay predicate:@"20"];
    }
    return self;
}


-(void)runAnimation {

    CGFloat angle = - M_PI / 4.0f;
    CGAffineTransform rotateTransform = CGAffineTransformRotate(_lblH.transform, angle);
    
    [UIView animateWithDuration:1.5
                          delay:.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _lblH.transform = rotateTransform;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
}

@end
