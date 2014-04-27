//
//  GNSuggestionVC.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/26/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNSuggestionVC.h"
#import "GNCategoryCell.h"
#import <MessageUI/MessageUI.h>

#define STR_CELL_ID     @"STR_CELL_ID"

@interface GNSuggestionVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MFMailComposeViewControllerDelegate> {
    UIScrollView        *_svContent;
    
    //UIView          *_viewHideKeyboard;
    
    UIButton        *_btnClose;
    
    UILabel         *_lblTitle;
    UILabel         *_lblChooseACategory;
    UITableView     *_tvCategories;
    UITextField     *_tfNewCategory;
    //UILabel         *_lblSuggestAWord;
    UITextField     *_tfNewWord;
    UIButton        *_btnSubmit;
    
    NSArray         *_categories;
    NSInteger       _selectedIndex;
}

@end

@implementation GNSuggestionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _categories = [[GNData sharedInstance] categories];

    _svContent = [UIScrollView new];
    _svContent.alwaysBounceVertical = YES;
    _svContent.delegate = self;
    //_svContent.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_svContent];
    [_svContent alignTop:@"70" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
    
//    _viewHideKeyboard = [UIView new];
//    _viewHideKeyboard.backgroundColor = [UIColor blueColor];
//    [_svContent addSubview:_viewHideKeyboard];
//    [_viewHideKeyboard alignToView:_svContent];
    
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
    [_svContent addSubview:_lblTitle];
    [_lblTitle alignCenterXWithView:_svContent predicate:nil];
    [_lblTitle alignTopEdgeWithView:_svContent predicate:@"15"];
    
    _lblChooseACategory = [UILabel new];
    _lblChooseACategory.textColor = [FDColor sharedInstance].white;
    _lblChooseACategory.font = [UIFont fontWithName:FONT_REGULAR size:20];
    _lblChooseACategory.text = @"Choose a Category";
    [_svContent addSubview:_lblChooseACategory];
    [_lblChooseACategory alignCenterXWithView:_svContent predicate:nil];
    [_lblChooseACategory constrainTopSpaceToView:_lblTitle predicate:@"15"];
    
    _tvCategories = [UITableView new];
    _tvCategories.delegate = self;
    _tvCategories.dataSource = self;
    _tvCategories.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tvCategories registerClass:[GNCategoryCell class] forCellReuseIdentifier:STR_CELL_ID];
    [_svContent addSubview:_tvCategories];
    [_tvCategories alignCenterXWithView:_svContent predicate:nil];
    [_tvCategories constrainTopSpaceToView:_lblChooseACategory predicate:@"5"];
    [_tvCategories constrainWidth:@"250" height:@"100"];
    _tvCategories.backgroundColor = [FDColor sharedInstance].clear;
    
    _tfNewCategory = [UITextField new];
    _tfNewCategory.delegate = self;
    _tfNewCategory.backgroundColor = [UIColor whiteColor];
    _tfNewCategory.layer.cornerRadius = 5.f;
    _tfNewCategory.font = [UIFont fontWithName:FONT_REGULAR size:20];
    _tfNewCategory.textColor = [FDColor sharedInstance].themeRed;
    _tfNewCategory.textAlignment = NSTextAlignmentCenter;
    _tfNewCategory.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfNewCategory.autocorrectionType = UITextAutocorrectionTypeNo;
    _tfNewCategory.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"New Category" attributes:@{NSForegroundColorAttributeName: [FDColor sharedInstance].silver}];
    [_svContent addSubview:_tfNewCategory];
    [_tfNewCategory alignCenterXWithView:_svContent predicate:nil];
    [_tfNewCategory constrainTopSpaceToView:_tvCategories predicate:@"10"];
    [_tfNewCategory constrainWidth:@"200" height:@"30"];
    
    
    _tfNewWord = [UITextField new];
    _tfNewWord.delegate = self;
    _tfNewWord.backgroundColor = [UIColor whiteColor];
    _tfNewWord.layer.cornerRadius = 5.f;
    _tfNewWord.font = [UIFont fontWithName:FONT_REGULAR size:20];
    _tfNewWord.textColor = [FDColor sharedInstance].themeRed;
    _tfNewWord.textAlignment = NSTextAlignmentCenter;
    _tfNewWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfNewWord.autocorrectionType = UITextAutocorrectionTypeNo;
    _tfNewWord.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Suggest a word" attributes:@{NSForegroundColorAttributeName: [FDColor sharedInstance].silver}];
    [_svContent addSubview:_tfNewWord];
    [_tfNewWord alignCenterXWithView:_svContent predicate:nil];
    [_tfNewWord constrainTopSpaceToView:_tfNewCategory predicate:@"20"];
    [_tfNewWord constrainWidth:@"200" height:@"30"];
    
    _btnSubmit = [UIButton new];
    _btnSubmit.backgroundColor = [UIColor whiteColor];
    _btnSubmit.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:30];
    [_btnSubmit setTitleColor:[FDColor sharedInstance].themeRed forState:UIControlStateNormal];
    [_btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
    _btnSubmit.layer.cornerRadius = 10.f;
    [_svContent addSubview:_btnSubmit];
    
    [_btnSubmit constrainWidth:@"200" height:@"45"];
    [_btnSubmit alignCenterXWithView:_svContent predicate:@"0"];
    [_btnSubmit constrainTopSpaceToView:_tfNewWord predicate:@"20"];
    
    [_btnSubmit alignBottomEdgeWithView:_svContent predicate:@"0"];
    
    
    [_btnSubmit addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)quitAction:(id)sender {
    
    UIViewController *presentingVC = self.presentingViewController;
    [presentingVC dismissViewControllerAnimated:YES completion:^{
    }];
}



#pragma mark - table view delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GNCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:STR_CELL_ID forIndexPath:indexPath];
    
    NSString *cateStr = _categories[indexPath.row];
    cell.lblTitle.text = cateStr;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"did selected cell");
    _selectedIndex = indexPath.row;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [GNCategoryCell cellHeight];
}

#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _tfNewCategory) {
        [_svContent setContentOffset:CGPointMake(0, 100) animated:NO];
    } else if (textField == _tfNewWord) {
        [_svContent setContentOffset:CGPointMake(0, 100) animated:NO];
    }
}

#pragma mark - scroll view delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideKeyboardAction:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (result == MFMailComposeResultSent) {
        [SVProgressHUD showSuccessWithStatus:@"Sent OK!"];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - actions 
-(void)hideKeyboardAction:(id)sender {
    [_tfNewCategory resignFirstResponder];
    [_tfNewWord resignFirstResponder];
    
    [_svContent setContentOffset:CGPointMake(0, 0) animated:NO];
}

-(void)submitAction:(id)sender {
    if (_tfNewWord.text.length > 0 && [MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"Suggestions"];
        [controller setToRecipients:@[@"samlangon1@gmail.com"]];
    
        BOOL isCustomCategory = _tfNewCategory.text.length > 0;
        NSString *category = isCustomCategory ? _tfNewCategory.text : _categories[_selectedIndex];
        NSString *contentBody = [NSString stringWithFormat:@"Suggested Categories: '%@', %@.\n\nSuggested word: '%@'."
                                 , category
                                 , isCustomCategory ? @"is a new category" : @"is an exsisting category"
                                 , _tfNewWord.text];


        [controller setMessageBody:contentBody isHTML:NO];

        [self presentViewController:controller animated:YES completion:nil];
    }
}

@end
