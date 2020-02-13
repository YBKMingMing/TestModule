//
//  listTabCell.m
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/30.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import "listTabCell.h"


@interface listTabCell ()

@property (strong, nonatomic) IBOutlet UIImageView *headerImage;

@property (strong, nonatomic) IBOutlet UILabel *musicName;


@property (strong, nonatomic) IBOutlet UILabel *authorLab;


@property (strong, nonatomic) IBOutlet UIButton *moreBtn;


@end

@implementation listTabCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}


-(void)setCurrentModel:(WBBMusicModel *)currentModel
{
    _currentModel = currentModel;
    _headerImage.image = [UIImage imageNamed:currentModel.image];
    
    _musicName.text = currentModel.name;
    _musicName.font = ZQFont(15);
    _musicName.textColor = BlackColor;
    
    _authorLab.text = currentModel.singer;
    _authorLab.font = ZQFont(15);
    _authorLab.textColor = BlackColor;
}

- (IBAction)moreBtnClick:(UIButton *)sender {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
