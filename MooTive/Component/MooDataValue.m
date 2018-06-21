//
//  MooDataValue.m
//  Created by Jakit on 16/8/31.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooDataValue.h"

@implementation MooDataValue

+ (MooDataValue *)valueWithType:(MooDataValueType)type forKey:(id)key withAttribute:(id)attr
{
    return [[MooDataValue alloc] initWithType:type forKey:key withAttribute:attr];
}

- (MooDataValue *)initWithType:(MooDataValueType)type forKey:(id)key withAttribute:(id)attr
{
    self = [super init];
    if (self) {
        _type = type;
        _key = key;
        _attr = attr;
    }
    return self;
}

@end
