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
@end
