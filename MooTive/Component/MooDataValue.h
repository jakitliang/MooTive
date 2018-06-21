//
//  MooDataValue.h
//  Created by Jakit on 16/8/31.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MooDataDefaultType,
    MooDataIntegerNumberType,
    MooDataUIntegerNumberType,
    MooDataDoubleNumberType,
    MooDataStringType,
    MooDataIntType,
    MooDataDoubleType,
    MooDataIntegerType,
    MooDataUIntegerType,
    MooDataDateType,
    MooDataEnumType
} MooDataValueType;

@interface MooDataValue : NSObject

@property (readonly) MooDataValueType type;
@property (readonly) id key;
@property (readonly) id attr;

+ (MooDataValue *)valueWithType:(MooDataValueType)type forKey:(id)key withAttribute:(id)attr;

- (MooDataValue *)initWithType:(MooDataValueType)type forKey:(id)key withAttribute:(id)attr;

@end
