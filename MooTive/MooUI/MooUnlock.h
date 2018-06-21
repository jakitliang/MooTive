//
//  MooUnlock.h
//  Created by Jakit on 16/9/23.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MooCommon.h"

@protocol MooUnlockDelegate;

@interface MooUnlock : UIView
{
    @private
    CGFloat _width;
    CGFloat _height;
    NSDictionary *_buttonImages;
    CAShapeLayer *_drawLayer;
    UIBezierPath *_drawPath;
    MooCommon *_mc;
}

@property NSMutableArray *buttons;

@property NSMutableArray *markedOrder;

@property UIColor* lineColor;

@property (nonatomic, weak) id<MooUnlockDelegate> mooUnlockDelegate;

- (instancetype)initWithButtonImages:(NSDictionary *)images;

- (void)resetMarkedButtons;

- (void)highlightButtons;

@end

@protocol MooUnlockDelegate <NSObject>

@optional

- (void)getUnlockMap:(NSArray *)unlockMap;

@end
