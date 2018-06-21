//
//  MooLoader.m
//  Created by Jakit on 16/6/30.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooLoader.h"

@implementation MooLoader

- (MooLoader *)init
{
    self = [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 46)];
    return self;
}

- (MooLoader *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self.lblLoading setTextColor:textColor];
}

- (void)initialize {
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.lblLoading = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 4, 15.5, self.frame.size.width / 2, 15)];
    [self.lblLoading setBackgroundColor:[UIColor clearColor]];
    [self.lblLoading setTextAlignment:NSTextAlignmentCenter];
    [self.lblLoading setFont:[UIFont systemFontOfSize:15]];
    [self.lblLoading setTextColor:[mc colorFromRGBA:0x333333 withAlphaValue:1]];
    self.lblLoading.text = @"上拉加载更多";
    
    [self addSubview:self.lblLoading];
}

- (void)startDrag {
    self.lblLoading.text = @"松开加载更多";
    self.status = MooLoaderOnDrag;
}

- (void)startLoading:(void (^)(void))completion {
    self.lblLoading.text = @"正在加载中";
    self.status = MooLoaderOnLoad;
    completion();
}

- (void)endLoading {
    self.lblLoading.text = @"上拉加载更多";
    self.status = MooLoaderOnFinished;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
