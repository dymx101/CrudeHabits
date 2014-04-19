//
//  GNGameVC.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNGameVC.h"

@interface GNGameVC () {
    UILabel     *_lblWord;
}

@property (nonatomic, strong)     UIButton    *btnNext;

@end

@implementation GNGameVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _lblWord = [UILabel new];
    _lblWord.font = [UIFont boldSystemFontOfSize:45];
    _lblWord.textColor = [UIColor whiteColor];
    _lblWord.numberOfLines = 0;
    _lblWord.textAlignment = NSTextAlignmentCenter;
    _lblWord.text = @"Twerking";
    [self.view addSubview:_lblWord];
    [_lblWord alignCenterXWithView:self.view predicate:nil];
    [_lblWord alignTopEdgeWithView:self.view predicate:@"140"];
    
    
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
}

@end
