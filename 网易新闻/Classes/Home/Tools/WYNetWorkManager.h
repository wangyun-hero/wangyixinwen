//
//  WYNetWorkManager.h
//  网易新闻
//
//  Created by 王云 on 16/8/12.
//  Copyright © 2016年 王云. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface WYNetWorkManager : AFHTTPSessionManager

+(instancetype)shardManager;

-(void)getWithurlString:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(void(^)(id response,NSError *error))completion;

-(void)getHomeNewListWithChannelld:(NSString *)channelld completion:(void(^)(id response,NSError *error))completion;
@end
