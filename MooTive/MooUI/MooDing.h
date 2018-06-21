//
//  MooDing.h
//  Created by Jakit on 16/10/21.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MooCommon.h"

@interface MooDing : UIView
{
    @private
    MooCommon *_mc;
    UILabel *_alertText;
    NSTimer *_timer;
    CGPoint _originCenter;
    BOOL _vibrate;
    void (^_clickAction)(void);
}

- (BOOL)isVibrate;

- (void)setVibrate:(BOOL)vibrate;

- (UILabel *)alertText;

- (void)setClickAction:(void (^)(void))clickAction;

- (void)ding;

@end
