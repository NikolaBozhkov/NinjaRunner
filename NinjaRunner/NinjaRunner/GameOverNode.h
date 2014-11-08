//
//  GameOverNode.h
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/8/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "Util.h"

@interface GameOverNode : SKNode

+ (instancetype) gameOverAtPosition:(CGPoint)position score:(NSInteger)score scene:(GameScene *)scene;

@end
