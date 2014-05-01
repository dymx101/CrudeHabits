//
//  GNModel.m
//  CrudeHabits
//
//  Created by Dong Yiming on 5/1/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNModel.h"

@implementation GNModel

+(id)newWithDic:(NSDictionary *)aDic {
    id me = [self new];
    [me initWithDic:aDic];
    
    return me;
}

-(void)initWithDic:(NSDictionary *)aDic {
    self.ID = [[aDic objectForKey:@"id"] longLongValue];
    self.name = [aDic objectForKey:@"name"];
}

@end
