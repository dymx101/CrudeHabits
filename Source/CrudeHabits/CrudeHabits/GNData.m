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


-(NSArray *)words {
    return @[@"Twerking", @"Moonwalk", @"LOL", @"Bookworm", @"Snicker"];
}


-(NSArray *)categories {
    return @[@"College", @"Urban", @"Business"];
}

@end
