//
//  MooModel.h
//  xiaoqiandai
//
//  Created by Jakit on 16/5/6.
//  Copyright © 2016年 xq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MooWeb.h"
#import "MooJSONResponse.h"

@interface MooModel : NSObject
{
    @public
    NSString *api;
    MooWeb *conn;
    MooJSONResponse *response;
}

/*!
 @abstract 初始化
 @discussion 根据url地址初始化数据模型
 @param url 地址
 */
- (instancetype)initWithURL:(NSString *)url;

+ (id)getInstance;

/*!
 @abstract HTTP GET
 @discussion 根据API地址发送GET请求并获取数据
 @param path 地址
 @param completion 获取数据后回调
 */
- (void)get:(NSString *)path completion:(void (^)(NSData *data))completion;

/*!
 @abstract HTTP POST
 @discussion 根据API地址发送POST请求并获取数据
 @param path 地址
 @param param 参数
 @param completion 获取数据后回调
 */
- (void)post:(NSString *)path withParam:(NSMutableData *)param completion:(void (^)(NSData *data))completion;

/*!
 @abstract GET获取JSON
 @discussion 根据API地址发送GET请求，获取JSON并解析
 @param path 地址
 @param completion 获取数据后回调
 */
- (void)getJSON:(NSString *)path completion:(void (^)(NSString *status, id data))completion;

/*!
 @abstract POST获取JSON
 @discussion 根据API地址发送POST请求，获取JSON并解析
 @param path 地址
 @param param 参数
 @param completion 获取数据后回调
 */
- (void)postJSON:(NSString *)path withParam:(NSMutableData *)param completion:(void (^)(NSString *status, id data))completion;

@end