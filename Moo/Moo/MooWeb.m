//
//  MooWeb.m
//  xiaoqiandai
//
//  Created by Jakit on 16/5/4.
//  Copyright © 2016年 xq. All rights reserved.
//

#import "MooWeb.h"

@implementation MooWeb

- (id)init {
    if (self = [super init]) {
        queue = [NSOperationQueue mainQueue];
    }
    return self;
}

- (NSData *)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSMutableData *)param {
    // 初始化路径
    NSURL *url = [[NSURL alloc] initWithString:strUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    // 包装HTTP头
    NSDictionary *header = [request allHTTPHeaderFields];
    [header setValue:@"iOS-Client" forKey:@"User-Agent"];
    [request setHTTPMethod:method];
    
    // 包装数据
    [request setHTTPBody:param];
    
    NSData *result;
    NSURLResponse *response;
    NSError *err;
    
    result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    if (err) {
        NSLog(@"Error: %@", err.localizedDescription);
    }
    
    return result;
}

- (void)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSMutableData *)param completion:(void (^)(NSURLResponse * response, NSData * data, NSError * connectionError))completion {
    // 初始化路径
    NSURL *url = [[NSURL alloc] initWithString:strUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    // 包装HTTP头
    NSDictionary *header = [request allHTTPHeaderFields];
    [header setValue:@"iOS-Client" forKey:@"User-Agent"];
    [request setHTTPMethod:method];
    
    // 包装数据
    [request setHTTPBody:param];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:completion];
}

@end
