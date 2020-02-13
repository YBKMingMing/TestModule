//
//  WbbNavigationController.m
//  MusicPlaying
//
//  Created by wenbaobao on 2018/7/30.
//  Copyright © 2018年 wenbaobao. All rights reserved.
//

#import "WbbNavigationController.h"


@interface WbbNavigationController ()

@end

@implementation WbbNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


+(void)initialize
{
    [self setUpNavigationBarTheme];
}


+(void)setUpNavigationBarTheme
{
    UINavigationBar * appearance = [UINavigationBar appearance];
    [appearance setBackgroundImage:[UIImage createImageWithColor:NavColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [appearance setShadowImage:[UIImage new]];
    [appearance setTranslucent:NO];
    [appearance setTitleTextAttributes:@{NSFontAttributeName:ZQFont(18),NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"Return" target:self selector:@selector(ReturnToPreviousPage)];
        
    }
    
    
    [super pushViewController:viewController animated:animated];
}


- (void)ReturnToPreviousPage
{
    [self popViewControllerAnimated:YES];
    
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
