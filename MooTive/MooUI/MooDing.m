//
//  MooDing.m
//  Created by Jakit on 16/10/21.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooDing.h"
#import <AudioToolbox/AudioToolbox.h>

#define DEFAULT_LEFT_RIGHT_MARGIN 5
#define DEFAULT_TOP_MARGIN 20
#define DEFAULT_HEIGHT 30

#define DEFAULT_WIDTH_HEIGHT_OF_ALERT_IMAGE 18
#define DEFAULT_WIDTH_HEIGHT_OF_CANCEL_IMAGE 18

@implementation MooDing

- (UILabel *)alertText
{
    return _alertText;
}

- (BOOL)isVibrate
{
    return _vibrate;
}

- (void)setVibrate:(BOOL)vibrate
{
    _vibrate = vibrate;
}

- (void)setClickAction:(void (^)(void))clickAction
{
    _clickAction = clickAction;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mc = [MooCommon getInstance];
        [self initialize];
        [self setHidden:YES];
        _vibrate = YES;
    }
    return self;
}

- (void)initialize
{
    UIImageView *alertImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, DEFAULT_HEIGHT / 2 - DEFAULT_WIDTH_HEIGHT_OF_ALERT_IMAGE / 2, DEFAULT_WIDTH_HEIGHT_OF_ALERT_IMAGE, DEFAULT_WIDTH_HEIGHT_OF_ALERT_IMAGE)];
    [alertImage setImage:[UIImage imageNamed:@"icon_news"]];
    
    _alertText = [[UILabel alloc] initWithFrame:CGRectMake(15 + DEFAULT_WIDTH_HEIGHT_OF_ALERT_IMAGE + 6, 0, [UIScreen mainScreen].bounds.size.width - DEFAULT_LEFT_RIGHT_MARGIN * 2 - 15 - DEFAULT_WIDTH_HEIGHT_OF_ALERT_IMAGE - 6 - 24, DEFAULT_HEIGHT)];
    [_alertText setTextColor:[UIColor whiteColor]];
    [_alertText setFont:[UIFont systemFontOfSize:12]];
    _alertText.text = @"消息初始化中...";
    
    UIImageView *cancelImage = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - DEFAULT_LEFT_RIGHT_MARGIN * 2 - 12 - DEFAULT_WIDTH_HEIGHT_OF_CANCEL_IMAGE, alertImage.frame.origin.y, DEFAULT_WIDTH_HEIGHT_OF_CANCEL_IMAGE, DEFAULT_WIDTH_HEIGHT_OF_CANCEL_IMAGE)];
    [cancelImage setImage:[UIImage imageNamed:@"icon_news_cancel"]];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - DEFAULT_LEFT_RIGHT_MARGIN * 2 - 12 - DEFAULT_WIDTH_HEIGHT_OF_CANCEL_IMAGE, 0, DEFAULT_WIDTH_HEIGHT_OF_CANCEL_IMAGE + 12, DEFAULT_HEIGHT)];
    [cancelButton addTarget:self action:@selector(delay) forControlEvents:UIControlEventTouchUpInside];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - DEFAULT_LEFT_RIGHT_MARGIN * 2, DEFAULT_HEIGHT) cornerRadius:5];
    
    [layer setPath:path.CGPath];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - DEFAULT_LEFT_RIGHT_MARGIN * 2 - DEFAULT_WIDTH_HEIGHT_OF_CANCEL_IMAGE - 12, DEFAULT_HEIGHT)];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setFrame:CGRectMake(DEFAULT_LEFT_RIGHT_MARGIN, DEFAULT_TOP_MARGIN, [UIScreen mainScreen].bounds.size.width - DEFAULT_LEFT_RIGHT_MARGIN * 2, DEFAULT_HEIGHT)];
//    [self setBackgroundColor:[_mc colorFromRGBA:0xfa913e withAlphaValue:1]];
    
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [cover setBackgroundColor:[UIColor blackColor]];
    [cover setAlpha:0.5f];
    [cover.layer setMask:layer];
    
    _originCenter = self.center;
    
    [self addSubview:cover];
    [self addSubview:alertImage];
    [self addSubview:cancelImage];
    [self addSubview:cancelButton];
    [self addSubview:_alertText];
    [self addSubview:button];
}

- (void)ding
{
    [self setHidden:NO];
    [self setAlpha:0.f];
    [self setCenter:CGPointMake(self.center.x, self.center.y - DEFAULT_HEIGHT - DEFAULT_TOP_MARGIN)];
    
    if (_vibrate) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:1.f];
        [self setCenter:_originCenter];
        
    } completion:^(BOOL finished) {
        _timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(delay) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }];
}

- (void)delay
{
    [_timer invalidate];
    [self disappear];
}

- (void)disappear
{
    [self setAlpha:1.f];
    [self setCenter:_originCenter];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:0.f];
        [self setCenter:CGPointMake(self.center.x, self.center.y - DEFAULT_HEIGHT - DEFAULT_TOP_MARGIN)];
        
    } completion:^(BOOL finished) {
        [self setHidden:YES];
        [self removeFromSuperview];
    }];
}

- (IBAction)click:(id)sender
{
    if (_clickAction != nil) {
        _clickAction();
        [self disappear];
    }
}

@end
