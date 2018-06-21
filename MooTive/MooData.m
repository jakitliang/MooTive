//
//  MooData.m
//
//  Created by Jakit on 16/8/31.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooData.h"

@implementation MooData

+ (MooData *)data
{
    return [[MooData alloc] init];
}

+ (MooData *)dataWithData:(id)data
{
    return [[MooData alloc] initWithData:data];
}

+ (MooData *)dataWithData:(id)data withValues:(NSArray *)values
{
    return [[MooData alloc] initWithData:data withValues:values];
}

- (MooData *)init
{
    self = [super init];
    
    if (self) {
        NSArray *values = [self defaultValues];
        
        if (values != nil) {
            for (MooDataValue *value in values) {
                if ([value isKindOfClass:[MooDataValue class]]) {
                    [self assignValue:nil withType:value.type forKey:value.attr];
                    
                } else {
#ifdef DEBUG
                    NSLog(@"Value %@ is not an instance of MooDataValue", value);
#endif
                }
            }
        }
    }
    
    return self;
}

- (MooData *)initWithData:(id)data
{
    self = [super init];
    
    if (self) {
        NSArray *values = [self defaultValues];
        
        if (values != nil) {
            [self initializeWithData:data withValues:values];
        }
    }
    
    return self;
}

- (MooData *)initWithData:(id)data withValues:(NSArray *)values
{
    self = [super init];
    
    if (self) {
        [self initializeWithData:data withValues:values];
    }
    
    return self;
}

- (void)initializeWithData:(id)data withValues:(NSArray *)values
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        for (MooDataValue *value in values) {
            if ([value isKindOfClass:[MooDataValue class]]) {
                [self assignValue:[data objectForKey:value.key] withType:value.type forKey:value.attr];
                
            } else {
#ifdef DEBUG
                NSLog(@"Value %@ is not an instance of MooDataValue", value);
#endif
            }
        }
        
    } else {
#ifdef DEBUG
        NSLog(@"Data is not dict-type when parsing");
#endif
    }
}

- (NSArray *)defaultValues
{
    return _values;
}

- (void)assignValue:(id)value withType:(MooDataValueType)type forKey:(id)key
{
    @try {
        [self setValue:[self convertValue:value toType:type] forKey:key];
        
    } @catch (NSException *exception) {
        NSLog(@"Data %@ can not assign to %@ with type %d.", value, key, type);
    }
}

- (id)valueFromData:(id)data forKey:(id)key withType:(MooDataValueType)type
{
    return [self convertValue:[data objectForKey:key] toType:type];
}

- (id)convertValue:(id)value toType:(MooDataValueType)type
{
    id targetValue;
    
    @try {
        if (value == nil || value == [NSNull null]) {
            switch (type) {
                case MooDataDefaultType:
                    targetValue = [NSNull null];
                    break;
                    
                case MooDataIntegerNumberType:
                    targetValue = [NSNumber numberWithInteger:0];
                    break;
                    
                case MooDataUIntegerNumberType:
                    targetValue = [NSNumber numberWithUnsignedInteger:0];
                    break;
                    
                case MooDataDoubleNumberType:
                    targetValue = [NSNumber numberWithDouble:0.f];
                    break;
                    
                case MooDataIntType:
                    targetValue = [NSNumber numberWithInt:0];
                    break;
                    
                case MooDataDoubleType:
                    targetValue = [NSNumber numberWithDouble:0.f];
                    break;
                    
                case MooDataIntegerType:
                    targetValue = [NSNumber numberWithInteger:0];
                    break;
                    
                case MooDataUIntegerType:
                    targetValue = [NSNumber numberWithUnsignedInteger:0];
                    break;
                    
                case MooDataStringType:
                    targetValue = [[NSString alloc] init];
                    break;
                    
                case MooDataDateType:
                    targetValue = [NSDate date];
                    break;
                    
                case MooDataEnumType:
                    targetValue = [NSNumber numberWithUnsignedInteger:0];
                    break;
                    
                default:
#ifdef DEBUG
                    NSLog(@"Value %@ has no matched with type %d", value, type);
#endif
                    break;
            }
            
        } else {
            switch (type) {
                case MooDataDefaultType:
                    targetValue = value;
                    break;
                    
                case MooDataIntegerNumberType:
                    targetValue = [NSNumber numberWithInteger:[value integerValue]];
                    break;
                    
                case MooDataUIntegerNumberType:
                    if ([value isKindOfClass:[NSString class]]) {
                        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                        targetValue = [numberFormatter numberFromString:value];
                        
                    } else if ([value isKindOfClass:[NSNumber class]]) {
                        targetValue = @([value unsignedIntegerValue]);
                    }
                    break;
                    
                case MooDataDoubleNumberType:
                    targetValue = [NSNumber numberWithDouble:[value doubleValue]];
                    break;
                    
                case MooDataIntType:
                    targetValue = @([value intValue]);
                    break;
                    
                case MooDataDoubleType:
                    targetValue = @([value doubleValue]);
                    break;
                    
                case MooDataIntegerType:
                    value = @([value integerValue]);
                    break;
                    
                case MooDataUIntegerType:
                    if ([value isKindOfClass:[NSString class]]) {
                        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                        targetValue = @([numberFormatter numberFromString:value].unsignedIntegerValue);
                        
                    } else if ([value isKindOfClass:[NSNumber class]]) {
                        targetValue = @([value unsignedIntegerValue]);
                    }
                    break;
                    
                case MooDataStringType:
                    if ([value isKindOfClass:[NSString class]]) {
                        targetValue = value;
                        
                    } else if ([value isKindOfClass:[NSNumber class]]) {
                        targetValue = [value stringValue];
                    }
                    break;
                    
                case MooDataDateType:
                    targetValue = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
                    break;
                    
                case MooDataEnumType:
                    targetValue = @([value intValue]);
                    break;
                    
                default:
#ifdef DEBUG
                    NSLog(@"Value %@ has no matched with type %d", value, type);
#endif
                    break;
            }
        }
        
    } @catch (NSException *exception) {
        NSLog(@"Data %@ can not convert to type %d.", value, type);
    }
    
    return targetValue;
}

@end
