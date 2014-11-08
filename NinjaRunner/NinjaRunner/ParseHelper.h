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

@interface ParseHelper : NSObject

+ (NSNumber *) getHighScore;
+ (void) saveHighScore:(NSInteger)highScore;

@end
