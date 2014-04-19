//
//  GNSplashView.h
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNSplashView : UIView

@property (nonatomic, strong)     UIButton    *btnPlay;
@property (nonatomic, strong)     UIButton    *btnHowItWorks;

-(void)runAnimation;
@end
