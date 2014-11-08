//
//  ParseHelper.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/8/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "ParseHelper.h"

@implementation ParseHelper

static NSString *PlayerScoreClassName = @"PlayerScore";
static NSString *UserIdKey = @"userId";
static NSString *ScoreKey = @"score";
static NSString *NameKey = @"name";

+ (NSNumber *)getHighScore {
    __block NSNumber *highscore;
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceIdentifierString = [device.identifierForVendor UUIDString];
    
    PFQuery *query = [PFQuery queryWithClassName:PlayerScoreClassName];
    [query whereKey:UserIdKey equalTo:deviceIdentifierString];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *playerScoreArray, NSError *error) {
        if (!error) {
            if (playerScoreArray.count == 0) {
                highscore = nil;
            } else {
                highscore = [playerScoreArray.firstObject objectForKey:ScoreKey];
            }
        }
    }];
    
    return highscore;
}

+ (void)saveHighScore:(NSInteger)highScore {
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceIdentifierString = [device.identifierForVendor UUIDString];
    
    PFQuery *query = [PFQuery queryWithClassName:PlayerScoreClassName];
    [query whereKey:UserIdKey equalTo:deviceIdentifierString];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *playerScoreArray, NSError *error) {
        if (!error) {
            PFObject *playerScore = playerScoreArray.firstObject;
            
            if (!playerScore) {
                playerScore = [PFObject objectWithClassName:PlayerScoreClassName];
                playerScore[UserIdKey] = deviceIdentifierString;
                playerScore[NameKey] = @"Player";//(NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:NameKey];
            }
            
            playerScore[ScoreKey] = [NSNumber numberWithInteger:highScore];
            
            if ([Util checkInternetConnection]) {
                [playerScore saveInBackground];
            } else {
                [playerScore saveEventually];
            }
        }
    }];
}

@end
