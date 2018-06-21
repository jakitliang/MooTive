//
//  MooCalendarCell.h
//
//  Created by Jakit on 16/11/23.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MooCalendarCellNormal,
    MooCalendarCellToday,
    MooCalendarCellPassed
} MooCalendarCellStyle;

@interface MooCalendarCell : UICollectionViewCell

@property UILabel *day;

- (MooCalendarCellStyle)dayStyle;

- (void)setDayStyle:(MooCalendarCellStyle)style;

- (void)setUnderline:(BOOL)isUnderline;

@end
