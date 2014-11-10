//
//  ParseHelper.h
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/8/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Util.h"
#import "PlayerScore.h"

@interface ParseHelper : NSObject

+ (PlayerScore *) getPlayerScore;
+ (void) savePlayerScore:(PlayerScore *)playerScore;
+ (void) savePlayerScoreName:(NSString *)name;
+ (void) getTopTenPlayerScoresWithBlock:(void(^)(NSArray *playerScoreArray))block;

@end
