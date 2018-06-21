//
//  MooWeb.m
//  Created by Jakit on 16/5/4.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooWeb.h"

#define defaultTimeout 10

@implementation MooWeb

- (id)init {
    if (self = [super init]) {
        queue = [NSOperationQueue mainQueue];
        cache = [NSURLCache sharedURLCache];
    }
    return self;
}

- (NSData *)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSData *)param {
    // 初始化路径
    NSURL *url = [[NSURL alloc] initWithString:strUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    // 包装HTTP头
    NSDictionary *header = [request allHTTPHeaderFields];
    [header setValue:@"iOS-Client" forKey:@"User-Agent"];
//    [request setAllHTTPHeaderFields:header];
    [request setHTTPMethod:method];
    
    // 包装数据
    [request setHTTPBody:param];
    
    NSData *result;
    NSURLResponse *response;
    NSError *err;
    
    result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
#ifdef DEBUG
    if (err) {
        NSLog(@"Error: %@", err.localizedDescription);
    }
#endif
    
    return result;
}

- (void)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSData *)param completion:(void (^)(NSURLResponse * response, NSData * data, NSError * connectionError))completion {
    // 初始化路径
    NSURL *url = [[NSURL alloc] initWithString:strUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:defaultTimeout];
    
    // 包装HTTP头
    NSDictionary *header = [request allHTTPHeaderFields];
    [header setValue:@"iOS-Client" forKey:@"User-Agent"];
    [request setHTTPMethod:method];
    
    // 包装数据
    [request setHTTPBody:param];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:completion];
}

- (void)clearAllCache {
    [cache removeAllCachedResponses];
}

@end
