//
//  MooCommon.m
//  xiaoqiandai
//
//  Created by Jakit on 16/5/13.
//  Copyright © 2016年 xq. All rights reserved.
//

#import "MooCommon.h"
#import <math.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation MooCommon

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

- (void)alertInfo:(NSString *)title withMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
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

- (NSString *)stringConverFromDate:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:format];
    return [fmt stringFromDate:date];
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
    }
    else {
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

@end
