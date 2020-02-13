//
//  WBBPlayBar.m
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/31.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import "WBBPlayBar.h"
#import "Masonry.h"
#import "WBBMusicModel.h"
#import "CALayer+PauseAimate.h"
#import "WBBMusicTool.h"
@interface WBBPlayBar()

@property (strong, nonatomic) IBOutlet UIImageView *iconImage;


@property (strong, nonatomic) IBOutlet UILabel *musicNameLab;

@property (strong, nonatomic) IBOutlet UILabel *musicAuthorLab;

@property (strong, nonatomic) IBOutlet UIButton *playBtn;

@property (strong, nonatomic) IBOutlet UIButton *menuBtn;


@end

@implementation WBBPlayBar



-(void)awakeFromNib
{
     [super awakeFromNib];
}




-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"WBBPlayBar"owner:self options:nil];
        [self addSubview:self.view];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.offset(0);
        }];
        _musicNameLab.textColor = BlackColor;
        _musicNameLab.font = ZQFont(13);
        
        _musicAuthorLab.textColor = BlackColor;
        _musicAuthorLab.font = ZQFont(13);
       
    }
    
    return self;
}

-(void)setMusicModel:(WBBMusicModel *)musicModel
{
    _musicModel = musicModel;

    _iconImage.image = [UIImage imageNamed:musicModel.image];
    
    _musicNameLab.text = musicModel.name;
    
    _musicAuthorLab.text = musicModel.singer;
    
    [self addIconViewAnimate];
    
    [self stopAnimate];
}


-(IBAction)btnClick:(id)sender
{
    if (sender == _playBtn) {
        if (_playBtn.selected) {
            
        }else
        {
          WBBMusicModel * playModel =  [[WBBMusicTool shareMusicTool] playingModel];
        }
        
    }else if (sender == _menuBtn)
    {
        
    }
}

-(void)stopAnimate
{
     [self.iconImage.layer pauseAnimate];
}


-(void)addIconViewAnimate
{
    CABasicAnimation *rotateAnimate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimate.fromValue = @(0);
    rotateAnimate.toValue = @(M_PI * 2);
    rotateAnimate.repeatCount = NSIntegerMax;
    rotateAnimate.duration = 36;
    [self.iconImage.layer addAnimation:rotateAnimate forKey:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
