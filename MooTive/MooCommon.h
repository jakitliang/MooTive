//
//  MooCommon.h
//
//  Author: Jakit Liang<jakit_mail@163.com>
//  Created by Jakit on 16/5/13.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MooDeviceInfo.h"

@interface MooCommon : NSObject <UIAlertViewDelegate>
{
    @private
    MooDeviceInfo *deviceInfo;
}

+ (MooCommon *)getInstance;

- (UIColor *)colorFromRGBA:(int)rgbValue withAlphaValue:(float)alphaValue;

- (float)getRadian:(float)degree;

- (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height;

- (UIImage *)imageWithText:(NSString *)text withColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height;

- (UIImage *)imageWithText:(NSString *)text withColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height withBackgroundImage:(UIImage *)backgroundImage;

- (void)alertInfo:(NSString *)title withMessage:(NSString *)message;

- (void)alertConfirmWithController:(UIViewController *)controller withTitle:(NSString *)title withMessage:(NSString *)message withHandle:(void (^)(void))handle;

- (void)alertConfirmWithController:(UIViewController *)controller withTitle:(NSString *)title withMessage:(NSString *)message withTitleOfCancel:(NSString *)titleOfCancel withTitleOfOK:(NSString *)titleOfOK withHandle:(void (^)(void))handle;

- (void)alertConfirmWithController:(UIViewController *)controller withTitle:(NSString *)title withAttributedMessage:(NSAttributedString *)attrString withTitleOfCancel:(NSString *)titleOfCancel withTitleOfOK:(NSString *)titleOfOK withHandle:(void (^)(void))handle;

- (NSArray *)splitByDot:(NSString *)number withOffset:(NSUInteger)offset;

- (NSString *)splitByThousand:(NSString *)number;

- (NSString *)representInCurrency:(NSString *)number;

- (NSString *)addThousandSplitterToString:(NSString *)str;

- (NSString *)stringConvertFromDate:(NSDate *)date withFormat:(NSString *)format;

- (NSString *)maskString:(NSString *)str withMaskString:(NSString *)mask startFrom:(NSUInteger)start withLength:(NSUInteger)length;

- (NSInteger)scanIntegerWithString:(NSString *)str;

- (NSUInteger)scanUIntegerWithString:(NSString *)str;

- (NSDate *)dateConvertFromString:(NSString *)str withFormat:(NSString *)format;

- (NSString *)HmacMD5:(NSString *)str WithKey:(NSString *)key;

- (MooDeviceInfo *)getDeviceInfo;

- (NSString *)getRandomsWithLength:(NSUInteger)length;

- (BOOL)isFile:(NSString *)fileName;

- (void)writeDictionary:(NSDictionary *)dictionary toFile:(NSString *)fileName;

- (NSDictionary *)readFile:(NSString *)fileName;

- (BOOL)removeFile:(NSString *)fileName;

@end
