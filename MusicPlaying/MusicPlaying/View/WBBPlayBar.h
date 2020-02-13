//
//  WBBPlayBar.h
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/31.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBBMusicModel;

@interface WBBPlayBar : UIView

@property (nonatomic,retain) IBOutlet UIView *view;

@property (nonatomic,strong) WBBMusicModel *musicModel;



@end
