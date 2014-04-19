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
}

@end
