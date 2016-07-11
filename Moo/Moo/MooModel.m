//
//  MooModel.m
//  xiaoqiandai
//
//  Created by Jakit on 16/5/6.
//  Copyright © 2016年 xq. All rights reserved.
//

#import "MooModel.h"

@implementation MooModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        conn = [[MooWeb alloc] init];
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)url {
    if (self = [super init]) {
        api = url;
        conn = [[MooWeb alloc] init];
    }
    return self;
}

+ (id)getInstance {
    static NSMutableDictionary *dictModels;
    NSString *name = NSStringFromClass([self class]);
    
    @synchronized (self) {
        if (dictModels == nil) {
            dictModels = [[NSMutableDictionary alloc] init];
        }
    
        if ([dictModels objectForKey:name] == nil) {
            [dictModels setObject:[[NSClassFromString(name) alloc] init] forKey:name];
        }
    }
    
    return [dictModels objectForKey:name];
}

- (void)get:(NSString *)path completion:(void (^)(NSData *data))completion {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", api, path];
    [conn curl:requestURL withMethod:@"GET" withParam:nil completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Connection Error: %@", connectionError.description);
            return;
        }
        
        completion(data);
    }];
}

- (void)post:(NSString *)path withParam:(NSMutableData *)param completion:(void (^)(NSData *data))completion {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", api, path];
    [conn curl:requestURL withMethod:@"POST" withParam:param completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Connection Error: %@", connectionError.description);
            return;
        }
        
        completion(data);
    }];
}

- (void)getJSON:(NSString *)path completion:(void (^)(NSString *status, id data))completion {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", api, path];
    [conn curl:requestURL withMethod:@"GET" withParam:nil completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Connection Error: %@", connectionError.description);
            return;
        }
        
        NSError *err;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
        
        if (!err) {
            NSString *status = [result objectForKey:@"status"];
            self->response = [[MooJSONResponse alloc] initWithStatus:status withData:[result objectForKey:@"data"]];
            completion(status, [result objectForKey:@"data"]);
            
        } else {
            NSLog(@"%@", err.description);
        }
    }];
}

- (void)postJSON:(NSString *)path withParam:(NSMutableData *)param completion:(void (^)(NSString *status, id data))completion {
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", api, path];
    [conn curl:requestURL withMethod:@"POST" withParam:param completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Connection Error: %@", connectionError.description);
            return;
        }
        
        NSError *err;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
        
        if (!err) {
            NSString *status = [result objectForKey:@"status"];
            self->response = [[MooJSONResponse alloc] initWithStatus:status withData:[result objectForKey:@"data"]];
            completion(status, [result objectForKey:@"data"]);
            
        } else {
            NSLog(@"JSON parse Error: %@", err.description);
            NSLog(@"Origin Data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }];
}

@end
