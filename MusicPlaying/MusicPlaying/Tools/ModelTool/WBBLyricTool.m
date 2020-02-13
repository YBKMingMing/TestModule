//
//  WBBLyricTool.m
//  MusicPlaying
//
//  Created by wenbaobao on 2018/8/1.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import "WBBLyricTool.h"
#import "WBBLyricModel.h"
static WBBLyricTool * lyricTool;

@implementation WBBLyricTool

+(instancetype)shareLyricTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lyricTool = [[WBBLyricTool alloc]init];
    });
    return lyricTool;
}

//返回指定路径下的歌词数组
+(NSArray *)LyricArrayWithricName:(NSString *)name
{
    NSMutableArray * modelArray = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    
    //将歌词转化为字符串
    NSString *lyricStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSArray * lyricArray = [lyricStr componentsSeparatedByString:@"\n"];
    
    for (NSString * lineLyric in lyricArray) {

        //正则表达式
        NSRegularExpression * regular = [NSRegularExpression regularExpressionWithPattern:@"\\[[0-9][0-9]:[0-9][0-9]\\.[0-9][0-9]\\]" options:0 error:nil];
        
        //返回迭代器搜索到的所有结果
        NSArray * arr = [regular matchesInString:lineLyric options:NSMatchingReportCompletion range:NSMakeRange(0, lineLyric.length)];
        
        // 正文
        NSTextCheckingResult *lastResult = [arr lastObject];
        
        NSString * lyricText = [lineLyric substringFromIndex:lastResult.range.location + lastResult.range.length];
        
        for (NSTextCheckingResult * result in arr) {
            //时间文本
            NSString * strTime = [lineLyric substringWithRange:result.range];
            
            //歌词模型
            WBBLyricModel * lyricModel = [[WBBLyricModel alloc]init];
            
            lyricModel.text = lyricText;
            NSLog(@"strtime === %@",strTime);
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"[mm:ss.SS]";
            
            NSDate * date = [formatter dateFromString:strTime];
            NSDate * zeroDate = [formatter dateFromString:@"[00:00.00]"];
            
            lyricModel.time = [date timeIntervalSinceDate:zeroDate];
            
            [modelArray addObject:lyricModel];
            
        }
        
    }
    
    NSSortDescriptor * sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    return [modelArray sortedArrayUsingDescriptors:@[sortDescriptor]];
}

@end
