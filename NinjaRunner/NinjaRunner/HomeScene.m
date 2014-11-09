//
//  HomeScene.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/8/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "HomeScene.h"
#import "GameScene.h"
#import "TutorialScene.h"
#import "Util.h"
#import "ProfileScene.h"

@implementation HomeScene

static NSString *playLabelName = @"Play";
static NSString *tutorialLabelName = @"Tutorial";
static NSString *profileLabelName = @"Profile";
static NSString *leaderboardLabelName = @"Leaderboard";

- (void)didMoveToView:(SKView *)view {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"home_screen_background"];
    background.size = self.view.bounds.size;
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    
    float labelMargin = self.frame.size.height * MarginPercent * 2;
    float fontSize = self.frame.size.height * 0.1;
    
    NSString *titleFont = @"Chalkduster";
    SKLabelNode *titleLabel = [Util createLabelWithFont:titleFont text:GameTitle fontColor:[SKColor whiteColor] fontSize:fontSize * 1.3];
    titleLabel.position = CGPointMake(self.frame.size.width / 2,
                                      self.frame.size.height - titleLabel.frame.size.height - labelMargin);
    [self addChild:titleLabel];
    
    SKLabelNode *playLabel = [Util createLabelWithFont:titleFont text:playLabelName fontColor:[SKColor whiteColor] fontSize:fontSize];
    playLabel.name = playLabelName;
    playLabel.position = CGPointMake(self.frame.size.width - playLabel.frame.size.width / 2 - labelMargin,
                                     titleLabel.position.y - playLabel.frame.size.height - labelMargin);
    [self addChild:playLabel];
    
    SKLabelNode *tutorialLabel = [Util createLabelWithFont:titleFont text:tutorialLabelName fontColor:[SKColor whiteColor] fontSize:fontSize];
    tutorialLabel.name = tutorialLabelName;
    tutorialLabel.position = CGPointMake(self.frame.size.width - tutorialLabel.frame.size.width / 2 - labelMargin,
                                         playLabel.position.y - tutorialLabel.frame.size.height - labelMargin * 2);
    [self addChild:tutorialLabel];
    
    SKLabelNode *profileLabel = [Util createLabelWithFont:titleFont text:profileLabelName fontColor:[SKColor whiteColor] fontSize:fontSize];
    profileLabel.name = profileLabelName;
    profileLabel.position = CGPointMake(self.frame.size.width - profileLabel.frame.size.width / 2 - labelMargin,
                                        tutorialLabel.position.y - profileLabel.frame.size.height - labelMargin * 2);
    [self addChild:profileLabel];
    
    SKLabelNode *leaderboardLabel = [Util createLabelWithFont:titleFont text:leaderboardLabelName fontColor:[SKColor whiteColor] fontSize:fontSize];
    leaderboardLabel.name = leaderboardLabelName;
    leaderboardLabel.position = CGPointMake(self.frame.size.width - leaderboardLabel.frame.size.width / 2 - labelMargin,
                                            profileLabel.position.y - leaderboardLabel.frame.size.height - labelMargin * 2);
    [self addChild:leaderboardLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    SKTransition *transition = [SKTransition fadeWithDuration:0.4];
    
    if (node.name == playLabelName) {
        GameScene *gameScene = [GameScene sceneWithSize:self.frame.size];
        [self.view presentScene:gameScene transition:transition];
    } else if (node.name == tutorialLabelName) {
        TutorialScene *tutorialScene = [TutorialScene sceneWithSize:self.frame.size];
        [self.view presentScene:tutorialScene transition:transition];
    } else if (node.name == profileLabelName) {
        ProfileScene *profileScene = [ProfileScene sceneWithSize:self.frame.size];
        transition = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.4];
        [self.view presentScene:profileScene transition:transition];
    }
}

@end
