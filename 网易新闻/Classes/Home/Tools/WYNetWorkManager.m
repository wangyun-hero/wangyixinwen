//
//  WYNetWorkManager.m
//  网易新闻
//
//  Created by 王云 on 16/8/12.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYNetWorkManager.h"

@implementation WYNetWorkManager
//全局访问点
+(instancetype)shardManager
{
    static WYNetWorkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

//发起GET请求
-(void)getWithurlString:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(void(^)(id response,NSError *error))completion
{
     //调用父类方法请求网络数据
    [self GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功的回调
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败的回调
        completion(nil,error);
    }];
}

#pragma mark -获取新闻首页数据
-(void)getHomeNewListWithChannelld:(NSString *)channelld completion:(void(^)(id response,NSError *error))completion
{
    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@/0-40.html", channelld];
    [self getWithurlString:urlString parameters:nil completion:^(id response, NSError *error) {
        //将数据回调出去
        completion(response,error);
    }];
}


@end
