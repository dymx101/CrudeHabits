//
//  GNData.h
//  CrudeHabits
//
//  Created by Dong Yiming on 4/27/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kCategoryCurveBall = 0      // random
    , kCategoryWork
    , kCategoryDirtyDogs
    , kCategoryEverydayLife
    , kCategoryCollege
    , kCategoryTodaysStars
}ECategory;

@interface GNData : NSObject
AS_SINGLETON(GNData)

@property (nonatomic, strong) NSMutableArray *words;
@property (nonatomic, strong) NSMutableArray *categories;

-(NSArray *)wordsWithCategoryID:(long long)aCategoryID;

@end
