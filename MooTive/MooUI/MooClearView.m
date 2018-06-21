//
//  MooClearView.m
//  Created by Jakit on 16/8/2.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooClearView.h"

@implementation MooClearView

- (MooClearView *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
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
