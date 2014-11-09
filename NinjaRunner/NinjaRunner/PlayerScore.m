//
//  PlayerScore.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/9/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "PlayerScore.h"

@implementation PlayerScore

@dynamic userId;
@dynamic name;
@dynamic score;
@dynamic kills;

+ (void) load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"PlayerScore";
}

@end
