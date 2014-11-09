//
//  Util.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/4/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "Util.h"
#import "Reachability.h"

@implementation Util

+ (SKLabelNode *) createLabelWithFont:(NSString *)font text:(NSString *)text fontColor:(SKColor *)color fontSize:(NSInteger)fontSize {
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:font];
    label.text = text;
    label.fontColor = color;
    label.fontSize = fontSize;
    return label;
}

+ (BOOL)checkInternetConnection {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}

+ (void) saveProfileDetails:(ProfileDetails *)profile {
    NSData *encodedProfile = [NSKeyedArchiver archivedDataWithRootObject:profile];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedProfile forKey:ProfileDetailsKey];
    [defaults synchronize];
}

+ (ProfileDetails *) loadProfileDetails {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedProfile = [defaults objectForKey:ProfileDetailsKey];
    
    if (!encodedProfile) {
        return nil;
    }
    
    ProfileDetails *profile = [NSKeyedUnarchiver unarchiveObjectWithData:encodedProfile];
    return profile;
}

@end
