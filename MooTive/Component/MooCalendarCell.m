//
//  MooCalendarCell.m
//  MooCalendar
//  Created by Jakit on 16/11/23.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooCalendarCell.h"

#define defaultDiameterOfRound 34
#define defaultWidthOfUnderline 12
#define defaultPaddingBottomOfUnderline 9

@interface MooCalendarCell()
{
    @private
    MooCalendarCellStyle _style;
    CAShapeLayer *_roundLayer;
    CAShapeLayer *_underlineLayer;
}

@end

@implementation MooCalendarCell

- (MooCalendarCellStyle)dayStyle {
    return _style;
}

- (void)setDayStyle:(MooCalendarCellStyle)style {
    _style = style;
    
    switch (_style) {
        case MooCalendarCellToday:
            [_roundLayer setHidden:NO];
            [self.day setTextColor:[UIColor whiteColor]];
            break;
            
        case MooCalendarCellPassed:
            [_roundLayer setHidden:YES];
            [self.day setTextColor:[self colorFromRGBA:0xbbbbbb withAlphaValue:1]];
            break;
            
        default:
            [_roundLayer setHidden:YES];
            [self.day setTextColor:[self colorFromRGBA:0x333333 withAlphaValue:1]];
            break;
    }
}

- (void)setUnderline:(BOOL)isUnderline {
    if (isUnderline) {
        [_underlineLayer setHidden:NO];
        
    } else {
        [_underlineLayer setHidden:YES];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    // Init round layer
    _roundLayer = [CAShapeLayer layer];
    [_roundLayer setFrame:CGRectMake((self.bounds.size.width - defaultDiameterOfRound) / 2, (self.bounds.size.height - defaultDiameterOfRound) / 2, defaultDiameterOfRound, defaultDiameterOfRound)];
    
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(defaultDiameterOfRound / 2, defaultDiameterOfRound / 2) radius:defaultDiameterOfRound / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [_roundLayer setPath:roundPath.CGPath];
    [_roundLayer setFillColor:[self colorFromRGBA:0xfc913a withAlphaValue:1].CGColor];
    
    [self.layer addSublayer:_roundLayer];
    
    // Init underline layer
    _underlineLayer = [CAShapeLayer layer];
    [_underlineLayer setFrame:CGRectMake((self.bounds.size.width - defaultWidthOfUnderline) / 2, self.bounds.size.height - defaultPaddingBottomOfUnderline, defaultWidthOfUnderline, 1)];
    [_underlineLayer setBackgroundColor:[self colorFromRGBA:0xf84b45 withAlphaValue:1].CGColor];
    
    [self.layer addSublayer:_underlineLayer];
    
    // Init label
    [self setDay:[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)]];
    [self.day setFont:[UIFont systemFontOfSize:17]];
    [self.day setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:self.day];
    
    // Prepare for basic styles
    [self setDayStyle:MooCalendarCellNormal];
    [self setUnderline:NO];
}


- (UIColor *)colorFromRGBA:(int)rgbValue withAlphaValue:(float)alphaValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue];
}

@end
