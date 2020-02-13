//
//  WBBMusicModel.h
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/31.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBMusicModel : NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *lrc;
@property (nonatomic, copy) NSString *mp3;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, copy) NSString *zhuanji;
@property (nonatomic, assign) NSNumber *type;

@end
