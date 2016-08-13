//
//  WYHomeViewController.m
//  网易新闻
//
//  Created by 王云 on 16/8/13.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYHomeViewController.h"
#import "WYChannelView.h"

@interface WYHomeViewController ()

@end

@implementation WYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    // Do any additional setup after loading the view.
}

-(void)setupUI
{
    WYChannelView *channelView = [WYChannelView channelView];
     [self.view addSubview:channelView];
    [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(35);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
   
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
