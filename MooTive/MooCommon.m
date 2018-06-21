//
//  MooCommon.m
//
//  Author: Jakit Liang<jakit_mail@163.com>
//  Created by Jakit on 16/5/13.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooCommon.h"
#import <math.h>
#import <CommonCrypto/CommonHMAC.h>

static MooCommon *mc;

@implementation MooCommon

+ (MooCommon *)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mc = [[MooCommon alloc] init];
    });
    return mc;
}

- (UIColor *)colorFromRGBA:(int)rgbValue withAlphaValue:(float)alphaValue {
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

- (UIImage *)imageWithText:(NSString *)text withColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height {
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [color set];
    [text drawInRect:CGRectMake(0, 0, width, height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:color}];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageWithText:(NSString *)text withColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height withBackgroundImage:(UIImage *)backgroundImage {
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [color set];
    [backgroundImage drawInRect:CGRectMake(0, 0, width, height)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [paragraphStyle setMaximumLineHeight:27];
    [text drawInRect:CGRectMake(0, 4, width, 16) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:color, NSParagraphStyleAttributeName:paragraphStyle}];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)alertInfo:(NSString *)title withMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertConfirmWithController:(UIViewController *)controller withTitle:(NSString *)title withMessage:(NSString *)message withHandle:(void (^)(void))handle
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handle != nil) {
            handle();
        }
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:OKAction];
    
    [controller presentViewController:alert animated:YES completion:nil];
}

- (void)alertConfirmWithController:(UIViewController *)controller withTitle:(NSString *)title withMessage:(NSString *)message withTitleOfCancel:(NSString *)titleOfCancel withTitleOfOK:(NSString *)titleOfOK withHandle:(void (^)(void))handle
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:titleOfCancel style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:titleOfOK style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handle != nil) {
            handle();
        }
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:OKAction];
    
    [controller presentViewController:alert animated:YES completion:nil];
}

- (void)alertConfirmWithController:(UIViewController *)controller withTitle:(NSString *)title withAttributedMessage:(NSAttributedString *)attrString withTitleOfCancel:(NSString *)titleOfCancel withTitleOfOK:(NSString *)titleOfOK withHandle:(void (^)(void))handle
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:[attrString string] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:titleOfCancel style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:titleOfOK style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        handle();
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:OKAction];
    
    [alert setValue:attrString forKey:@"attributedMessage"];
    
    [controller presentViewController:alert animated:YES completion:nil];
}

- (NSArray *)splitByDot:(NSString *)number withOffset:(NSUInteger)offset {
    NSString *strInt = [number substringToIndex:[number rangeOfString:@"."].location + offset];
    NSString *strFrac = [number substringFromIndex:[number rangeOfString:@"."].location + offset];
    return @[strInt, strFrac];
}

- (NSString *)splitByThousand:(NSString *)number {
    int len;
    
    if ([number rangeOfString:@"."].location == NSNotFound) {
        len = (int)number.length;
        
    } else {
        len = (int)number.length - 1;
    }
    
    int start = len % 3;
    
    NSString *strCombine = [number substringWithRange:NSMakeRange(0, start)];
    for (int i = start; i < len; i += 3) {
        strCombine = [NSString stringWithFormat:@"%@,%@", strCombine, [number substringWithRange:NSMakeRange(i, 3)]];
    }
    
    if ([[strCombine substringToIndex:1] isEqualToString:@","]) {
        strCombine = [strCombine substringFromIndex:1];
    }
    
    return strCombine;
}

- (NSString *)representInCurrency:(NSString *)number {
    NSString *currencyString = [[NSString alloc] init];
    
    if ([number length] < 1) {
        return currencyString;
    }
    
    if ([number rangeOfString:@"."].location != NSNotFound) {
        NSArray *numberSplitedByDot = [self splitByDot:number withOffset:0];
        NSString *numberIntPart = [self splitByThousand:numberSplitedByDot[0]];
        
        currencyString = [NSString stringWithFormat:@"%@%@", numberIntPart, numberSplitedByDot[1]];
        
    } else {
        currencyString = [self splitByThousand:number];
    }
    
    return currencyString;
}

- (NSString *)addThousandSplitterToString:(NSString *)str {
    NSString *stringWithSpillter;
    
    if ([str rangeOfString:@"."].location != NSNotFound) {
        NSArray *number = [self splitByDot:str withOffset:0];
        stringWithSpillter = [NSString stringWithFormat:@"%@%@", [self splitByThousand:number[0]], number[1]];
        
    } else {
        stringWithSpillter = [self splitByThousand:str];
    }
    
    return stringWithSpillter;
}

- (NSString *)stringConvertFromDate:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:format];
    return [fmt stringFromDate:date];
}

- (NSDate *)dateConvertFromString:(NSString *)str withFormat:(NSString *)format {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:format];
    return [fmt dateFromString:str];
}

- (NSString *)maskString:(NSString *)str withMaskString:(NSString *)mask startFrom:(NSUInteger)start withLength:(NSUInteger)length {
    NSString *strBefore;
    NSString *strAfter;
    NSMutableString *strMask;
    
    if (str != nil && [str isKindOfClass:[NSString class]]) {
        @try {
            strBefore = [str substringToIndex:start];
            strAfter = [str substringFromIndex:start + length];
            strMask = [[NSMutableString alloc] init];
            
            for (int i = 0; i < length; i++) {
                [strMask appendString:mask];
            }
            
        } @catch (NSException *exception) {
#ifdef DEBUG
            NSLog(@"%@", exception.description);
#endif
        }
        
    } else {
        return str;
    }
    
    return [NSString stringWithFormat:@"%@%@%@", strBefore, strMask, strAfter];
}

- (NSInteger)scanIntegerWithString:(NSString *)str {
    NSUInteger result;
#if __LP64__
    sscanf([str UTF8String], "%ld", &result);
#else
    sscanf([str UTF8String], "%d", &result);
#endif
    return result;
}

- (NSUInteger)scanUIntegerWithString:(NSString *)str {
    NSUInteger result;
#if __LP64__
    sscanf([str UTF8String], "%lu", &result);
#else
    sscanf([str UTF8String], "%u", &result);
#endif
    return result;
}

- (NSString *)HmacMD5:(NSString *)str WithKey:(NSString *)key {
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [str cStringUsingEncoding:NSUTF8StringEncoding];
    const unsigned int blockSize = 64;
    char ipad[blockSize];
    char opad[blockSize];
    char keypad[blockSize];
    
    unsigned int keyLen = (unsigned int)strlen(cKey);
    CC_MD5_CTX ctxt;
    if (keyLen > blockSize) {
        CC_MD5_Init(&ctxt);
        CC_MD5_Update(&ctxt, cKey, keyLen);
        CC_MD5_Final((unsigned char *)keypad, &ctxt);
        keyLen = CC_MD5_DIGEST_LENGTH;
    } else {
        memcpy(keypad, cKey, keyLen);
    }
    
    memset(ipad, 0x36, blockSize);
    memset(opad, 0x5c, blockSize);
    
    int i;
    for (i = 0; i < keyLen; i++) {
        ipad[i] ^= keypad[i];
        opad[i] ^= keypad[i];
    }
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, ipad, blockSize);
    CC_MD5_Update(&ctxt, cData, (unsigned int)strlen(cData));
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(md5, &ctxt);
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, opad, blockSize);
    CC_MD5_Update(&ctxt, md5, CC_MD5_DIGEST_LENGTH);
    CC_MD5_Final(md5, &ctxt);
    
    const unsigned int hex_len = CC_MD5_DIGEST_LENGTH*2+2;
    char hex[hex_len];
    for(i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        snprintf(&hex[i*2], hex_len-i*2, "%02x", md5[i]);
    }
    
    NSData *HMAC = [[NSData alloc] initWithBytes:hex length:strlen(hex)];
    NSString *hash = [[NSString alloc] initWithData:HMAC encoding:NSUTF8StringEncoding];
    return hash;
}

- (MooDeviceInfo *)getDeviceInfo {
    if (deviceInfo == nil) {
        deviceInfo = [[MooDeviceInfo alloc] init];
    }
    
    return deviceInfo;
}

- (NSString *)getRandomsWithLength:(NSUInteger)length {
    NSMutableArray *num = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [num addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    NSMutableArray *alpha = [[NSMutableArray alloc] init];
    for (int j = 97; j < 123; j++) {
        [alpha addObject:[NSString stringWithFormat:@"%c", (char)j]];
    }
    
    NSMutableArray *capitalAlpha = [[NSMutableArray alloc] init];
    for (int k = 65; k < 91; k++) {
        [capitalAlpha addObject:[NSString stringWithFormat:@"%c", (char)k]];
    }
    
    NSMutableArray *allAlpha = [[NSMutableArray alloc] initWithArray:alpha copyItems:YES];
    [allAlpha addObjectsFromArray:capitalAlpha];
    
    NSMutableArray *words = [[NSMutableArray alloc] initWithArray:allAlpha copyItems:YES];
    [words addObjectsFromArray:num];
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int l = 0; l < length; l++) {
        int pos = arc4random() % [words count];
        [str appendString:[words objectAtIndex:pos]];
    }
    
    return str;
}

- (BOOL)isFile:(NSString *)fileName {
    NSString *path = [NSString stringWithFormat:@"%@%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject], @"/"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:[path stringByAppendingString:fileName]];
}

- (void)writeDictionary:(NSDictionary *)dictionary toFile:(NSString *)fileName {
    NSString *path = [NSString stringWithFormat:@"%@%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject], @"/"];
    [dictionary writeToFile:[path stringByAppendingString:fileName] atomically:YES];
}

- (NSDictionary *)readFile:(NSString *)fileName {
    NSString *path = [NSString stringWithFormat:@"%@%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject], @"/"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[path stringByAppendingString:fileName]];
    return dictionary;
}

- (BOOL)removeFile:(NSString *)fileName {
    NSString *path = [NSString stringWithFormat:@"%@%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject], @"/"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *err;
    BOOL result = [fileManager removeItemAtPath:[path stringByAppendingString:fileName] error:&err];
    
#ifdef DEBUG
    if (err) {
        NSLog(@"%@", err.description);
    }
#endif
    
    return result;
}

@end
