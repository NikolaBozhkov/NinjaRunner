//
//  PlayerScore.h
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/9/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PlayerScore : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger kills;

@end
