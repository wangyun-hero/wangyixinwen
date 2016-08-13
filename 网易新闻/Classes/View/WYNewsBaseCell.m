//
//  WYNewsBaseCell.m
//  网易新闻
//
//  Created by 王云 on 16/8/12.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYNewsBaseCell.h"
#import <UIImageView+WebCache.h>
@interface WYNewsBaseCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgExtra;
@end

@implementation WYNewsBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(WYNewsModel *)model
{
    _model = model;
    
    //设置图片
    [self.imgsrcView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    //设置来源
    [self.sourceLabel setText:model.source];
    //设置跟贴数
    [self.replyCountLabel setText:model.replyCount];
    //设置标题
    [self.titleLabel setText:model.title];
    //cell里面的imgExtra是图片idx是key,obj是value
    [model.imgextra enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imageView = self.imgExtra[idx];
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj[@"imgsrc"]]];
    }];

    
}

@end
