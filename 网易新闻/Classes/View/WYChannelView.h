//
//  WYChannelView.h
//  网易新闻
//
//  Created by 王云 on 16/8/13.
//  Copyright © 2016年 王云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYChannelView : UIView
//用于接收数据
@property(nonatomic,strong) NSArray *channels;

+(instancetype)channelView;

-(void)setScale:(CGFloat)scale withIndex:(NSInteger)index;
@end
