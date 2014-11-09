//
//  TutorialScene.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/9/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "TutorialScene.h"
#import "Util.h"
#import "NinjaNode.h"
#import "GroundNode.h"
#import "HomeScene.h"

@implementation TutorialScene

static NSString *BackLabelName = @"BackLabel";

- (void) didMoveToView:(SKView *)view {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"tutorial_scene_background"];
    background.size = self.view.bounds.size;
    background.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    background.zPosition = -1;
    [self addChild:background];
    
    SKLabelNode *backLabel = [Util createLabelWithFont:@"Chalkduster" text:@"Back" fontColor:[SKColor blueColor] fontSize:25];
    float backLabelMargin = self.frame.size.width * 0.03;
    backLabel.position = CGPointMake(backLabel.frame.size.width / 2 + backLabelMargin, backLabelMargin);
    backLabel.name = BackLabelName;
    [self addChild:backLabel];
    
    [self setupTurorial];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    SKTransition *transition = [SKTransition fadeWithDuration:0.4];
    
    if (node.name == BackLabelName) {
        HomeScene *homeScene = [HomeScene sceneWithSize:self.frame.size];
        [self.view presentScene:homeScene transition:transition];
    }
}

- (void) setupTurorial {
    NSString *normalFont = @"Futura-CondensedExtraBold";
    NSInteger fontSize = self.frame.size.height * 0.07;
    float margin = self.frame.size.height * MarginPercent;
    
    NSString *runText = @"You are always running";
    SKLabelNode *runLabel = [Util createLabelWithFont:normalFont text:runText fontColor:[SKColor blackColor] fontSize:fontSize];
    runLabel.position = CGPointMake(runLabel.frame.size.width / 2 + margin,
                                    self.frame.size.height - runLabel.frame.size.height - margin * 3);
    [self addChild:runLabel];
    
    NinjaNode *runNinja = [NinjaNode ninjaWithPosition:CGPointZero inScene:self];
    runNinja.position = CGPointMake(self.frame.size.width - runNinja.frame.size.width / 2 - margin * 5, runLabel.position.y);
    runNinja.physicsBody.affectedByGravity = NO;
    [self addChild:runNinja];
    
    NSString *jumpText = @"Swipe up to jump, double swipe is double jump";
    SKLabelNode *jumpLabel = [Util createLabelWithFont:normalFont text:jumpText fontColor:[SKColor blackColor] fontSize:fontSize];
    jumpLabel.position = CGPointMake(jumpLabel.frame.size.width / 2 + margin,
                                     runLabel.position.y - jumpLabel.frame.size.height - margin * 3);
    [self addChild:jumpLabel];
    
    NinjaNode *jumpNinja = [NinjaNode ninjaWithPosition:CGPointZero inScene:self];
    jumpNinja.position = CGPointMake(self.frame.size.width - jumpNinja.frame.size.width / 2 - margin * 5, jumpLabel.position.y);
    jumpNinja.physicsBody.affectedByGravity = NO;
    [jumpNinja runAction:[SKAction repeatActionForever:jumpNinja.jumpAnimation]];
    [self addChild:jumpNinja];
    
    NSString *attackText = @"Swipe right to attack";
    SKLabelNode *attackLabel = [Util createLabelWithFont:normalFont text:attackText fontColor:[SKColor blackColor] fontSize:fontSize];
    attackLabel.position = CGPointMake(attackLabel.frame.size.width / 2 + margin,
                                       jumpLabel.position.y - attackLabel.frame.size.height - margin * 3);
    [self addChild:attackLabel];
    
    NinjaNode *attackNinja = [NinjaNode ninjaWithPosition:CGPointZero inScene:self];
    attackNinja.position = CGPointMake(attackLabel.position.x + attackLabel.frame.size.width / 2 + margin * 5, attackLabel.position.y);
    attackNinja.physicsBody.affectedByGravity = NO;
    [attackNinja tutorialAttack];
    [self addChild:attackNinja];
    
    NSString *powerAttackText = @"Double touch for power attack";
    SKLabelNode *powerAttackLabel = [Util createLabelWithFont:normalFont text:powerAttackText fontColor:[SKColor blackColor] fontSize:fontSize];
    powerAttackLabel.position = CGPointMake(powerAttackLabel.frame.size.width / 2 + margin,
                                            attackLabel.position.y - powerAttackLabel.frame.size.height - margin * 3);
    [self addChild:powerAttackLabel];
    
    NinjaNode *powerAttackNinja = [NinjaNode ninjaWithPosition:CGPointZero inScene:self];
    powerAttackNinja.position = CGPointMake(powerAttackLabel.position.x + powerAttackLabel.frame.size.width / 2 + margin * 5, powerAttackLabel.position.y);
    powerAttackNinja.physicsBody.affectedByGravity = NO;
    [powerAttackNinja tutorialPowerAttack];
    [self addChild:powerAttackNinja];
    
    NSString *chargedAttackText = [NSString stringWithFormat:@"Long press for %0.lf second to charge your next attack", ChargeAttackDuration];
    SKLabelNode *chargedAttackLabel = [Util createLabelWithFont:normalFont text:chargedAttackText fontColor:[SKColor blackColor] fontSize:fontSize];
    chargedAttackLabel.position = CGPointMake(chargedAttackLabel.frame.size.width / 2 + margin,
                                              powerAttackLabel.position.y - chargedAttackLabel.frame.size.height - margin * 3);
    [self addChild:chargedAttackLabel];
}

@end
