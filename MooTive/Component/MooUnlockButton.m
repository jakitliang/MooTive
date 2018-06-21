//
//  MooUnlockButton.m
//  Created by Jakit on 16/9/23.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooUnlockButton.h"

#define DEFAULT_WIDTH 67
#define DEFAULT_HEIGHT 67

MooUnlockButtonPosition MooUnlockButtonPositionMake(NSUInteger x, NSUInteger y) {
    MooUnlockButtonPosition position;
    position.x = x;
    position.y = y;
    return position;
}

@implementation MooUnlockButton

- (instancetype)init
{
    _width = DEFAULT_WIDTH;
    _height = DEFAULT_HEIGHT;
    
    self = [super init];
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

- (void)initialize
{
    _marked = NO;
    [self setUserInteractionEnabled:NO];
}

- (BOOL)marked {
    return [self isMarked];
}

- (BOOL)isMarked {
    return _marked;
}

- (void)setMarked:(BOOL)marked {
    _marked = marked;
    
    if (marked) {
        [self setBackgroundImage:self.selectedStateImage forState:UIControlStateNormal];
        
    } else {
        [self setBackgroundImage:self.normalStateImage forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)reset {
    if (_marked) {
        [self setBackgroundImage:self.normalStateImage forState:UIControlStateNormal];
    }
    
    _marked = NO;
}

- (void)hilight {
    if (_marked) {
        [self setBackgroundImage:self.errorStateImage forState:UIControlStateNormal];
    }
}

@end
