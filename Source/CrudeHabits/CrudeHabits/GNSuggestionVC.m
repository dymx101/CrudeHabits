//
//  GNSuggestionVC.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/26/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNSuggestionVC.h"
#import "GNCategoryCell.h"

#define STR_CELL_ID     @"STR_CELL_ID"

@interface GNSuggestionVC () <UITableViewDelegate, UITableViewDataSource> {
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
    
    _lblTitle = [UILabel new];
    _lblTitle.textColor = [FDColor sharedInstance].white;
    _lblTitle.font = [UIFont fontWithName:FONT_BOLD size:30];
    _lblTitle.text = @"Suggestions";
    [self.view addSubview:_lblTitle];
    [_lblTitle alignCenterXWithView:self.view predicate:nil];
    [_lblTitle alignTopEdgeWithView:self.view predicate:@"85"];
    
    _lblChooseACategory = [UILabel new];
    _lblChooseACategory.textColor = [FDColor sharedInstance].white;
    _lblChooseACategory.font = [UIFont fontWithName:FONT_REGULAR size:20];
    _lblChooseACategory.text = @"Choose a Category";
    [self.view addSubview:_lblChooseACategory];
    [_lblChooseACategory alignCenterXWithView:self.view predicate:nil];
    [_lblChooseACategory constrainTopSpaceToView:_lblTitle predicate:@"15"];
    
    _tvCategories = [UITableView new];
    _tvCategories.delegate = self;
    _tvCategories.dataSource = self;
    _tvCategories.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tvCategories registerClass:[GNCategoryCell class] forCellReuseIdentifier:STR_CELL_ID];
    [self.view addSubview:_tvCategories];
    [_tvCategories alignCenterXWithView:self.view predicate:nil];
    [_tvCategories constrainTopSpaceToView:_lblChooseACategory predicate:@"5"];
    [_tvCategories constrainWidth:@"250" height:@"125"];
    _tvCategories.backgroundColor = [FDColor sharedInstance].clear;
}


-(void)quitAction:(id)sender {
    
    UIViewController *presentingVC = self.presentingViewController;
    [presentingVC dismissViewControllerAnimated:YES completion:^{
    }];
}



#pragma mark - table view delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GNCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:STR_CELL_ID forIndexPath:indexPath];
    cell.lblTitle.text = @"Colleage";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [GNCategoryCell cellHeight];
}

@end
