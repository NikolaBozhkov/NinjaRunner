//
//  ProfileDetails.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/9/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "ProfileDetails.h"

@implementation ProfileDetails

static NSString *DefaultProfileName = @"Player";

static NSString *NameKey = @"name";
static NSString *HighScoreKey = @"highscore";
static NSString *TotalScoreKey = @"totalscore";
static NSString *MostKillsKey = @"mostkills";
static NSString *TotalKillsKey = @"totalkills";
static NSString *LongestGameTimeKey = @"longestgametime";
static NSString *TotalGameTimeKey = @"totalgametime";

- (instancetype) init {
    if (self = [super init]) {
        self.name = DefaultProfileName;
        self.highScore = 0;
        self.totalScore = 0;
        self.mostKills = 0;
        self.totalKills = 0;
        self.longestGameTime = 0;
        self.totalGameTime = 0;
    }
    
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        self.name = [decoder decodeObjectForKey:NameKey];
        self.highScore = [decoder decodeIntegerForKey:HighScoreKey];
        self.totalScore = [decoder decodeIntegerForKey:TotalScoreKey];
        self.mostKills = [decoder decodeIntegerForKey:MostKillsKey];
        self.totalKills = [decoder decodeIntegerForKey:TotalKillsKey];
        self.longestGameTime = [decoder decodeDoubleForKey:LongestGameTimeKey];
        self.totalGameTime = [decoder decodeDoubleForKey:TotalGameTimeKey];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:NameKey];
    [encoder encodeInteger:self.highScore forKey:HighScoreKey];
    [encoder encodeInteger:self.totalScore forKey:TotalScoreKey];
    [encoder encodeInteger:self.mostKills forKey:MostKillsKey];
    [encoder encodeInteger:self.totalKills forKey:TotalKillsKey];
    [encoder encodeDouble:self.longestGameTime forKey:LongestGameTimeKey];
    [encoder encodeDouble:self.totalGameTime forKey:TotalGameTimeKey];
}

@end
