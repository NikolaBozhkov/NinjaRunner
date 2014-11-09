//
//  ProfileDetails.h
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/9/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileDetails : NSObject

- (instancetype) initWithCoder:(NSCoder *)decoder;
- (void) encodeWithCoder:(NSCoder *)encoder;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger highScore;
@property (nonatomic, assign) NSInteger totalScore;
@property (nonatomic, assign) NSInteger mostKills;
@property (nonatomic, assign) NSInteger totalKills;
@property (nonatomic, assign) NSTimeInterval longestGameTime;
@property (nonatomic, assign) NSTimeInterval totalGameTime;

@end
