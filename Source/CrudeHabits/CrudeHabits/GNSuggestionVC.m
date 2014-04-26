//
//  GNSuggestionVC.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/26/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNSuggestionVC.h"

@interface GNSuggestionVC () {
    UIButton        *_btnClose;
    UILabel         *_lblTitle;
    UILabel         *_lblChooseACategory;
    UITableView     *_tvCategories;
    UITextField     *_tfNewCategory;
    UILabel         *_lblSuggestAWord;
    UITextField     *_tfNewWord;
    UIButton        *_btnSubmit;
}

@end

@implementation GNSuggestionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _btnClose = [UIButton new];
    [_btnClose setImage:[UIImage imageNamed:@"close_white"] forState:UIControlStateNormal];
    [self.view addSubview:_btnClose];
    [_btnClose alignCenterYWithView:self.lblTitle predicate:nil];
    [_btnClose alignLeadingEdgeWithView:self.view predicate:@"10"];
    [_btnClose constrainWidth:@"26" height:@"26"];
    
    [_btnClose addTarget:self action:@selector(quitAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)quitAction:(id)sender {
    
    UIViewController *presentingVC = self.presentingViewController;
    [presentingVC dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
