//
//  MooCalendar.h
//  MooCalendar
//  Created by Jakit on 16/11/21.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MooCalendarDelegate;

@interface MooCalendar : UIView

@property NSUInteger year;
@property NSUInteger month;
@property NSUInteger day;

@property NSArray *underlinedDays;

@property (nonatomic, weak) id<MooCalendarDelegate> delegate;

@property CGRect currentFrame;

- (MooCalendar *)initWithPosition:(CGPoint)position;

- (void)updateCalendar;

@end

@protocol MooCalendarDelegate <NSObject>

@optional

- (void)mooCalendarResize:(CGSize)size;

- (void)mooCalendarChangeFrom:(NSTimeInterval)begin to:(NSTimeInterval)end;

- (void)mooCalendarSelectDate:(NSDateComponents *)date;

@end
