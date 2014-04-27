//
//  GNCategoryCell.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/27/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNCategoryCell.h"

@interface GNCategoryCell () {
    UIView      *_viewBg;
}

@end

@implementation GNCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _viewBg = [UIView new];
        _viewBg.layer.cornerRadius = 5.f;
        [self.contentView addSubview:_viewBg];
        [_viewBg alignToView:self.contentView];
        
        _lblTitle = [UILabel new];
        _lblTitle.font = [UIFont fontWithName:FONT_REGULAR size:20];
        _lblTitle.textColor = [FDColor sharedInstance].white;
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        [_viewBg addSubview:_lblTitle];
        [_lblTitle alignToView:_viewBg];
    }
    return self;
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
//
//    [super setHighlighted:highlighted animated:animated];
//    
//    _lblTitle.textColor = highlighted ? [FDColor sharedInstance].themeRed : [UIColor whiteColor];
//    _viewBg.backgroundColor = highlighted ? [UIColor colorWithWhite:1 alpha:.8] : [UIColor clearColor];
//}


-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    _lblTitle.textColor = selected ? [FDColor sharedInstance].themeRed : [UIColor whiteColor];
    _viewBg.backgroundColor = selected ? [UIColor colorWithWhite:1 alpha:.8] : [UIColor clearColor];
}

+(CGFloat)cellHeight {
    return 25;
}

@end
