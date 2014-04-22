//
//  GNGameVC.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNGameVC.h"
#import "GNVertProgressView.h"
#import "FDDefine.h"
#import "FDColor.h"
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
    
    UIImageView             *_ivPlayPause;
    UIImageView             *_ivClose;
    UIView                  *_viewPauseBlock;
    UIView                  *_viewPausePanel;
    
    GNVertProgressView      *_viewTeam1Progress;
    UIView                  *_viewTeam1ProgressBG;
    
    GNVertProgressView      *_viewTeam2Progress;
    UIView                  *_viewTeam2ProgressBG;
    
    UILabel                 *_lblTeam1;
    UILabel                 *_lblTeam2;
    
    BKECircularProgressView       *_viewCircularTimer;
    
    NSTimer                     *_timer;
    CGFloat                     _timeCount;
    CGFloat                     _timeCountMax;
    CGFloat                     _tickInterval;
    CGFloat                     _tickCount;
    BOOL                        _isPlayingQuickTick;
    
    GameState                   _gameState;
    BOOL                        _isGamePaused;
    
    NSArray                     *_words;
    NSString                    *_word;
}

@property (nonatomic, strong)     UIButton    *btnNext;
@property (nonatomic, strong)     UIButton    *btnNextRound;
@property (nonatomic, strong)     UIButton    *btnPlayAgain;
@property (nonatomic, strong)     UIButton    *btnCategory;

@property (nonatomic, strong)     UILabel     *lblQuitMessage;
@property (nonatomic, strong)     UIButton    *btnQuit;
@property (nonatomic, strong)     UIButton    *btnResume;

@end

@implementation GNGameVC

- (void)installPauseView
{
    ////
    
    _viewPauseBlock = [UIView new];
    _viewPauseBlock.backgroundColor = [UIColor colorWithWhite:1 alpha:.5];
    [self.view addSubview:_viewPauseBlock];
    [_viewPauseBlock alignToView:self.view];
    _viewPauseBlock.hidden = YES;
    
    _viewPausePanel = [UIView new];
    _viewPausePanel.backgroundColor = [FDColor sharedInstance].themeRed;
    _viewPausePanel.layer.cornerRadius = 10.f;
    [_viewPauseBlock addSubview:_viewPausePanel];
    [_viewPausePanel constrainWidth:@"220" height:@"220"];
    [_viewPausePanel alignCenterWithView:_viewPauseBlock];
    _viewPausePanel.hidden = YES;
    
    _lblQuitMessage = [UILabel new];
    _lblQuitMessage.font = [UIFont fontWithName:FONT_REGULAR size:20];
    _lblQuitMessage.textColor = [UIColor whiteColor];
    _lblQuitMessage.numberOfLines = 0;
    _lblQuitMessage.textAlignment = NSTextAlignmentCenter;
    _lblQuitMessage.text = @"Are you sure you want to quit?";
    [_viewPausePanel addSubview:_lblQuitMessage];
    [_lblQuitMessage alignLeading:@"10" trailing:@"-10" toView:_viewPausePanel];
    [_lblQuitMessage alignTopEdgeWithView:_viewPausePanel predicate:@"20"];
    
    _btnQuit = [UIButton new];
    _btnQuit.backgroundColor = [UIColor whiteColor];
    _btnQuit.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:25];//[UIFont boldSystemFontOfSize:30];
    [_btnQuit setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
    [_btnQuit setTitle:@"Yes" forState:UIControlStateNormal];
    _btnQuit.layer.cornerRadius = 10.f;
    [_viewPausePanel addSubview:_btnQuit];
    [_btnQuit constrainWidth:@"150" height:@"45"];
    [_btnQuit alignCenterXWithView:_viewPausePanel predicate:@"0"];
    [_btnQuit constrainTopSpaceToView:_lblQuitMessage predicate:@"20"];
    
    
    _btnResume = [UIButton new];
    _btnResume.backgroundColor = [UIColor whiteColor];
    _btnResume.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:25];//[UIFont boldSystemFontOfSize:30];
    [_btnResume setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
    [_btnResume setTitle:@"No" forState:UIControlStateNormal];
    _btnResume.layer.cornerRadius = 10.f;
    [_viewPausePanel addSubview:_btnResume];
    [_btnResume constrainWidth:@"150" height:@"45"];
    [_btnResume alignCenterXWithView:_viewPausePanel predicate:@"0"];
    [_btnResume constrainTopSpaceToView:_btnQuit predicate:@"10"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _timeCountMax = 50.f;
    _tickInterval = 0.1f;
    
    _words = @[@"Twerking", @"Moonwalk", @"LOL", @"Bookworm", @"Snicker"];
    
    
    _lblWord = [UILabel new];
    _lblWord.font = [UIFont fontWithName:FONT_REGULAR size:45];
    _lblWord.minimumScaleFactor = .5f;
    _lblWord.adjustsFontSizeToFitWidth = YES;
    _lblWord.textColor = [UIColor whiteColor];
    _lblWord.numberOfLines = 2;
    _lblWord.textAlignment = NSTextAlignmentCenter;
    _lblWord.text = @"Twerking";
    [self.view addSubview:_lblWord];
    [_lblWord alignLeading:@"30" trailing:@"-30" toView:self.view];

    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_lblWord attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-400];
    [self.view addConstraint:constraint];
    
    
    [self installPauseView];
    
    
    ////
    _ivPlayPause = [UIImageView new];
    _ivPlayPause.image = [UIImage imageNamed:@"pause"];
    [self.view addSubview:_ivPlayPause];
    [_ivPlayPause alignCenterYWithView:self.lblTitle predicate:nil];
    [_ivPlayPause alignTrailingEdgeWithView:self.view predicate:@"-10"];
    [_ivPlayPause constrainWidth:@"30" height:@"30"];
    _ivPlayPause.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapPlayPause = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playPauseAction)];
    [_ivPlayPause addGestureRecognizer:tapPlayPause];
    
    
    ///
    _ivClose = [UIImageView new];
    _ivClose.image = [UIImage imageNamed:@"close_white"];
    [self.view addSubview:_ivClose];
    [_ivClose alignCenterYWithView:self.lblTitle predicate:nil];
    [_ivClose alignLeadingEdgeWithView:self.view predicate:@"10"];
    [_ivClose constrainWidth:@"26" height:@"26"];
    _ivClose.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitGameAction)];
    [_ivClose addGestureRecognizer:tapClose];
    
    
    
    ///
    _viewCircularTimer = [BKECircularProgressView new];//[[BKECircularProgressView alloc] initWithFrame:CGRectMake(110, 100, 100, 100)];
    
    _viewCircularTimer.progressTintColor = [FDColor sharedInstance].themeRed;
    _viewCircularTimer.backgroundTintColor = [UIColor whiteColor];
    
//    _viewCircularTimer.progressTintColor = [UIColor whiteColor];
//    _viewCircularTimer.backgroundTintColor = [FDColor sharedInstance].themeRed;
    
    
    _viewCircularTimer.lineWidth = 8.f;

    [self.view addSubview:_viewCircularTimer];
    [_viewCircularTimer alignCenterXWithView:self.view predicate:@"0"];
    [_viewCircularTimer constrainTopSpaceToView:_lblWord predicate:@"20"];
    [_viewCircularTimer constrainWidth:@"70" height:@"70"];
    
    
    //////
    _btnNext = [UIButton new];
    _btnNext.backgroundColor = [UIColor whiteColor];
    _btnNext.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];//[UIFont boldSystemFontOfSize:30];
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
    _btnNextRound.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];//[UIFont boldSystemFontOfSize:30];
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
    _btnPlayAgain.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];//[UIFont boldSystemFontOfSize:30];
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
    _btnCategory.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];//[UIFont boldSystemFontOfSize:30];
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
    _lblCenterTip.font = [UIFont fontWithName:FONT_REGULAR size:20];//[UIFont boldSystemFontOfSize:20];
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
    _viewTeam1ProgressBG = [UIView new];
    [self.view addSubview:_viewTeam1ProgressBG];
    UITapGestureRecognizer *tapTeam1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTeam1Action:)];
    [_viewTeam1ProgressBG addGestureRecognizer:tapTeam1];
    
    
    _viewTeam1Progress = [GNVertProgressView new];
    _viewTeam1Progress.delegate = self;
    [self.view addSubview:_viewTeam1Progress];
    [_viewTeam1Progress constrainWidth:@"20" height:@"260"];
    [_viewTeam1Progress alignLeadingEdgeWithView:self.view predicate:@"20"];
    [_viewTeam1Progress alignBottomEdgeWithView:self.view predicate:@"-80"];
    [_viewTeam1ProgressBG alignTop:@"0" leading:@"-20" bottom:@"40" trailing:@"20" toView:_viewTeam1Progress];
    
    _viewTeam2ProgressBG = [UIView new];
    [self.view addSubview:_viewTeam2ProgressBG];
    UITapGestureRecognizer *tapTeam2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTeam2Action:)];
    [_viewTeam2ProgressBG addGestureRecognizer:tapTeam2];
    
    _viewTeam2Progress = [GNVertProgressView new];
    _viewTeam2Progress.delegate = self;
    [self.view addSubview:_viewTeam2Progress];
    [_viewTeam2Progress constrainWidth:@"20" height:@"260"];
    [_viewTeam2Progress alignTrailingEdgeWithView:self.view predicate:@"-20"];
    [_viewTeam2Progress alignBottomEdgeWithView:self.view predicate:@"-80"];
    [_viewTeam2ProgressBG alignTop:@"0" leading:@"-20" bottom:@"40" trailing:@"20" toView:_viewTeam2Progress];
    
    
    /////
    _lblTeam1 = [UILabel new];
    _lblTeam1.font = [UIFont fontWithName:FONT_REGULAR size:13];//[UIFont boldSystemFontOfSize:13];
    _lblTeam1.textColor = [UIColor whiteColor];
    _lblTeam1.numberOfLines = 2;
    _lblTeam1.textAlignment = NSTextAlignmentCenter;
    _lblTeam1.text = @"Team\n1";
    [self.view addSubview:_lblTeam1];
    [_lblTeam1 alignCenterXWithView:_viewTeam1Progress predicate:nil];
    [_lblTeam1 constrainTopSpaceToView:_viewTeam1Progress predicate:@"5"];
    
    
    _lblTeam2 = [UILabel new];
    _lblTeam2.font = [UIFont fontWithName:FONT_REGULAR size:13];//[UIFont boldSystemFontOfSize:13];
    _lblTeam2.textColor = [UIColor whiteColor];
    _lblTeam2.numberOfLines = 2;
    _lblTeam2.textAlignment = NSTextAlignmentCenter;
    _lblTeam2.text = @"Team\n2";
    [self.view addSubview:_lblTeam2];
    [_lblTeam2 alignCenterXWithView:_viewTeam2Progress predicate:nil];
    [_lblTeam2 constrainTopSpaceToView:_viewTeam2Progress predicate:@"5"];
    
    
    [self.view bringSubviewToFront:_viewPauseBlock];
    [self.view bringSubviewToFront:_ivPlayPause];
    
    
    [_btnNextRound addTarget:self action:@selector(nextRoundAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnNext addTarget:self action:@selector(nextWordAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnPlayAgain addTarget:self action:@selector(playAgainAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnCategory addTarget:self action:@selector(categoriesAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnQuit addTarget:self action:@selector(doQuit) forControlEvents:UIControlEventTouchUpInside];
    [_btnResume addTarget:self action:@selector(doResume) forControlEvents:UIControlEventTouchUpInside];
    
    
    ////
    [self playAgainAction];
}


#pragma mark -
-(void)stopTicking {
    
    [_timer invalidate];
    _timer = nil;
    
    [MCSoundBoard stopAudioForKey:@"quick_tick"];
}

-(void)startTicking {
    
    [self stopTicking];
    
    _timeCount = 0;
    _viewCircularTimer.progress = 0;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:_tickInterval target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

-(void)tick:(id)sender {
    _timeCount += _tickInterval;
    CGFloat delta = _tickInterval * (_timeCount / 3);
    CGFloat progress = (((CGFloat)_timeCount - delta) / _timeCountMax);
    _viewCircularTimer.progress = progress;

    BOOL needPlayTickSound = NO;
    _tickCount += _tickInterval;
    if (_viewCircularTimer.progress > 0.75f) {
//        if (_tickCount > 0.35) {
//            _tickCount = 0;
//            needPlayTickSound = YES;
//        }
        if (!_isPlayingQuickTick) {
            _isPlayingQuickTick = YES;
            [MCSoundBoard playAudioForKey:@"quick_tick"];
        }
        
    } else if (_viewCircularTimer.progress > 0.5f) {
        if (_tickCount > 0.5) {
            _tickCount = 0;
            needPlayTickSound = YES;
        }
    } else {
        if (_tickCount > 1.0) {
            _tickCount = 0;
            needPlayTickSound = YES;
        }
    }
    
    if (needPlayTickSound) {
        [MCSoundBoard playAudioForKey:@"tick"];
    }
    
    
    if (_timeCount >= _timeCountMax) {
        DLog(@"Time is up!");
        [self stopTicking];
        
        [self showTimeIsUp];
        [MCSoundBoard playAudioForKey:@"alarm"];
    }
}


-(void)changeWord {
    NSString *oldWord = _word;
    
    while (_word.length <= 0 || [oldWord isEqualToString:_word]) {
        int rand = arc4random_uniform((u_int32_t)_words.count);
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
    _btnPlayAgain.hidden = YES;
    _btnCategory.hidden = YES;
    _ivPlayPause.hidden = NO;
    
    _gameState = kGameStatePlaying;
}

-(void)showTimeIsUp {
    _lblWord.text = @"TIME'S UP!";
    _viewCircularTimer.hidden = YES;
    _btnNext.hidden = YES;
    _lblCenterTip.hidden = NO;
    _ivPlayPause.hidden = YES;
    
    _gameState = kGameStateShowTimeUp;
}


-(void)showNextRound:(BOOL)aTeam1Won {
    _lblWord.text = aTeam1Won ? @"Go Team 1!" : @"Go Team 2!";
    _lblCenterTip.hidden = YES;
    _btnNextRound.hidden = NO;
    _btnNext.hidden = YES;
    _ivPlayPause.hidden = YES;
    
    _viewCircularTimer.hidden = YES;
    [self stopTicking];
    
    _gameState = kGameStateShowNextRound;
}

-(void)showTeamWins:(BOOL)aTeam1Wins {
    _lblWord.text = aTeam1Wins ? @"Team 1\nWins!" : @"Team 2\nWins!";
    _btnNextRound.hidden = YES;
    _btnPlayAgain.hidden = NO;
    _btnCategory.hidden = NO;
    _lblCenterTip.hidden = YES;
    _ivPlayPause.hidden = YES;
    
    _viewCircularTimer.hidden = YES;
    _btnNext.hidden = YES;
    
    _gameState = kGameStateShowWin;
}


#pragma mark - progress view delegate
-(void)progressView:(GNVertProgressView *)aProgressView progressChanged:(CGFloat)aProgress {
    if (aProgress >= 1.f) {
        
        DLog(@"Wins!");
        [MCSoundBoard playSoundForKey:@"win"];
        
        [self showTeamWins:(aProgressView == _viewTeam1Progress)];
        
    } else {
        DLog(@"Next Round");
        [MCSoundBoard playSoundForKey:@"selected"];
        
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
    [MCSoundBoard playAudioForKey:@"switch"];
}

-(void)playAgainAction {
    [MCSoundBoard playSoundForKey:@"opener"];
    
    [_viewTeam1Progress reset];
    [_viewTeam2Progress reset];
    
    [self showPlaying];
}

-(void)categoriesAction {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)quitGameAction {
    [self pauseAction];
    _viewPausePanel.hidden = NO;
    _ivPlayPause.userInteractionEnabled = NO;
}

-(void)doQuit {
    
    UIViewController *presentingVC = self.presentingViewController;
    [presentingVC dismissViewControllerAnimated:NO completion:^{
        [presentingVC.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    }];
}

-(void)doResume {
    [self resumeAction];
    _ivPlayPause.userInteractionEnabled = YES;
}

-(void)playPauseAction {
    
    if (_isGamePaused) {
        [self resumeAction];
    } else {
        [self pauseAction];
    }
    
    if (_isGamePaused) {
        if (_isPlayingQuickTick) {
            [MCSoundBoard pauseAudioForKey:@"quick_tick"];
        }
    } else {
        if (_isPlayingQuickTick) {
            [MCSoundBoard playAudioForKey:@"quick_tick"];
        }
    }
}

-(void)pauseAction {
    [_timer setFireDate:[NSDate distantFuture]];
    _ivPlayPause.image = [UIImage imageNamed:@"play"];
    _viewPauseBlock.hidden = NO;
    _viewPausePanel.hidden = YES;
    
    _isGamePaused = YES;
}

-(void)resumeAction {
    [_timer setFireDate:[NSDate date]];
    _ivPlayPause.image = [UIImage imageNamed:@"pause"];
    _viewPauseBlock.hidden = YES;
    
    _isGamePaused = NO;
}

-(void)tapTeam1Action:(id)sender {
    [_viewTeam1Progress tapAction:nil];
}

-(void)tapTeam2Action:(id)sender {
    [_viewTeam2Progress tapAction:nil];
}

@end
