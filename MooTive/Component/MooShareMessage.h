//
//  MooShareMessage.h
//  Created by Jakit on 16/8/22.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MooShareMessage : NSObject

@property NSString *title;
@property NSString *content;
@property NSData *imageData;
@property NSString *URL;

- (MooShareMessage *)initWithTitle:(NSString *)title withContent:(NSString *)content withImageData:(NSData *)imageData withURL:(NSString *)URL;

@end
