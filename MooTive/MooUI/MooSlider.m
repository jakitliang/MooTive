//
//  MooSlider.m
//  Created by Jakit on 16/8/18.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooSlider.h"

@implementation MooSlider

- (MooSlider *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDelegate:self];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setDelegate:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.mooSliderDelegate respondsToSelector:@selector(mooSliderTouchesBegan:withEvent:)]) {
        [self.mooSliderDelegate mooSliderTouchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.mooSliderDelegate respondsToSelector:@selector(mooSliderTouchesMoved:withEvent:)]) {
        [self.mooSliderDelegate mooSliderTouchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.mooSliderDelegate respondsToSelector:@selector(mooSliderTouchesEnded:withEvent:)]) {
        [self.mooSliderDelegate mooSliderTouchesEnded:touches withEvent:event];
    }
}

- (void)scrollViewDidScroll:(MooSlider *)mooSlider {
    if ([self.mooSliderDelegate respondsToSelector:@selector(mooSliderDidScroll:)]) {
        [self.mooSliderDelegate mooSliderDidScroll:mooSlider];
    }
}

- (void)scrollViewWillBeginDragging:(MooSlider *)mooSlider {
    if ([self.mooSliderDelegate respondsToSelector:@selector(mooSliderWillBeginDragging:)]) {
        [self.mooSliderDelegate mooSliderWillBeginDragging:mooSlider];
    }
}

- (void)scrollViewWillEndDragging:(MooSlider *)mooSlider withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.mooSliderDelegate respondsToSelector:@selector(mooSliderWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.mooSliderDelegate mooSliderWillEndDragging:mooSlider withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)setContentOffset:(CGPoint)contentOffset completion:(void (^)(BOOL finished))completion {
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = contentOffset;
    } completion:completion];
}

@end
