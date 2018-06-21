//
//  MooDeviceInfo.h
//  Created by Jakit on 16/9/5.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    IPHONE = 0,
    IPAD = 1,
    IPOD = 2,
} MooDeviceType;

@interface MooDeviceInfo : NSObject

@property (readonly) NSString *name;
@property (readonly) MooDeviceType type;
@property (readonly) NSUInteger generation;

- (instancetype)init;

@end
