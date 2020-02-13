//
//  WBBPlayerTool.h
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/31.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBPlayerTool : NSObject


+(instancetype)sharePlayerTool;

//播放音乐
-(void)playMusicWithMusicName:(NSString *)name;

//暂停音乐
-(void)pauseMusic;

//下一曲
-(void)nextMusicPlay;

//上一曲
-(void)beforeMusicPlay;

//总时长
-(NSTimeInterval )durationMusicTotaltime;

/// 总时长字符串
-(NSString *)durationMusicString;

//当前时长
-(NSTimeInterval )currentMusicTime;

//当前时长字符串
-(NSString *)currentMusicTotalTimeStr;

//歌曲进度
-(CGFloat )musicProgress;

//播放状态
-(BOOL)isPlaying;

@end
