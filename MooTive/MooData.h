//
//  MooData.h
//
//  Created by Jakit on 16/8/31.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MooDataValue.h"

@interface MooData : NSObject
{
    @protected
    NSArray *_values;
}

+ (MooData *)data;

+ (MooData *)dataWithData:(id)data;

+ (MooData *)dataWithData:(id)data withValues:(NSArray *)values;

- (MooData *)init;

- (MooData *)initWithData:(id)data;

- (MooData *)initWithData:(id)data withValues:(NSArray *)values;

- (NSArray *)defaultValues;

- (void)assignValue:(id)value withType:(MooDataValueType)type forKey:(id)key;

- (id)valueFromData:(id)data forKey:(id)key withType:(MooDataValueType)type;

@end
