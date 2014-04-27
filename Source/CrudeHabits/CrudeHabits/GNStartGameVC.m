//
//  GNStartGameVC.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/19/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNStartGameVC.h"
#import "GNGameVC.h"

@interface GNStartGameVC () {
    UILabel         *_lblCategoryChooseTitle;
    UILabel         *_lblCategoryName;
    
    UIButton        *_btnPrev;
    UIButton        *_btnNext;
    
    NSArray         *_categories;
    NSInteger      _categoryIndex;
}

@property (nonatomic, strong)     UIButton    *btnStart;

@end

@implementation GNStartGameVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _categories = [[GNData sharedInstance] categories];
    
    _lblCategoryChooseTitle = [UILabel new];
    _lblCategoryChooseTitle.font = [UIFont fontWithName:FONT_REGULAR size:25];
    _lblCategoryChooseTitle.textColor = [UIColor whiteColor];
    _lblCategoryChooseTitle.numberOfLines = 0;
    _lblCategoryChooseTitle.textAlignment = NSTextAlignmentCenter;
    _lblCategoryChooseTitle.text = @"Choose a Category";
    [self.view addSubview:_lblCategoryChooseTitle];
    [_lblCategoryChooseTitle alignLeading:@"5" trailing:@"-5" toView:self.view];
    [_lblCategoryChooseTitle alignTopEdgeWithView:self.view predicate:@"100"];
    
    
    _lblCategoryName = [UILabel new];
    _lblCategoryName.font = [UIFont fontWithName:FONT_REGULAR size:45];
    _lblCategoryName.textColor = [UIColor whiteColor];
    _lblCategoryName.numberOfLines = 0;
    _lblCategoryName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_lblCategoryName];
    [_lblCategoryName alignCenterXWithView:self.view predicate:nil];
    [_lblCategoryName constrainTopSpaceToView:_lblCategoryChooseTitle predicate:@"40"];
    
    
    //////
    _btnPrev = [UIButton new];
    _btnPrev.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];
    [_btnPrev setTitleColor:[FDColor sharedInstance].white forState:UIControlStateNormal];
    [_btnPrev setTitle:@"<" forState:UIControlStateNormal];
    [self.view addSubview:_btnPrev];
    [_btnPrev alignCenterYWithView:_lblCategoryName predicate:nil];
    [_btnPrev alignLeadingEdgeWithView:self.view predicate:@"20"];
    
    //////
    _btnNext = [UIButton new];
    _btnNext.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];
    [_btnNext setTitleColor:[FDColor sharedInstance].white forState:UIControlStateNormal];
    [_btnNext setTitle:@">" forState:UIControlStateNormal];
    [self.view addSubview:_btnNext];
    [_btnNext alignCenterYWithView:_lblCategoryName predicate:nil];
    [_btnNext alignTrailingEdgeWithView:self.view predicate:@"-20"];
    
    
    //////
    _btnStart = [UIButton new];
    _btnStart.backgroundColor = [UIColor whiteColor];
    _btnStart.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];
    [_btnStart setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
    [_btnStart setTitle:@"Start" forState:UIControlStateNormal];
    _btnStart.layer.cornerRadius = 10.f;
    [self.view addSubview:_btnStart];
    
    [_btnStart constrainWidth:@"200" height:@"45"];
    [_btnStart alignCenterXWithView:self.view predicate:@"0"];
    [_btnStart constrainTopSpaceToView:_lblCategoryName predicate:@"90"];
    
    [_btnStart addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btnPrev addTarget:self action:@selector(prevAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnNext addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateCategoryName];
}


#pragma mark - actions
-(void)startAction:(id)sender {
    GNGameVC *vc = [GNGameVC new];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)prevAction {
    _categoryIndex --;
    [self cycleCategoryIndex];
    [self updateCategoryName];
}

-(void)nextAction {
    _categoryIndex ++;
    [self cycleCategoryIndex];
    [self updateCategoryName];
}

-(void)cycleCategoryIndex {
    
    NSUInteger count = _categories.count;
    if (count <= 0) {
        return;
    }
    
    if (_categoryIndex >= count) {
        _categoryIndex = 0;
    } else if (_categoryIndex < 0) {
        _categoryIndex = count - 1;
    }
}

-(void)updateCategoryName {
    _lblCategoryName.text = _categories[_categoryIndex];
}

@end
