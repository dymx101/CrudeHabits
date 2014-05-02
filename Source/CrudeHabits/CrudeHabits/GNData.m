//
//  GNData.m
//  CrudeHabits
//
//  Created by Dong Yiming on 4/27/14.
//  Copyright (c) 2014 Gagein. All rights reserved.
//

#import "GNData.h"

@implementation GNData
DEF_SINGLETON(GNData)

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self readCategories];
        [self readWords];
    }
    return self;
}

-(void)readCategories {
    if (_categories == nil) {
        _categories = [NSMutableArray array];
    }
    
    NSString *catPath = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
    NSArray *categorieDics = [NSArray arrayWithContentsOfFile:catPath];
    for (NSDictionary *cateDic in categorieDics) {

        GNCategory *category = [GNCategory newWithDic:cateDic];
        if (category.ID != kCategoryTodaysStars) {  // leave out Today's Stars
            [_categories addObject:category];
        }
    }
}

-(void)readWords {
    
    if (_words == nil) {
        _words = [NSMutableArray array];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    NSArray *wordDics = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *wordDic in wordDics) {
        GNWord *word = [GNWord newWithDic:wordDic];
        [_words addObject:word];
    }
}

-(NSArray *)wordsWithCategoryID:(long long)aCategoryID {
    
    NSMutableArray *words = [NSMutableArray array];
    
    if (aCategoryID == kCategoryCurveBall) {
        
        for (GNWord *word in _words) {
            // leave out Today's Stars
            if (word.categoryID != kCategoryTodaysStars) {
                [words addObject:word];
            }
        }
        
    } else {
        for (GNWord *word in _words) {
            if (word.categoryID == aCategoryID) {
                [words addObject:word];
            }
        }
    }
    
    return words;
}

@end
