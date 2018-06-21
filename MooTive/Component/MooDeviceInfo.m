//
//  MooDeviceInfo.m
//  Created by Jakit on 16/9/5.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooDeviceInfo.h"
#import <sys/utsname.h>

@implementation MooDeviceInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        struct utsname sysInfo;
        uname(&sysInfo);
#ifdef DEBUG
        NSLog(@"%s", sysInfo.machine);
#endif
        
        NSString *machine = [NSString stringWithFormat:@"%s", sysInfo.machine];
        NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"(^[a-zA-Z]+)|(\\d+)|,|(\\d+)$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *matched = [regexp matchesInString:machine options:0 range:NSMakeRange(0, [machine length])];
        
        int i = 0;
        for (NSTextCheckingResult *result in matched) {
            NSString *getString = [machine substringWithRange:result.range];
//            NSLog(@"%d ---- %@", i, getString);
            
            if (i == 0) {
                _name = getString;
                if ([_name isEqualToString:@"iPhone"]) {
                    _type = 0;
                    
                } else if ([_name isEqualToString:@"iPad"]) {
                    _type = 1;
                    
                } else {
                    _type = 2;
                }
                
            } else if (i == 1) {
                _generation = [getString intValue];
            }
            
            i++;
        }
    }
    return self;
}

@end
