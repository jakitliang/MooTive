//
//  MooBadge.m
//  Created by Jakit on 16/12/15.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooBadge.h"
#import "MooCommon.h"

#define defaultTitleLabelFontSize 10

@interface MooBadge()
{
    @private
    CAShapeLayer *borderLayer;
    CAShapeLayer *borderMaskLayer;
    MooCommon *mc;
}

@end

@implementation MooBadge

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [borderLayer setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    [borderMaskLayer setFrame:borderLayer.frame];
    
    UIBezierPath *originPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, borderMaskLayer.frame.size.width, borderMaskLayer.frame.size.height) cornerRadius:4];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(1, 1, borderMaskLayer.frame.size.width - 2, borderMaskLayer.frame.size.height - 2) cornerRadius:2.5];
    
    [originPath appendPath:maskPath];
    [originPath setUsesEvenOddFillRule:YES];
    
    [borderMaskLayer setPath:originPath.CGPath];
    
    [_titleLabel setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
}

- (void)initialize {
    mc = [MooCommon getInstance];
    
    borderLayer = [CAShapeLayer layer];
    [borderLayer setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    borderMaskLayer = [CAShapeLayer layer];
    [borderMaskLayer setFrame:borderLayer.frame];
    [borderMaskLayer setFillRule:kCAFillRuleEvenOdd];
    
    UIBezierPath *originPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, borderMaskLayer.frame.size.width, borderMaskLayer.frame.size.height) cornerRadius:4];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(1, 1, borderMaskLayer.frame.size.width - 2, borderMaskLayer.frame.size.height - 2) cornerRadius:2.5];
    
    [originPath appendPath:maskPath];
    [originPath setUsesEvenOddFillRule:YES];
    
    [borderMaskLayer setPath:originPath.CGPath];
    
    [borderLayer setMask:borderMaskLayer];
    
    [self.layer addSublayer:borderLayer];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [_titleLabel setFont:[UIFont systemFontOfSize:defaultTitleLabelFontSize]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:_titleLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setTintColor:(UIColor *)tintColor {
    [super setTintColor:tintColor];
    
    [borderLayer setBackgroundColor:tintColor.CGColor];
    [_titleLabel setTextColor:tintColor];
}

@end
