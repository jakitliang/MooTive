//
//  MooWait.m
//  Created by Jakit on 16/7/29.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooWait.h"

@implementation MooWait

- (MooWait *)init
{
    self = [super init];
    if (self) {
        width = 60;
        height = 60;
        
        [self setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - width / 2, [UIScreen mainScreen].bounds.size.height / 2 - height / 2, width, height)];
        
        [self setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        CAShapeLayer *layerFrame = [CAShapeLayer layer];
        UIBezierPath *pathFrame = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height) cornerRadius:5.f];
        [layerFrame setPath:pathFrame.CGPath];
        
        CAShapeLayer *layerBackground = [CAShapeLayer layer];
        UIBezierPath *pathBackground = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, height)];
        [layerBackground setBackgroundColor:[UIColor blackColor].CGColor];
        [layerBackground setPath:pathBackground.CGPath];
        [layerBackground setOpacity:0.35];
        
        [self.layer insertSublayer:layerBackground below:self.layer.sublayers.lastObject];
        [self.layer setMask:layerFrame];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
