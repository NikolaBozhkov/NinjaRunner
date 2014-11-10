//
//  LeaderboardScene.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/10/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "LeaderboardScene.h"
#import "Util.h"

@implementation LeaderboardScene

- (void) didMoveToView:(SKView *)view {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"tutorial_scene_background"];
    background.size = self.view.bounds.size;
    background.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    background.zPosition = -1;
    [self addChild:background];
    
    NSString *normalFont = @"Futura-CondensedExtraBold";
    NSInteger fontSize = self.frame.size.height * 0.07;
    float margin = self.frame.size.height * MarginPercent * 2;
    
    SKLabelNode *headerLabel = [Util createLabelWithFont:normalFont text:@"Profile Overview" fontColor:[SKColor whiteColor] fontSize:fontSize * 1.2];
    headerLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - headerLabel.frame.size.height - margin);
    [self addChild:headerLabel];
}

@end
