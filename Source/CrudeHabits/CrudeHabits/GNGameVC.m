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

typedef enum {
    kGameStatePlaying = 0
    , kGameStatePaused
    , kGameStateShowTimeUp
    , kGameStateShowNextRound
    , kGameStateShowWin
}GameState;


@interface GNGameVC () <GNVertProgressViewDelegate> {
    UILabel                 *_lblWord;
    UILabel                 *_lblCenterTip;
    
    GNVertProgressView      *_viewTeam1Progress;
    GNVertProgressView      *_viewTeam2Progress;
    
    UILabel                 *_lblTeam1;
    UILabel                 *_lblTeam2;
    
    BKECircularProgressView       *_viewCircularTimer;
    
    NSTimer                       *_timer;
    CGFloat                     _timeCount;
    CGFloat                     _timeCountMax;
    CGFloat                     _tickInterval;
    
    GameState                   _gameState;
    
    NSArray                     *_words;
    NSString                    *_word;
}

@property (nonatomic, strong)     UIButton    *btnNext;
@property (nonatomic, strong)     UIButton    *btnNextRound;
@property (nonatomic, strong)     UIButton    *btnPlayAgain;
@property (nonatomic, strong)     UIButton    *btnCategory;

@end

@implementation GNGameVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _timeCountMax = 10.f;
    _tickInterval = 0.1f;
    
    _words = @[@"Twerking", @"Moonwalk", @"LOL", @"Bookworm", @"Snicker"];
    
    
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
    
    
    //////
    _btnNextRound = [UIButton new];
    _btnNextRound.backgroundColor = [UIColor whiteColor];
    _btnNextRound.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [_btnNextRound setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
    [_btnNextRound setTitle:@"Next Round" forState:UIControlStateNormal];
    _btnNextRound.layer.cornerRadius = 10.f;
    [self.view addSubview:_btnNextRound];
    _btnNextRound.hidden = YES;
    
    [_btnNextRound constrainWidth:@"200" height:@"45"];
    [_btnNextRound alignCenterXWithView:self.view predicate:@"0"];
    [_btnNextRound constrainTopSpaceToView:_lblWord predicate:@"230"];
    
    
    //////
    _btnPlayAgain = [UIButton new];
    _btnPlayAgain.backgroundColor = [UIColor whiteColor];
    _btnPlayAgain.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [_btnPlayAgain setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
    [_btnPlayAgain setTitle:@"Play Again" forState:UIControlStateNormal];
    _btnPlayAgain.layer.cornerRadius = 10.f;
    [self.view addSubview:_btnPlayAgain];
    _btnPlayAgain.hidden = YES;
    
    [_btnPlayAgain constrainWidth:@"200" height:@"45"];
    [_btnPlayAgain alignCenterXWithView:self.view predicate:@"0"];
    [_btnPlayAgain constrainTopSpaceToView:_lblWord predicate:@"100"];
    
    
    _btnCategory = [UIButton new];
    _btnCategory.backgroundColor = [UIColor whiteColor];
    _btnCategory.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [_btnCategory setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
    [_btnCategory setTitle:@"Categories" forState:UIControlStateNormal];
    _btnCategory.layer.cornerRadius = 10.f;
    [self.view addSubview:_btnCategory];
    _btnCategory.hidden = YES;
    
    [_btnCategory constrainWidth:@"200" height:@"45"];
    [_btnCategory alignCenterXWithView:self.view predicate:@"0"];
    [_btnCategory constrainTopSpaceToView:_btnPlayAgain predicate:@"20"];
    
    
    /////
    _lblCenterTip = [UILabel new];
    _lblCenterTip.font = [UIFont boldSystemFontOfSize:20];
    _lblCenterTip.textColor = [UIColor whiteColor];
    _lblCenterTip.numberOfLines = 0;
    _lblCenterTip.textAlignment = NSTextAlignmentCenter;
    _lblCenterTip.text = @"Tap the side that won the point";
    [self.view addSubview:_lblCenterTip];
    [_lblCenterTip alignCenterXWithView:self.view predicate:nil];
    [_lblCenterTip alignTopEdgeWithView:_lblWord predicate:@"170"];
    [_lblCenterTip constrainWidth:@"170"];
    _lblCenterTip.hidden = YES;
    
    
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
    
    
    
    [_btnNextRound addTarget:self action:@selector(nextRoundAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnNext addTarget:self action:@selector(nextWordAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    ////
    [self nextRoundAction];
}


#pragma mark -
-(void)startTicking {
    _timeCount = 0;
    _viewCircularTimer.progress = 0;
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_tickInterval target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

-(void)tick:(id)sender {
    _timeCount += _tickInterval;
    _viewCircularTimer.progress = ((CGFloat)_timeCount / _timeCountMax);
    //DLog(@"progress:%f", _viewCircularTimer.progress);
    
    if (_timeCount >= _timeCountMax) {
        DLog(@"Time is up!");
        [_timer invalidate];
        _timer = nil;
        
        [self showTimeIsUp];
    }
}


-(void)changeWord {
    NSString *oldWord = _word;
    
    while (_word.length <= 0 || [oldWord isEqualToString:_word]) {
        int rand = arc4random_uniform(_words.count);
        _word = _words[rand];
    }
    
    _lblWord.text = _word;
}

-(void)showPlaying {
    
    [self changeWord];
    
    _viewCircularTimer.hidden = NO;
    [self startTicking];
    _btnNext.hidden = NO;
    _btnNextRound.hidden = YES;
    
    _gameState = kGameStatePlaying;
}

-(void)showTimeIsUp {
    _lblWord.text = @"TIME'S UP!";
    _viewCircularTimer.hidden = YES;
    _btnNext.hidden = YES;
    _lblCenterTip.hidden = NO;
    
    _gameState = kGameStateShowTimeUp;
}


-(void)showNextRound:(BOOL)aTeam1Won {
    _lblWord.text = aTeam1Won ? @"Go Team 1!" : @"Go Team 2!";
    _lblCenterTip.hidden = YES;
    _btnNextRound.hidden = NO;
    
    _gameState = kGameStateShowNextRound;
}

-(void)showTeamWins:(BOOL)aTeam1Wins {
    _lblWord.text = aTeam1Wins ? @"Team 1\nWins!" : @"Team 2\nWins!";
    _btnNextRound.hidden = YES;
    _btnPlayAgain.hidden = NO;
    _btnCategory.hidden = NO;
    _lblCenterTip.hidden = YES;
    
    _gameState = kGameStateShowWin;
}


#pragma mark - progress view delegate
-(void)progressView:(GNVertProgressView *)aProgressView progressChanged:(CGFloat)aProgress {
    if (aProgress >= 1.f) {
        
        DLog(@"Wins!");
        [self showTeamWins:(aProgressView == _viewTeam1Progress)];
        
    } else {
        DLog(@"Next Round");
        if (_gameState == kGameStateShowTimeUp) {
            [self showNextRound:(aProgressView == _viewTeam1Progress)];
        }
    }
}

-(BOOL)progressViewShouldChangeProgress:(GNVertProgressView *)aProgressView {
    return (_gameState == kGameStateShowTimeUp);
}


#pragma mark - actions
-(void)nextRoundAction {
    [self showPlaying];
}

-(void)nextWordAction {
    [self changeWord];
}

@end
