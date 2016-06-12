//
//  MooCommon.m
//  xiaoqiandai
//
//  Created by Jakit on 16/5/13.
//  Copyright © 2016年 xq. All rights reserved.
//

#import "MooCommon.h"
#import <math.h>

@implementation MooCommon

- (UIColor *)colorFromRGBA:(int)rgbValue withAlphaValue:(int)alphaValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue];
}

- (float)getRadian:(float)degree {
    return degree * (M_PI / 180);
}

- (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height {
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [color set];
    UIRectFill(CGRectMake(0, 0, width, height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)alertInfo:(NSString *)title withMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}

@end
