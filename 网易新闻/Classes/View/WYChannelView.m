//
//  WYChannelView.m
//  网易新闻
//
//  Created by 王云 on 16/8/13.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYChannelView.h"
#import "WYChannelModel.h"
#import "WYChannelLable.h"
@interface WYChannelView()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end
@implementation WYChannelView
//类方法加载xib的方法
+(instancetype)channelView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WYChannelView" owner:nil options:nil] lastObject];
    
}

#pragma mark -关于lable
-(void)setChannels:(NSArray *)channels
{
    _channels = channels;
    
    CGFloat margin = 10;
    CGFloat x = margin;
    
    for (int i = 0; i < channels.count; i++)
    {
        //取到频道的模型
        WYChannelModel *model = [channels objectAtIndex:i];
        WYChannelLable *lable = [WYChannelLable lableWithModel:model];
        
        //t通过UIlable的分类设置Lable的大小,颜色,字体
        //UILabel *lable = [UILabel labelWithText:model.tname andTextColor:[UIColor redColor] andFontSize:14];
        //设置lable的frame
        lable.frame = CGRectMake(x , 0, lable.frame.size.width, 35);
        //将lable添加到scrollview上
        [self.scrollview addSubview:lable];
        //将x递增
        x += lable.frame.size.width + margin;
        
        //自动适应大小
        [lable sizeToFit];
    }

    //设置scrollview的滚动距离,此时循环结束,x就是最终的宽
    self.scrollview.contentSize = CGSizeMake(x, 0);
    
}


@end
