//
//  ParseHelper.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/8/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "ParseHelper.h"
#import "PlayerScore.h"

@implementation ParseHelper

static NSString *UserIdKey = @"userId";

// TODO: Fix logic, the block should do the work
+ (PlayerScore *)getPlayerScore {
    __block PlayerScore *playerScore;
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceIdentifierString = [device.identifierForVendor UUIDString];
    
    PFQuery *query = [PlayerScore query];
    [query whereKey:UserIdKey equalTo:deviceIdentifierString];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *playerScoreArray, NSError *error) {
        if (!error) {
            if (playerScoreArray.count == 0) {
                playerScore = nil;
            } else {
                playerScore = playerScoreArray.firstObject;
            }
        }
    }];
    
    return playerScore;
}

+ (void)savePlayerScore:(PlayerScore *)playerScore {
    [self savePlayerScoreWithBlock:^(NSArray *playerScoreArray) {
        PlayerScore *foundPlayer = playerScoreArray.firstObject;
        
        if (!foundPlayer) {
            foundPlayer = [PlayerScore object];
            foundPlayer.userId = [UIDevice currentDevice].identifierForVendor.UUIDString;
        }
        
        foundPlayer.score = playerScore.score;
        foundPlayer.kills = playerScore.kills;
        foundPlayer.name = Profile.name;
        
        if ([Util checkInternetConnection]) {
            [foundPlayer saveInBackground];
        } else {
            [foundPlayer saveEventually];
        }
    }];
}

+ (void) savePlayerScoreName:(NSString *)name {
    [self savePlayerScoreWithBlock:^(NSArray *playerScoreArray) {
        PlayerScore *foundPlayer = playerScoreArray.firstObject;
        
        if (!foundPlayer) {
            foundPlayer = [PlayerScore object];
            foundPlayer.userId = [UIDevice currentDevice].identifierForVendor.UUIDString;
            foundPlayer.score = Profile.highScore;
            foundPlayer.kills = Profile.totalKills;
        }

        foundPlayer.name = Profile.name;
        
        if ([Util checkInternetConnection]) {
            [foundPlayer saveInBackground];
        } else {
            [foundPlayer saveEventually];
        }
    }];
}

+ (void)getTopTenPlayerScoresWithBlock:(void(^)(NSArray *playerScoreArray))block {
    PFQuery *query = [PlayerScore query];
    [query orderByDescending:@"score"];
    query.limit = 10;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *playerScoreArray, NSError *error) {
        if (!error) {
            block(playerScoreArray);
        }
    }];
}

+ (void) savePlayerScoreWithBlock:(void(^)(NSArray *playerScoreArray))block {
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceIdentifierString = [device.identifierForVendor UUIDString];
    
    PFQuery *query = [PlayerScore query];
    [query whereKey:UserIdKey equalTo:deviceIdentifierString];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *playerScoreArray, NSError *error) {
        if (!error) {
            block(playerScoreArray);
        }
    }];
}

@end
