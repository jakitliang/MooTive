//
//  MooCalendarBody.m
//  MooCalendar
//  Created by Jakit on 16/11/28.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooCalendarBody.h"
#import "MooCalendarCell.h"

@implementation MooCalendarBody

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if (self.mooCalendarBodyDelegate != nil) {
        if ([self.mooCalendarBodyDelegate respondsToSelector:@selector(touchesOnSpace)]) {
            if (![self hasCellOnPosition:[[touches anyObject] locationInView:self]]) {
                [self.mooCalendarBodyDelegate touchesOnSpace];
            }
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

- (BOOL)hasCellOnPosition:(CGPoint)position
{
    for (id subview in self.subviews) {
        if ([subview isKindOfClass:[MooCalendarCell class]]) {
            MooCalendarCell *cell = (MooCalendarCell *)subview;
            
            if (position.x >= cell.frame.origin.x
                && position.y >= cell.frame.origin.y
                && position.x <= cell.frame.origin.x + cell.frame.size.width
                && position.y <= cell.frame.origin.y + cell.frame.size.height) {
                return YES;
            }
        }
    }
    
    return NO;
}

@end
