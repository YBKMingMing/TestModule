//
//  LeftViewController.m
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/30.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

static NSArray * dataArray;
#import "LeftViewController.h"

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) IBOutlet UITableView * mainTab;



@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


+(void)initialize
{
    if ([NSStringFromClass([self class]) isEqualToString:@"LeftViewController"]) {
        dataArray = [NSArray array];
        dataArray = @[@"仅Wi-Fi联网",@"定时关闭",@"免流量服务",@"微音云音乐网盘",@"传歌到手机",@"QPlay与车载音乐",@"清理占用空间",@"帮助与反馈",@"关于QQ音乐"];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
    }
    
    NSString * title = [dataArray objectAtIndex:indexPath.row];
    if ([title isEqualToString:@"仅Wi-Fi联网"] || [title isEqualToString:@"定时关闭"] ) {
        cell.accessoryView = [[UISwitch alloc] init];
    }
    
    cell.textLabel.text = title;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
