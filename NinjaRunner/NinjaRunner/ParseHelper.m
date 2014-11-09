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
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceIdentifierString = [device.identifierForVendor UUIDString];
    
    PFQuery *query = [PlayerScore query];
    [query whereKey:UserIdKey equalTo:deviceIdentifierString];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *playerScoreArray, NSError *error) {
        if (!error) {
            PlayerScore *foundPlayer = playerScoreArray.firstObject;
            
            if (!foundPlayer) {
                foundPlayer = [PlayerScore object];
                foundPlayer.userId = deviceIdentifierString;
                foundPlayer.name = @"Player";//(NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:NameKey];
            }
            
            foundPlayer.score = playerScore.score;
            foundPlayer.kills = playerScore.kills;

            if ([Util checkInternetConnection]) {
                [foundPlayer saveInBackground];
            } else {
                [foundPlayer saveEventually];
            }
        }
    }];
}

@end
