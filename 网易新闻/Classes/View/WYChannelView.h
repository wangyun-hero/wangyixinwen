//
//  WYChannelView.h
//  网易新闻
//
//  Created by 王云 on 16/8/13.
//  Copyright © 2016年 王云. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYChannelView;
// 1 定义协议
@protocol WYChannelViewDelegata <NSObject>

// 2 代理方法
-(void)channelView:(WYChannelView *)channelView clickWithIndex:(NSInteger)index;

@end


@interface WYChannelView : UIView
//用于接收数据
@property(nonatomic,strong) NSArray *channels;
// 3 设置代理属性
@property(nonatomic,weak) id<WYChannelViewDelegata>delagata;

+(instancetype)channelView;

-(void)setScale:(CGFloat)scale withIndex:(NSInteger)index;
@end
