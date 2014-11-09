//
//  HudNode.h
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/7/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HudNode : SKNode

+ (instancetype) hudAtPosition:(CGPoint)position withFrame:(CGRect)frame;

@property NSInteger score;
@property NSInteger kills;

- (void) addPoints:(NSInteger)points;

@end
