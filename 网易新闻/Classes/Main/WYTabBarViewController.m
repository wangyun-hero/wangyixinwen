//
//  WYTabBarViewController.m
//  网易新闻
//
//  Created by 王云 on 16/8/11.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYTabBarViewController.h"

@interface WYTabBarViewController ()

@end

@implementation WYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController];
    // Do any additional setup after loading the view.
}

-(void)addChildViewController
{
    NSArray *array = @[
  @{@"clsName": @"WYHomeViewController", @"title": @"新闻", @"imageName": @"news"},
                       @{@"clsName": @"UIViewController", @"title": @"阅读", @"imageName": @"reader"},
                       @{@"clsName": @"UIViewController", @"title": @"视频", @"imageName": @"media"},
                       @{@"clsName": @"UIViewController", @"title": @"话题", @"imageName": @"bar"},
                       @{@"clsName": @"UIViewController", @"title": @"我", @"imageName": @"me"},];
    
    for (NSDictionary *dict in array)
    {
        //遍历字典,添加子控制器
        UIViewController *vc = [self viewControllerWithDict:dict];
        //通过字典创建对应的控制器
        [self addChildViewController:vc];
    }
    
}

/**
 *  通过字典初始化控制器
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
//通过字典初始化控制器
-(UIViewController *)viewControllerWithDict:(NSDictionary *)dict
{
    //初始化控制器
    UIViewController *vc = [NSClassFromString(dict[@"clsName"]) new];
   //设置标题
    vc.title = dict[@"title"];
    //设置不同状态下的图片
    vc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_icon_%@_normal", dict[@"imageName"]]];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_icon_%@_highlight", dict[@"imageName"]]];
    
    //vc.tabBarController.tabBar.tintColor = [UIColor redColor];
    //使用导航控制器包裹这个控制器并且返回
    return [[UINavigationController alloc] initWithRootViewController:vc];
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
