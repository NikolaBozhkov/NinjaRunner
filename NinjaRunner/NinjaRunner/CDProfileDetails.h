//
//  PlayerScoreCD.h
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/10/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDProfileDetails : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * totalScore;
@property (nonatomic, retain) NSNumber * highScore;
@property (nonatomic, retain) NSNumber * mostKills;
@property (nonatomic, retain) NSNumber * totalKills;
@property (nonatomic, retain) NSNumber * longestGame;
@property (nonatomic, retain) NSNumber * totalGameTime;

@end
