//
//  GNModel.h
//  CrudeHabits
//
//  Created by Dong Yiming on 5/1/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNModel : NSObject
@property (nonatomic, assign) long long         ID;
@property (nonatomic, copy)     NSString        *name;

+(id)newWithDic:(NSDictionary *)aDic;
-(void)initWithDic:(NSDictionary *)aDic;
@end
