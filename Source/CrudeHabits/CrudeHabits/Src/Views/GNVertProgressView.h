//
//  GNVertProgressView.h
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GNVertProgressView;

@protocol GNVertProgressViewDelegate

 @required
-(void)progressView:(GNVertProgressView *)aProgressView progressChanged:(CGFloat)aProgress;

@end


@interface GNVertProgressView : UIView
@property (nonatomic, weak) id<GNVertProgressViewDelegate>  delegate;
@end
