//
//  MooJSONResponse.h
//  Created by Jakit on 16/6/13.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MooJSONResponseError = 0,
    MooJSONResponseOK = 1
} MooJSONResponseStatus;

@interface MooJSONResponse : NSObject
{
    @public
    MooJSONResponseStatus status;
    NSString *message;
}

- (MooJSONResponse *)initWithStatus:(NSString *)JSONStatus withData:(id)JSONData;

@end
