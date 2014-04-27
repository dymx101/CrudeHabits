//
//  GNCategoryCell.h
//  CrudeHabits
//
//  Created by Dong Yiming on 4/27/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNCategoryCell : UITableViewCell
@property (nonatomic, strong) UILabel       *lblTitle;
@property (nonatomic, assign) BOOL          checked;

+(CGFloat)cellHeight;
@end
