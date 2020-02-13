//
//  WBBLabel.m
//  MusicPlaying
//
//  Created by wenbaobao on 2018/8/2.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import "WBBLabel.h"

@implementation WBBLabel


-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [ super drawRect:rect];
    [[UIColor greenColor] setFill];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, _progress * rect.size.width, rect.size.height), kCGBlendModeSourceIn);
}


@end
