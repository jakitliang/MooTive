//
//  MooJSONResponse.m
//  xiaoqiandai
//
//  Created by Jakit on 16/6/13.
//  Copyright © 2016年 xq. All rights reserved.
//

#import "MooJSONResponse.h"

@implementation MooJSONResponse

- (MooJSONResponse *)initWithStatus:(NSString *)JSONStatus withData:(id)JSONData
{
    self = [super init];
    if (self) {
        status = [JSONStatus intValue];
        message = [NSString stringWithFormat:@"%@", JSONData];
    }
    return self;
}

@end
