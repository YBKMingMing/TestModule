//
//  WBBMusicTool.h
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/31.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBBMusicModel;
@interface WBBMusicTool : NSObject

+(instancetype)shareMusicTool;

//获取所有歌曲列表
-(NSArray *)Music;

//设置正在播放的歌曲
-(void)setNowPlayMusic:(WBBMusicModel *)nowModel;

//获取正在播放的歌曲
-(WBBMusicModel *)playingModel;

//下一曲
-(WBBMusicModel *)nextMusic;

//上一曲
-(WBBMusicModel *)beforeMusic;

@end
