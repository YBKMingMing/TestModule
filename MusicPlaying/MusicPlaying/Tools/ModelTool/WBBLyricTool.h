//
//  WBBLyricTool.h
//  MusicPlaying
//
//  Created by wenbaobao on 2018/8/1.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBLyricTool : NSObject


+(instancetype)shareLyricTool;

//返回指定路径下的歌词数组
+(NSArray *)LyricArrayWithricName:(NSString *)name;

@end
