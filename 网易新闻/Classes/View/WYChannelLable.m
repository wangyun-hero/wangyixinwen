//
//  WYChannelLable.m
//  网易新闻
//
//  Created by 王云 on 16/8/13.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYChannelLable.h"
#import "WYChannelModel.h"

@implementation WYChannelLable
//抽取的类
+(instancetype)lableWithModel:(WYChannelModel *)model
{
    WYChannelLable *lable = [self labelWithText:model.tname andTextColor:[UIColor blackColor] andFontSize:18];
    //根据内容调整大小
    [lable sizeToFit];
    
    // 计算字号为18的大小这这后,再把字体改成14,原因是防止在放大的时候空间不足
    lable.font = [UIFont systemFontOfSize:14];
    
    return  lable;
    
}

-(void)setScale:(CGFloat)scale
{
    _scale = scale;
    //计算缩放比例
    [self setTextColor:[UIColor colorWithRed:scale green:0 blue:0 alpha:1]];
    // 3. 变大变小
    // 14 --> 0
    // 18 --> 1
    // 假如说: 传入的scale是0.5
    // sc --> 16
    // 16 / 14 == 1.xxx
    CGFloat sc = 14 + (18 - 14) * scale;
    self.transform = CGAffineTransformMakeScale(sc / 14, sc / 14);

    
    
    
}
@end
