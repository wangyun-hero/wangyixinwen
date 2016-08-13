//
//  WYChannelModel.m
//  网易新闻
//
//  Created by 王云 on 16/8/13.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYChannelModel.h"

@implementation WYChannelModel

+(NSArray *)channels
{
   //获取json的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    //将其转化为字典
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //字典转模型
    NSArray *result = [NSArray yy_modelArrayWithClass:[self class] json:dict[@"tList"]];
    NSLog(@"%@",result);
    //做一个排序,因为channel是根据id来的,而字典本身就是无序的
    result = [result sortedArrayUsingComparator:^NSComparisonResult( WYChannelModel* obj1, WYChannelModel* obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    //经过排序的模型数组
    return  result;
    
}

-(NSString *)description
{
    return [self yy_modelDescription];
}

@end
