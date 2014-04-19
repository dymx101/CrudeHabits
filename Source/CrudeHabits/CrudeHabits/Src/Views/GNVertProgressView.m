//
//  GNVertProgressView.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNVertProgressView.h"

@interface GNVertProgressView () {
    CGFloat         _progress;
    UIView          *_progressBar;
    
    NSLayoutConstraint  *_constraintProgressHeight;
}

@end

@implementation GNVertProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [FDColor sharedInstance].themeRed;
        self.layer.cornerRadius = 5.f;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2.f;
        
        _progressBar = [UIView new];
        _progressBar.backgroundColor = [UIColor whiteColor];
        _progressBar.layer.cornerRadius = 5.f;
        [self addSubview:_progressBar];
        [_progressBar alignLeading:@"0" trailing:@"0" toView:self];
        [_progressBar alignBottomEdgeWithView:self predicate:@"0"];
        
        _constraintProgressHeight = [NSLayoutConstraint constraintWithItem:_progressBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:0];
        [self addConstraint:_constraintProgressHeight];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


-(void)tapAction:(id)sender {
    if (_progress < 1.f) {
        _progress += .2f;
        
        [self removeConstraint:_constraintProgressHeight];
        _constraintProgressHeight = [NSLayoutConstraint constraintWithItem:_progressBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:_progress constant:0];
        [self addConstraint:_constraintProgressHeight];
        
        [_delegate progressView:self progressChanged:_progress];
    }
}


@end
