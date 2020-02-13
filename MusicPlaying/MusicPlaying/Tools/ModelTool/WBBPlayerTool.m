//
//  WBBPlayerTool.m
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/31.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import "WBBPlayerTool.h"
#import <AVFoundation/AVFoundation.h>
#import "WBBMusicTool.h"
#import "WBBMusicModel.h"
static WBBPlayerTool * playerTool;

@interface WBBPlayerTool()

@property (nonatomic,retain) AVAudioPlayer * audioPlayer;

@property (nonatomic,copy) NSString * currentName;

@end

@implementation WBBPlayerTool

+(instancetype)sharePlayerTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerTool = [[WBBPlayerTool alloc]init];
        //AVAudioSessionCategorySoloAmbient是系统默认的category
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        //激活AVAudioSession
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
    });
    return playerTool;
}

//播放音乐
-(void)playMusicWithMusicName:(NSString *)name
{
    if (name == nil) {
        return;
    }
    
    NSString * path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    if (path == nil) {
        return;
    }
    NSURL * url = [NSURL fileURLWithPath:path];
    
    if ( ![_currentName isEqualToString:name]) {
         self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    }
   
    
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    _currentName = name;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"musicDidPlay" object:nil userInfo:nil];
}

//暂停音乐
-(void)pauseMusic
{
    if (self.audioPlayer.playing) {
        [self.audioPlayer pause];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"musicDidPause" object:nil userInfo:nil];
    }
}

//下一曲
-(void)nextMusicPlay
{
    WBBMusicModel * nextModel = [[WBBMusicTool shareMusicTool] nextMusic];
    [[WBBMusicTool shareMusicTool] setNowPlayMusic:nextModel];
    [self playMusicWithMusicName:nextModel.mp3];
}

//上一曲
-(void)beforeMusicPlay
{
    WBBMusicModel * beforeModel = [[WBBMusicTool shareMusicTool] beforeMusic];
    [[WBBMusicTool shareMusicTool] setNowPlayMusic:beforeModel];
    [self playMusicWithMusicName:beforeModel.mp3];
}

//总时长
-(NSTimeInterval )durationMusicTotaltime
{
    return self.audioPlayer.duration;
}

/// 总时长字符串
-(NSString *)durationMusicString {
    
    return [NSString stringWithFormat:@"%02d:%02d",(int)self.audioPlayer.duration / 60, (int)self.audioPlayer.duration % 60];
    
}

//当前时长
-(NSTimeInterval )currentMusicTime
{
    return self.audioPlayer.currentTime;
}

//当前时长字符串
-(NSString *)currentMusicTotalTimeStr
{
    return [NSString stringWithFormat:@"%02d:%02d",(int)self.audioPlayer.currentTime/60,(int)self.audioPlayer.currentTime % 60];
}

//歌曲进度
-(CGFloat )musicProgress
{
    return  self.audioPlayer.currentTime / self.audioPlayer.duration;
}

//是否播放状态
-(BOOL)isPlaying
{
    return self.audioPlayer.playing;
}

@end
