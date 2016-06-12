//
//  MooCommon.h
//  xiaoqiandai
//
//  Created by Jakit on 16/5/13.
//  Copyright © 2016年 xq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MooCommon : NSObject

- (UIColor *)colorFromRGBA:(int)rgbValue withAlphaValue:(int)alphaValue;
- (float)getRadian:(float)degree;
- (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height;
- (void)alertInfo:(NSString *)title withMessage:(NSString *)message;

@end
