//
//  WYChannelModel.h
//  网易新闻
//
//  Created by 王云 on 16/8/13.
//  Copyright © 2016年 王云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYChannelModel : NSObject
//频道名字
@property(nonatomic,copy) NSString *tname;
//频道id
@property(nonatomic,copy) NSString *tid;


+(NSArray *)channels;
@end
