//
//  MooButton.m
//  Created by Jakit on 16/6/23.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooButton.h"
#import "MooCommon.h"

@interface MooButton()
{
@private
    UIView *wrapper;
    CAShapeLayer *maskLayer;
    CGFloat borderRadius;
}

@end

@implementation MooButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    borderRadius = 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (maskLayer != nil) {
        if (maskLayer.frame.size.width != self.frame.size.width || maskLayer.frame.size.height != self.frame.size.height) {
            [self drawBorderRadius];
        }
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)roundCornerRadius:(CGFloat)radius
{
    borderRadius = radius;
    
    [self drawBorderRadius];
}

- (void)drawBorderRadius {
    maskLayer = [CAShapeLayer layer];
    [maskLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:maskLayer.frame cornerRadius:borderRadius];
    [maskLayer setPath:maskPath.CGPath];
    
    [self.layer setMask:maskLayer];
}

- (void)buttonWithIcon:(UIImage *)icon withText:(NSString *)text withFont:(UIFont *)font
{
    [self layoutIfNeeded];
    
    if (self.subviews.count > 1) {
        UIView *subview = [self.subviews lastObject];
        [subview removeFromSuperview];
    }
    
    wrapper = [[UIView alloc] init];
    [wrapper setTranslatesAutoresizingMaskIntoConstraints:NO];
    [wrapper setUserInteractionEnabled:NO];
    
    _iconImage = [[UIImageView alloc] init];
    [_iconImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_iconImage setUserInteractionEnabled:NO];
    [_iconImage setImage:icon];
    
    _textLabel = [[UILabel alloc] init];
    [_textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_textLabel setUserInteractionEnabled:NO];
    [_textLabel setTextColor:[UIColor whiteColor]];
    [_textLabel setFont:font];
    _textLabel.text = text;
    
    [wrapper addSubview:_iconImage];
    [wrapper addSubview:_textLabel];
    
    [self addSubview:wrapper];
    
    NSLayoutConstraint *textToIconConstraint = [NSLayoutConstraint constraintWithItem:_textLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_iconImage attribute:NSLayoutAttributeTrailing multiplier:1 constant:6];
    
    [wrapper addConstraint:textToIconConstraint];
    
    NSLayoutConstraint *wrapperToIconConstraint = [NSLayoutConstraint constraintWithItem:wrapper attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_iconImage attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    
    NSLayoutConstraint *wrapperToTextConstraint = [NSLayoutConstraint constraintWithItem:wrapper attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_textLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    
    [wrapper addConstraint:wrapperToIconConstraint];
    [wrapper addConstraint:wrapperToTextConstraint];
    
    NSLayoutConstraint *wrapperToSelfHeightConstraint = [NSLayoutConstraint constraintWithItem:wrapper attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    
    NSLayoutConstraint *wrapperToSelfCenterXConstraint = [NSLayoutConstraint constraintWithItem:wrapper attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    NSLayoutConstraint *wrapperToSelfCenterYConstraint = [NSLayoutConstraint constraintWithItem:wrapper attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self addConstraint:wrapperToSelfHeightConstraint];
    [self addConstraint:wrapperToSelfCenterXConstraint];
    [self addConstraint:wrapperToSelfCenterYConstraint];
    
    NSLayoutConstraint *iconToWrapperCenterConstraint = [NSLayoutConstraint constraintWithItem:_iconImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:wrapper attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    NSLayoutConstraint *textToWrapperCenterConstraint = [NSLayoutConstraint constraintWithItem:_textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:wrapper attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [wrapper addConstraint:iconToWrapperCenterConstraint];
    [wrapper addConstraint:textToWrapperCenterConstraint];
}

@end
