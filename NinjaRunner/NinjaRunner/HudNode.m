//
//  HudNode.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/7/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "HudNode.h"
#import "Util.h"

@implementation HudNode

+ (instancetype)hudAtPosition:(CGPoint)position withFrame:(CGRect)frame {
    HudNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 10;
    hud.score = 0;
    hud.kills = 0;

    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = ScoreLabelName;
    scoreLabel.text = @"0";
    scoreLabel.fontSize = 24;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    float margin = frame.size.width * MarginPercent;
    scoreLabel.position = CGPointMake(frame.size.width - margin * 2, - margin);
    [hud addChild:scoreLabel];
    
    hud.pauseButton = [SKSpriteNode spriteNodeWithImageNamed:@"pause_button"];
    hud.pauseButton.anchorPoint = CGPointMake(0, 1);
    hud.pauseButton.xScale = 0.15;
    hud.pauseButton.yScale = 0.15;
    hud.pauseButton.position = CGPointMake(margin, margin);
    [hud addChild:hud.pauseButton];
    
    SKSpriteNode *musicButton = [SKSpriteNode spriteNodeWithImageNamed:@"music_icon"];
    musicButton.name = @"musicButton";
    musicButton.xScale = 0.2;
    musicButton.yScale = 0.2;
    musicButton.position = CGPointMake(frame.size.width / 2, -margin);
    
    [hud addChild:musicButton];
    
    return hud;
}

- (void) addPoints:(NSInteger) points {
    self.score += points;
    
    SKLabelNode *scoreLabel = (SKLabelNode *)[self childNodeWithName:ScoreLabelName];
    scoreLabel.text = [NSString stringWithFormat:@"%li", (long)self.score];
}

@end
