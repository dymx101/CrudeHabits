//
//  GNGameVC.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNGameVC.h"
#import "GNVertProgressView.h"
#import <BKECircularProgressView/BKECircularProgressView.h>

@interface GNGameVC () <GNVertProgressViewDelegate> {
    UILabel                 *_lblWord;
    
    GNVertProgressView      *_viewTeam1Progress;
    GNVertProgressView      *_viewTeam2Progress;
    
    UILabel                 *_lblTeam1;
    UILabel                 *_lblTeam2;
    
    BKECircularProgressView       *_viewCircularTimer;
    
    NSTimer                       *_timer;
    CGFloat                     _timeCount;
    CGFloat                     _timeCountMax;
    CGFloat                     _tickInterval;
}

@property (nonatomic, strong)     UIButton    *btnNext;

@end

@implementation GNGameVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _timeCountMax = 50.f;
    _tickInterval = 0.1f;
    
    
    _lblWord = [UILabel new];
    _lblWord.font = [UIFont boldSystemFontOfSize:45];
    _lblWord.textColor = [UIColor whiteColor];
    _lblWord.numberOfLines = 0;
    _lblWord.textAlignment = NSTextAlignmentCenter;
    _lblWord.text = @"Twerking";
    [self.view addSubview:_lblWord];
    [_lblWord alignCenterXWithView:self.view predicate:nil];
    [_lblWord alignTopEdgeWithView:self.view predicate:@"140"];
    
    
    
    _viewCircularTimer = [BKECircularProgressView new];//[[BKECircularProgressView alloc] initWithFrame:CGRectMake(110, 100, 100, 100)];
    _viewCircularTimer.progressTintColor = [UIColor whiteColor];
    _viewCircularTimer.backgroundTintColor = [FDColor sharedInstance].themeRed;
    _viewCircularTimer.lineWidth = 7.f;

    [self.view addSubview:_viewCircularTimer];
    [_viewCircularTimer alignCenterXWithView:self.view predicate:@"0"];
    [_viewCircularTimer constrainTopSpaceToView:_lblWord predicate:@"20"];
    [_viewCircularTimer constrainWidth:@"70" height:@"70"];
    
    
    //////
    _btnNext = [UIButton new];
    _btnNext.backgroundColor = [UIColor whiteColor];
    _btnNext.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [_btnNext setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
    [_btnNext setTitle:@"Next" forState:UIControlStateNormal];
    _btnNext.layer.cornerRadius = 10.f;
    [self.view addSubview:_btnNext];
    
    [_btnNext constrainWidth:@"200" height:@"45"];
    [_btnNext alignCenterXWithView:self.view predicate:@"0"];
    [_btnNext constrainTopSpaceToView:_lblWord predicate:@"140"];
    
    
    ////////
    _viewTeam1Progress = [GNVertProgressView new];
    _viewTeam1Progress.delegate = self;
    [self.view addSubview:_viewTeam1Progress];
    [_viewTeam1Progress constrainWidth:@"20" height:@"260"];
    [_viewTeam1Progress alignLeadingEdgeWithView:self.view predicate:@"20"];
    [_viewTeam1Progress alignBottomEdgeWithView:self.view predicate:@"-80"];
    
    
    _viewTeam2Progress = [GNVertProgressView new];
    _viewTeam2Progress.delegate = self;
    [self.view addSubview:_viewTeam2Progress];
    [_viewTeam2Progress constrainWidth:@"20" height:@"260"];
    [_viewTeam2Progress alignTrailingEdgeWithView:self.view predicate:@"-20"];
    [_viewTeam2Progress alignBottomEdgeWithView:self.view predicate:@"-80"];
    
    
    /////
    _lblTeam1 = [UILabel new];
    _lblTeam1.font = [UIFont boldSystemFontOfSize:13];
    _lblTeam1.textColor = [UIColor whiteColor];
    _lblTeam1.numberOfLines = 2;
    _lblTeam1.textAlignment = NSTextAlignmentCenter;
    _lblTeam1.text = @"Team\n1";
    [self.view addSubview:_lblTeam1];
    [_lblTeam1 alignCenterXWithView:_viewTeam1Progress predicate:nil];
    [_lblTeam1 constrainTopSpaceToView:_viewTeam1Progress predicate:@"5"];
    
    
    _lblTeam2 = [UILabel new];
    _lblTeam2.font = [UIFont boldSystemFontOfSize:13];
    _lblTeam2.textColor = [UIColor whiteColor];
    _lblTeam2.numberOfLines = 2;
    _lblTeam2.textAlignment = NSTextAlignmentCenter;
    _lblTeam2.text = @"Team\n2";
    [self.view addSubview:_lblTeam2];
    [_lblTeam2 alignCenterXWithView:_viewTeam2Progress predicate:nil];
    [_lblTeam2 constrainTopSpaceToView:_viewTeam2Progress predicate:@"5"];
    
    
    ////
    [self startTicking];
}


-(void)startTicking {
    _timeCount = 0;
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_tickInterval target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

-(void)tick:(id)sender {
    _timeCount += _tickInterval;
    _viewCircularTimer.progress = ((CGFloat)_timeCount / _timeCountMax);
    DLog(@"progress:%f", _viewCircularTimer.progress);
    
    if (_timeCount >= _timeCountMax) {
        DLog(@"Time is up!");
        [_timer invalidate];
        _timer = nil;
    }
}


#pragma mark - progress view delegate
-(void)progressView:(GNVertProgressView *)aProgressView progressChanged:(CGFloat)aProgress {
    if (aProgress >= 1.f) {
        if (aProgressView == _viewTeam1Progress) {
            DLog(@"Team 1 wins!");
        } else if (aProgressView == _viewTeam2Progress) {
            DLog(@"Team 2 wins!");
        }
    }
}

@end
