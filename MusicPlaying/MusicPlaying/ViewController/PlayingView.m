//
//  PlayingView.m
//  MusicPlaying
//
//  Created by wenbaobao on 2018/8/1.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import "PlayingView.h"
#import "WBBPlayerTool.h"
#import "WBBMusicModel.h"
#import "WBBMusicTool.h"
#import "WBBLyricTool.h"
#import "WBBLyricModel.h"
#import "CALayer+PauseAimate.h"
#import "Masonry.h"
#import "WBBLabel.h"

#define kLrcLineHeight 44

@interface PlayingView() <UIScrollViewDelegate>
{
    WBBLabel * lastLab;
    
    NSInteger currentIndex;
}


@property (strong, nonatomic) IBOutlet UIImageView *backImage;


@property (strong, nonatomic) IBOutlet UILabel *titleNameLab;


@property (strong, nonatomic) IBOutlet UIView *centerPlayView;

@property (strong, nonatomic) IBOutlet UIImageView *headImage;


@property (strong, nonatomic) IBOutlet WBBLabel *lyricLab;


@property (strong, nonatomic) IBOutlet UILabel *musicNameLab;


@property (strong, nonatomic) IBOutlet UILabel *introLab;


@property (strong, nonatomic) IBOutlet UILabel *playTimeLab;

@property (strong, nonatomic) IBOutlet UILabel *totalTimeLab;

@property (strong, nonatomic) IBOutlet UIButton *playBtn;

@property (strong, nonatomic) IBOutlet UIButton *lastBtn;

@property (strong, nonatomic) IBOutlet UIButton *nextBtn;

@property (nonatomic,strong) CADisplayLink * timer;

//一首歌的所有行的歌词
@property (nonatomic, strong) NSArray *allLrcLines;

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;

@property (strong, nonatomic) IBOutlet UIScrollView *centerScroll;


@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIScrollView *lyricScroll;






@end

@implementation PlayingView


+(PlayingView *)instancePlayingView
{
    NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"PlayingView" owner:nil options:nil];
    return [nibArray objectAtIndex:0];
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    [self grammaticalizationBackImageView];
    [self setUpViewValue];
    [self upadteUI];
}



-(id)initWithCoder:(NSCoder *)aDecoder
{
    //此方法在 awakerfromNib 调用之前
    self = [super initWithCoder:aDecoder];
    
    if (self) {
//        [self grammaticalizationBackImageView];
//        [self setUpViewValue];
    }
    
    return self;
}

#pragma mark --背景图毛玻璃效果
- (void)grammaticalizationBackImageView
{
    //毛玻璃效果
    UIToolbar *bar = [[UIToolbar alloc]init];
    bar.barStyle = UIBarStyleBlack;
    bar.translucent = YES;
    //禁止掉 Autoresizing
    bar.translatesAutoresizingMaskIntoConstraints = NO;
    UIView * bg = [[UIView alloc]init];
    bg.backgroundColor = [UIColor redColor];
    //[bar setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.backImage addSubview:bar];
    __weak typeof (self) weaksef = self;
    
    [bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weaksef.backImage.mas_top).offset(0);
        make.height.equalTo(@(ScreenHeight));
        make.width.equalTo(@(ScreenWidth));
        make.left.mas_equalTo(weaksef.backImage.mas_left).offset(0);
        
    }];
    
   
    
  
}

//更新 ui 视图
-(void)upadteUI
{
    _headImage.layer.masksToBounds = true;
    _headImage.layer.cornerRadius =  self.headImage.frame.size.width*0.5;
    
    [self.centerScroll setShowsHorizontalScrollIndicator:false];
    self.centerScroll.delegate = self;
    [_lyricScroll setContentSize:CGSizeMake(0, _allLrcLines.count*kLrcLineHeight)];
    [_lyricScroll setContentInset:UIEdgeInsetsMake(100, 0, self.lyricScroll.bounds.size.height* 0.5, 0)];
    
    [self addIconViewAnimate];
}


-(IBAction)touchUpBtn:(id)sender
{
    //上一曲
    if (sender == _lastBtn) {

        [[WBBPlayerTool sharePlayerTool] beforeMusicPlay];
        
        [self setUpViewValue];
        
    }
    //下一曲
    else if (sender == _nextBtn)
    {
        [[WBBPlayerTool sharePlayerTool] nextMusicPlay];
        
        [self setUpViewValue];
        
      
    }
    
    else if (sender == _playBtn)
    {
        if (_playBtn.selected) {
            WBBMusicModel * playModel = [[WBBMusicTool shareMusicTool] playingModel];
            
            [[WBBPlayerTool sharePlayerTool] playMusicWithMusicName:playModel.mp3];
            
            
            self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateRepeat:)];

            [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

            [self.headImage.layer resumeAnimate];
        }else
        {
            //暂停播放
            [[WBBPlayerTool sharePlayerTool] pauseMusic];
            [self removeMusicTimer];
            [self.headImage.layer pauseAnimate];
        }
        
        _playBtn.selected = !_playBtn.selected;
    }
}

//添加定时器
-(void)addMusicTimer
{
    
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateRepeat:)];
    
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

//移除歌词定时器
-(void)removeMusicTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

//视图赋值
-(void)setUpViewValue
{
    WBBMusicModel * model = [[WBBMusicTool shareMusicTool] playingModel];
    self.titleNameLab.text = model.name;
    self.musicNameLab.text = model.singer;
    self.introLab.text = model.zhuanji;
    self.headImage.image = [UIImage imageNamed:model.image];
    self.backImage.image = [UIImage imageNamed:model.image];
    
    self.totalTimeLab.text = [[WBBPlayerTool sharePlayerTool] durationMusicString];
    
    self.allLrcLines = [WBBLyricTool  LyricArrayWithricName:model.lrc];
    
   [self addScollviewLyricLab];

    [self removeMusicTimer];
   [self addMusicTimer];
    
    if (![[WBBPlayerTool sharePlayerTool] isPlaying]) {
        [self.headImage.layer resumeAnimate];
    }
    
    
    
}

//全屏歌词
-(void)addScollviewLyricLab
{
    for (id objc in [self.lyricScroll subviews]) {
        if ([objc isKindOfClass:[WBBLabel class]]) {
            [objc removeFromSuperview];
        }
    }
    
    lastLab = nil;
    
    for (int i =0; i< _allLrcLines.count; i++) {
        WBBLabel * lyricLab = [[WBBLabel alloc]init];
        WBBLyricModel * lyricModel = _allLrcLines[i];
        lyricLab.text = lyricModel.text;
        lyricLab.textColor = [UIColor whiteColor];
        lyricLab.textAlignment = NSTextAlignmentCenter;
        lyricLab.currentIndex = i;
        [self.lyricScroll addSubview:lyricLab];
        
        [lyricLab mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastLab) {
                make.top.mas_equalTo(lastLab.mas_bottom).offset(0);
            }else
            {
                make.top.offset(0);
            }
            make.left.offset(0);
            make.width.equalTo(@(self.lyricScroll.bounds.size.width));
            make.height.equalTo(@(kLrcLineHeight));
        }];
        lastLab = lyricLab;
        
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.centerScroll) {
        self.centerPlayView.alpha = 1-scrollView.contentOffset.x/self.centerPlayView.bounds.size.width;
    }
}


#pragma mark - 添加zhuanjiImageView的动画
- (void)addIconViewAnimate
{
    CABasicAnimation *rotateAnimate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimate.fromValue = @(0);
    rotateAnimate.toValue = @(M_PI * 2);
    rotateAnimate.repeatCount = NSIntegerMax;
    rotateAnimate.duration = 36;
    [self.headImage.layer addAnimation:rotateAnimate forKey:nil];
}

-(void)updateRepeat:(CADisplayLink *)timer
{
    self.playTimeLab.text = [[WBBPlayerTool sharePlayerTool] currentMusicTotalTimeStr];
    self.progressView.progress = [[WBBPlayerTool sharePlayerTool] musicProgress];
    NSTimeInterval currentTime = [[WBBPlayerTool sharePlayerTool] currentMusicTime];
    
  
    //播放结束
    if ( 1.00f -self.progressView.progress <= 0.001) {
        
        NSLog(@"progress ===%f",self.progressView.progress);
        NSLog(@"aaaa");
        
    }
   
    
//    if ([[WBBPlayerTool sharePlayerTool] durationMusicTotaltime] - currentTime <= 1) {
//        NSLog(@"time == %f",[[WBBPlayerTool sharePlayerTool] durationMusicTotaltime] - currentTime);
//        NSLog(@"cccc");
//    }
    
    int a = 0;
    for (int i = 0; i<_allLrcLines.count; i++) {
        WBBLyricModel * lyricModel =_allLrcLines[i];
        
        WBBLyricModel * nextModel = nil;
        if (i == _allLrcLines.count - 1) {
            nextModel = _allLrcLines[i];
        }else
        {
            nextModel = _allLrcLines[i+1];
        }
        
        //进入播放到的歌词
        if (currentTime >= lyricModel.time && currentTime < nextModel.time) {
            currentIndex = i;
            self.lyricLab.text = lyricModel.text;
            self.lyricLab.progress = (currentTime - lyricModel.time)/(nextModel.time - lyricModel.time);
           
            
            for (id objc in self.lyricScroll.subviews) {
                if ([objc isKindOfClass:[WBBLabel class]]) {
                    WBBLabel * Label = (WBBLabel *)objc;
                    if (Label.currentIndex == i) {
                        a = i;
                        Label.progress = self.lyricLab.progress;
                        Label.font = [UIFont systemFontOfSize:15];
                        
                    }else
                    {
                        Label.progress = 0;
                        Label.font = [UIFont systemFontOfSize:15];
                    }
                }
            }
            
        }
        
       
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (a*kLrcLineHeight > self.lyricScroll.bounds.size.height/2 && a*kLrcLineHeight < self.lyricScroll.contentSize.height - self.lyricScroll.bounds.size.height/2 ) {
            [self.lyricScroll setContentOffset:CGPointMake(0, kLrcLineHeight*currentIndex-self.lyricScroll.bounds.size.height/2) animated:YES];
        }else if (a*kLrcLineHeight > self.lyricScroll.contentSize.height -self.lyricScroll.bounds.size.height/2)
        {
            [self.lyricScroll setContentOffset:CGPointMake(0, self.lyricScroll.contentSize.height - self.lyricScroll.bounds.size.height/2 ) animated:YES];
        }else if (a*kLrcLineHeight < self.lyricScroll.bounds.size.height/2 )
        {
            [self.lyricScroll setContentOffset:CGPointMake(0, 0) animated:YES];
           
        }
    }];
    
   
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
