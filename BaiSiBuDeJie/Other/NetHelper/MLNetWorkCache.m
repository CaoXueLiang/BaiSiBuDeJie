//
//  MLNetWorkCache.m
//  MeiLin
//
//  Created by 曹学亮 on 2016/11/3.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import "MLNetWorkCache.h"
#import "YYCache.h"

static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;
@implementation MLNetWorkCache

+ (void)initialize{
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
}


+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}


+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}


+ (NSInteger)getAllHttpCacheSize{
    return [_dataCache.diskCache totalCost];
}


+ (void)removeAllHttpCache{
    [_dataCache.diskCache removeAllObjects];
}


+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters{
    if(!parameters){return URL;};
    
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    
    // 将URL与转换好的参数字符串拼接在一起,成为最终存储的KEY值
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];
    
    return cacheKey;
}

@end
