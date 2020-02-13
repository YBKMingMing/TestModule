//
//  WBBMusicTool.m
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/31.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import "WBBMusicTool.h"
#import "WBBMusicModel.h"
#import "MJExtension.h"

static WBBMusicTool * instance;
static NSArray * musicArray;
static WBBMusicModel * musicModel;

@implementation WBBMusicTool

+(instancetype)shareMusicTool
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WBBMusicTool alloc]init];
    });
    
    return instance;
}


+(void)initialize
{
    if (musicArray == nil) {
        musicArray = [WBBMusicModel mj_objectArrayWithFilename: @"mlist.plist"];
    }
    
    if (musicModel == nil) {
        musicModel = musicArray[4];
    }
}

-(WBBMusicModel *)playingModel
{
    return musicModel;
}


-(void)setNowPlayMusic:(WBBMusicModel *)nowModel
{
     musicModel = nowModel;
}

-(NSArray *)Music
{
    return musicArray;
}


//下一曲
-(WBBMusicModel *)nextMusic
{
    NSUInteger index = [musicArray indexOfObject:musicModel];
    if (index == musicArray.count - 1) {
        index = 0;
    }else
    {
        index = index + 1;
    }
    WBBMusicModel * nextModel = musicArray[index];
    
    return nextModel;
}

//上一曲
-(WBBMusicModel *)beforeMusic
{
   NSUInteger index = [musicArray indexOfObject:musicModel];
    if (index == 0) {
        index = musicArray.count - 1;
    }else
    {
        index = index - 1;
    }
    WBBMusicModel * beforeModel = musicArray[index];
    
    return beforeModel;
}

@end
