//
//  GameOverNode.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/8/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "GameOverNode.h"
#import <Parse/Parse.h>
#import "Reachability.h"
#import "ParseHelper.h"

@implementation GameOverNode

+ (instancetype)gameOverAtPosition:(CGPoint)position score:(NSInteger)score scene:(GameScene *)scene {
    GameOverNode *gameOver = [self node];
    gameOver.zPosition = 10;
    
    NSInteger highScore = [gameOver getHighScore];
    
    if (highScore < score) {
        highScore = score;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[NSNumber numberWithInteger:highScore] forKey:@"highscore"];
        
        if ([Util checkInternetConnection]) {
            [ParseHelper saveHighScore:highScore];
        }
    }
    
    NSString *normalFont = @"Futura-CondensedExtraBold";
    float labelMargin = scene.frame.size.height * MarginPercent;
    
    SKLabelNode *titleLabel = [Util createLabelWithFont:normalFont text:GameTitle fontColor:[SKColor blackColor] fontSize:30];
    titleLabel.position = CGPointMake(scene.center.x, scene.frame.size.height - titleLabel.frame.size.height - labelMargin);
    [gameOver addChild:titleLabel];
    
    SKLabelNode *gameOverLabel = [Util createLabelWithFont:normalFont text:@"Game Over" fontColor:[SKColor blackColor] fontSize:20];
    gameOverLabel.position = CGPointMake(scene.center.x, titleLabel.position.y - gameOverLabel.frame.size.height - labelMargin);
    [gameOver addChild:gameOverLabel];
    
    NSString *scoreString = [NSString stringWithFormat:@"%li", (long)score];
    SKLabelNode *scoreLabel = [Util createLabelWithFont:normalFont text:scoreString fontColor:[SKColor orangeColor] fontSize:48];
    scoreLabel.position = CGPointMake(scene.center.x, gameOverLabel.position.y - scoreLabel.frame.size.height * 1.5 - labelMargin);
    [gameOver addChild:scoreLabel];
    
    SKLabelNode *replayLabel = [Util createLabelWithFont:normalFont text:ReplayLabelName fontColor:[SKColor blackColor] fontSize:25];
    replayLabel.position = CGPointMake(scene.center.x, scoreLabel.position.y - replayLabel.frame.size.height - labelMargin * 2);
    replayLabel.name = ReplayLabelName;
    [gameOver addChild:replayLabel];
    
    SKLabelNode *menuLabel = [Util createLabelWithFont:normalFont text:MenuLabelName fontColor:[SKColor blackColor] fontSize:25];
    menuLabel.position = CGPointMake(scene.center.x, replayLabel.position.y - menuLabel.frame.size.height - labelMargin * 2);
    menuLabel.name = MenuLabelName;
    [gameOver addChild:menuLabel];
    
    SKLabelNode *leaderboardLabel = [Util createLabelWithFont:normalFont text:LeaderboardLabelName fontColor:[SKColor blackColor] fontSize:25];
    leaderboardLabel.position = CGPointMake(scene.center.x, menuLabel.position.y - leaderboardLabel.frame.size.height - labelMargin * 2);
    leaderboardLabel.name = LeaderboardLabelName;
    [gameOver addChild:leaderboardLabel];
    
    NSString *highScoreString = [NSString stringWithFormat:@"HIGH SCORE: %li", highScore];
    SKLabelNode *highScoreLabel = [Util createLabelWithFont:normalFont text:highScoreString fontColor:[SKColor blackColor] fontSize:25];
    highScoreLabel.position = CGPointMake(scene.center.x, leaderboardLabel.position.y - highScoreLabel.frame.size.height - labelMargin * 2);
    [gameOver addChild:highScoreLabel];
    
    return gameOver;
}

- (NSInteger) getHighScore {
    NSNumber *scoreFromData;
    if ([Util checkInternetConnection]) {
        scoreFromData = [[NSUserDefaults standardUserDefaults] objectForKey:@"highscore"];
    } else {
        scoreFromData = [ParseHelper getHighScore];
    }
    
    if (scoreFromData != nil) {
        return [scoreFromData integerValue];
    }
    
    return 0;
}

@end
