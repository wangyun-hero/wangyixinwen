//
//  WYChannelView.m
//  网易新闻
//
//  Created by 王云 on 16/8/13.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYChannelView.h"

@implementation WYChannelView
//类方法加载xib的方法
+(instancetype)channelView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WYChannelView" owner:nil options:nil] lastObject];
    
}



@end
