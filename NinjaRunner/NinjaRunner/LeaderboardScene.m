//
//  LeaderboardScene.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/10/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "LeaderboardScene.h"
#import "Util.h"
#import "ParseHelper.h"
#import "HomeScene.h"

@implementation LeaderboardScene {
    SKLabelNode *backLabel;
}

- (void) didMoveToView:(SKView *)view {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"home_screen_background"];
    background.size = self.view.bounds.size;
    background.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    background.zPosition = -1;
    [self addChild:background];
    
    NSString *normalFont = @"Futura-CondensedExtraBold";
    NSInteger fontSize = self.frame.size.height * 0.055;
    float margin = self.frame.size.height * MarginPercent * 2;
    
    backLabel = [Util createLabelWithFont:@"Chalkduster" text:@"Back" fontColor:[SKColor blueColor] fontSize:25];
    float backLabelMargin = self.frame.size.width * 0.03;
    backLabel.position = CGPointMake(self.frame.size.width - backLabel.frame.size.width / 2 - margin, backLabelMargin);
    [self addChild:backLabel];
    
    SKLabelNode *headerLabel = [Util createLabelWithFont:normalFont text:@"Leaderboard" fontColor:[SKColor whiteColor] fontSize:fontSize * 1.2];
    headerLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - headerLabel.frame.size.height - margin);
    [self addChild:headerLabel];
    
    __block float previousY = headerLabel.position.y;
    
    [ParseHelper getTopTenPlayerScoresWithBlock:^(NSArray *playerScoreArray) {
        for (int i = 0; i < playerScoreArray.count; i++) {
            PlayerScore *playerScore = (PlayerScore *)playerScoreArray[i];
            
            NSString *text = [NSString stringWithFormat:@"%i. %@ - %li", i + 1, playerScore.name, playerScore.score];
            SKLabelNode *playerLabel = [Util createLabelWithFont:normalFont text:text fontColor:[SKColor whiteColor] fontSize:fontSize];
            playerLabel.zPosition = 1;
            playerLabel.position = CGPointMake(playerLabel.frame.size.width / 2 + margin, previousY - playerLabel.frame.size.height - margin);
            [self addChild:playerLabel];
            
            previousY = playerLabel.position.y;
        }
    }];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:point];
    
    if ([node isEqual:backLabel]) {
        HomeScene *homeScene = [HomeScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1];
        [self.view presentScene:homeScene transition:transition];
    }
}

@end
