//
//  MenuListController.m
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/30.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import "MenuListController.h"
#import "listTabCell.h"
#import "WBBMusicTool.h"
#import "WBBMusicModel.h"
#import "AppDelegate.h"
#import "WBBPlayBar.h"
#import "WBBPlayerTool.h"
#import "PlayingView.h"
@interface MenuListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) IBOutlet UITableView * menulistTab;

@property (strong, nonatomic) IBOutlet WBBPlayBar *playBar;

@property (nonatomic,strong) WBBMusicModel * nowModel;

@end

@implementation MenuListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarBackBarButton];
    
    [[WBBMusicTool shareMusicTool] setNowPlayMusic:self.music[0]];
    
    [self.menulistTab registerNib:[UINib nibWithNibName:@"listTabCell" bundle:nil] forCellReuseIdentifier:@"ListTabCell"];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    self.playBar.musicModel = [[WBBMusicTool shareMusicTool] playingModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - 初始化菜单键
-(void)setNavBarBackBarButton
{
    UIBarButtonItem * leftItem = [UIBarButtonItem barButtonItemWithImage:@"menu" target:self selector:@selector(menuBtnClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 菜单按钮
-(void)menuBtnClick
{
//    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    app.revealVC
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


-(listTabCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    listTabCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListTabCell" forIndexPath:indexPath];
    
    WBBMusicModel * model = _music[indexPath.row];
    
    cell.currentModel = model;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBBMusicModel * model = _music[indexPath.row];
    self.playBar.musicModel = model;
    [[WBBMusicTool shareMusicTool] setNowPlayMusic:model];
    [[WBBPlayerTool sharePlayerTool] playMusicWithMusicName:model.mp3];
    [self buildPlayingView];
    
}

#pragma mark - 弹出播放页
-(void)buildPlayingView
{
    PlayingView * playView = [PlayingView instancePlayingView];
    playView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:playView];
}


-(NSArray *)music
{
    if (_music == nil) {
        _music = [[WBBMusicTool shareMusicTool] Music];
    }
    return _music;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
