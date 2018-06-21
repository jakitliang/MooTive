//
//  MooShareMessage.m
//  Created by Jakit on 16/8/22.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooShareMessage.h"

@implementation MooShareMessage

- (MooShareMessage *)initWithTitle:(NSString *)title withContent:(NSString *)content withImageData:(NSData *)imageData withURL:(NSString *)URL
{
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
        self.imageData = imageData;
        self.URL = URL;
    }
    return self;
}

@end
