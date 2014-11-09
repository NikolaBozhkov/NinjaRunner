//
//  ProfileScene.m
//  NinjaRunner
//
//  Created by Nikola Bozhkov on 11/9/14.
//  Copyright (c) 2014 TeamOnaga. All rights reserved.
//

#import "ProfileScene.h"
#import "Util.h"
#import "PlayerScore.h"
#import "ParseHelper.h"
#import "HomeScene.h"

@interface ProfileScene ()<UITextFieldDelegate>

@end

@implementation ProfileScene {
    UITextField *nameTextField;
    SKLabelNode *nameLabel;
    SKLabelNode *backLabel;
}

- (void) didMoveToView:(SKView *)view {
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"home_screen_background"];
    background.zPosition = -1;
    background.size = self.view.bounds.size;
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    
    NSString *normalFont = @"Futura-CondensedExtraBold";
    NSInteger fontSize = self.frame.size.height * 0.07;
    float margin = self.frame.size.height * MarginPercent * 2;
    
    SKLabelNode *headerLabel = [Util createLabelWithFont:normalFont text:@"Profile Overview" fontColor:[SKColor whiteColor] fontSize:fontSize * 1.2];
    headerLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - headerLabel.frame.size.height - margin);
    [self addChild:headerLabel];

    SKLabelNode *namePreLabel = [Util createLabelWithFont:normalFont text:@"Name: " fontColor:[SKColor whiteColor] fontSize:fontSize];
    namePreLabel.position = CGPointMake(namePreLabel.frame.size.width / 2 + margin, headerLabel.position.y - namePreLabel.frame.size.height - margin * 3);
    [self addChild:namePreLabel];
    
    nameLabel = [Util createLabelWithFont:normalFont text:Profile.name fontColor:[SKColor whiteColor] fontSize:fontSize];
    nameLabel.position = CGPointMake(namePreLabel.position.x * 2, namePreLabel.position.y);
    nameLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:nameLabel];
    
    NSString *highScoreText = [NSString stringWithFormat:@"High Score: %li", (long)Profile.highScore];
    SKLabelNode *highScoreLabel = [Util createLabelWithFont:normalFont text:highScoreText fontColor:[SKColor whiteColor] fontSize:fontSize];
    highScoreLabel.position = CGPointMake(highScoreLabel.frame.size.width / 2 + margin, namePreLabel.position.y - highScoreLabel.frame.size.height - margin);
    [self addChild:highScoreLabel];
    
    NSString *mostKillsText = [NSString stringWithFormat:@"Most Kills: %li", (long)Profile.mostKills];
    SKLabelNode *mostKillsLabel = [Util createLabelWithFont:normalFont text:mostKillsText fontColor:[SKColor whiteColor] fontSize:fontSize];
    mostKillsLabel.position = CGPointMake(mostKillsLabel.frame.size.width / 2 + margin, highScoreLabel.position.y - mostKillsLabel.frame.size.height - margin);
    [self addChild:mostKillsLabel];
    
    NSString *totalScoreText = [NSString stringWithFormat:@"Total Score: %li", (long)Profile.totalScore];
    SKLabelNode *totalScoreLabel = [Util createLabelWithFont:normalFont text:totalScoreText fontColor:[SKColor whiteColor] fontSize:fontSize];
    totalScoreLabel.position = CGPointMake(totalScoreLabel.frame.size.width / 2 + margin, mostKillsLabel.position.y - totalScoreLabel.frame.size.height - margin);
    [self addChild:totalScoreLabel];
    
    NSString *totalKillsText = [NSString stringWithFormat:@"Total Kills: %li", (long)Profile.totalKills];
    SKLabelNode *totalKillsLabel = [Util createLabelWithFont:normalFont text:totalKillsText fontColor:[SKColor whiteColor] fontSize:fontSize];
    totalKillsLabel.position = CGPointMake(totalKillsLabel.frame.size.width / 2 + margin, totalScoreLabel.position.y - totalKillsLabel.frame.size.height - margin);
    [self addChild:totalKillsLabel];
    
    NSString *longestGameText = [NSString stringWithFormat:@"Longest Game: %@", [self formatTimeInterval:Profile.longestGameTime]];
    SKLabelNode *longestGameLabel = [Util createLabelWithFont:normalFont text:longestGameText fontColor:[SKColor whiteColor] fontSize:fontSize];
    longestGameLabel.position = CGPointMake(longestGameLabel.frame.size.width / 2 + margin, totalKillsLabel.position.y - longestGameLabel.frame.size.height - margin);
    [self addChild:longestGameLabel];
    
    NSString *timePlayedText = [NSString stringWithFormat:@"Time Played: %@", [self formatTimeInterval:Profile.totalGameTime]];
    SKLabelNode *timePlayedLabel = [Util createLabelWithFont:normalFont text:timePlayedText fontColor:[SKColor whiteColor] fontSize:fontSize];
    timePlayedLabel.position = CGPointMake(timePlayedLabel.frame.size.width / 2 + margin, longestGameLabel.position.y - timePlayedLabel.frame.size.height - margin);
    [self addChild:timePlayedLabel];
    
    backLabel = [Util createLabelWithFont:@"Chalkduster" text:@"Back" fontColor:[SKColor blueColor] fontSize:25];
    float backLabelMargin = self.frame.size.width * 0.03;
    backLabel.position = CGPointMake(backLabel.frame.size.width / 2 + backLabelMargin, backLabelMargin);
    [self addChild:backLabel];
}

- (NSString *) formatTimeInterval:(NSTimeInterval)interval {
    long hours = lround(floor(interval / 3600.)) % 100;
    long minutes = lround(floor(interval / 60.)) % 60;
    long seconds = lround(floor(interval)) % 60;
    
    return [NSString stringWithFormat:@"%02li:%02li:%02li", hours, minutes, seconds];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:point];
    if ([node isEqual:nameLabel]) {
        if (nameTextField == nil) {
            nameTextField = [[UITextField alloc]initWithFrame:nameLabel.frame];
            nameTextField.delegate = self;
            nameTextField.hidden = true;
            [self.view addSubview:nameTextField];
        }
        
        nameTextField.text = nameLabel.text;
        [nameTextField becomeFirstResponder];
    } else if ([node isEqual:backLabel]) {
        [ParseHelper savePlayerScoreName:Profile.name];
        
        HomeScene *homeScene = [HomeScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition pushWithDirection:SKTransitionDirectionRight duration:0.4];
        [self.view presentScene:homeScene transition:transition];
    } else {
        // Hide keyboard when tapped outside the label.
        [nameTextField resignFirstResponder];
        [Util saveProfileDetails:Profile];
    }
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newName = [textField.text stringByReplacingCharactersInRange:range withString:string];
    nameLabel.text = newName;
    Profile.name = newName;
    return YES;
}

@end
