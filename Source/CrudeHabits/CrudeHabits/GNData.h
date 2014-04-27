//
//  GNData.h
//  CrudeHabits
//
//  Created by Dong Yiming on 4/27/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNData : NSObject
AS_SINGLETON(GNData)

-(NSArray *)words;
-(NSArray *)categories;

@end
