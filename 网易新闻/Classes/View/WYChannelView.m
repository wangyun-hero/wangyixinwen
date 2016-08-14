//
//  WYChannelView.m
//  网易新闻
//
//  Created by 王云 on 16/8/13.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYChannelLable.h"
#import "WYChannelModel.h"
#import "WYChannelView.h"
#import "Masonry.h"
@interface WYChannelView ()
@property(weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end
@implementation WYChannelView
//类方法加载xib的方法
+ (instancetype)channelView {
  return [[[NSBundle mainBundle] loadNibNamed:@"WYChannelView"
                                        owner:nil
                                      options:nil] lastObject];
}

#pragma mark -关于lable的布局
- (void)setChannels:(NSArray *)channels {
  _channels = channels;

  CGFloat margin = 10;
  CGFloat x = margin;

  for (int i = 0; i < channels.count; i++) {
    //取到频道的模型
    WYChannelModel *model = [channels objectAtIndex:i];
    WYChannelLable *lable = [WYChannelLable lableWithModel:model];

    // t通过UIlable的分类设置Lable的大小,颜色,字体
    // UILabel *lable = [UILabel labelWithText:model.tname andTextColor:[UIColor
    // redColor] andFontSize:14];
    //设置lable的frame
    lable.frame = CGRectMake(x, 0, lable.frame.size.width, 35);
    //将lable添加到scrollview上
    [self.scrollview addSubview:lable];
    //将x递增
    x += lable.frame.size.width + margin;
      //添加一个手势
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
      //给Lable添加手势
      [lable addGestureRecognizer:tap];
      //开启用户交互
      lable.userInteractionEnabled = YES;
      
    //自动适应大小
   // [lable sizeToFit];
//      [lable mas_makeConstraints:^(MASConstraintMaker *make) {
//          make.centerY.equalTo(self.scrollview);
//      }];
  }

  //设置scrollview的滚动距离,此时循环结束,x就是最终的宽
  self.scrollview.contentSize = CGSizeMake(x, 0);
    
    [self setScale:1 withIndex:0];
}

#pragma mark -手势的监听事件
-(void)tapGesture:(UITapGestureRecognizer *)tap
{
    // 4 判断代理属性是否响应,如果响应,就执行代理方法
    // tap.view就能取到点击的Lable
    if ([self.delagata respondsToSelector:@selector(channelView:clickWithIndex:)]) {
        // 5 属性执行代理方法
        [self.delagata channelView:self clickWithIndex:[self.scrollview.subviews indexOfObject:tap.view]];
    }
    for (WYChannelLable *lable in self.scrollview.subviews)
    {
        if (tap.view == lable) {
            lable.scale = 1;
        }
        else
        {
            lable.scale = 0;
        }
    }
    
    
    
    
    
    
    
    
}

#pragma mark -lable的缩放
-(void)setScale:(CGFloat)scale withIndex:(NSInteger)index
{
    //取到对应位置的lable
    WYChannelLable *lable = [self.scrollview.subviews objectAtIndex:index];
    //设置对应位置lable的缩放
    //[lable setTextColor:[UIColor colorWithRed:scale green:0 blue:0 alpha:1]];
    lable.scale = scale;
    
}

@end
