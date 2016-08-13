//
//  WYNewsListViewController.h
//  网易新闻
//
//  Created by 王云 on 16/8/12.
//  Copyright © 2016年 王云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYChannelModel;
@interface WYNewsListViewController : UIViewController
-(instancetype)initWithModel:(WYChannelModel *)model;
@end
