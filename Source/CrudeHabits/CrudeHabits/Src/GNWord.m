//
//  GNWord.m
//  CrudeHabits
//
//  Created by Dong Yiming on 5/1/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNWord.h"

@implementation GNWord

-(void)initWithDic:(NSDictionary *)aDic {
    [super initWithDic:aDic];
    
    self.categoryID = [[aDic objectForKey:@"catid"] longLongValue];
}

@end
