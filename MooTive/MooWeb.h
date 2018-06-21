//
//  MooWeb.h
//  Created by Jakit on 16/5/4.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MooWeb : NSObject
{
    @private
    NSOperationQueue *queue;
    NSURLCache *cache;
}

/*!
 * @abstract 同步HTTP请求方法
 * @discussion 获取数据并返回
 * @param strUrl 地址
 * @param method 方法(POST / GET)
 * @param param 参数
 * @result NSData
 *
 */
- (NSData *)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSData *)param;

/*!
 * @abstract 异步HTTP请求方法
 * @discussion 获取数据并回调
 * @param strUrl 地址
 * @param method 方法(POST / GET)
 * @param param 参数
 * @param completion 回调块
 */
- (void)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSData *)param completion:(void (^)(NSURLResponse * response, NSData * data, NSError * connectionError))completion;

@end
