//
//  MooCalendar.m
//  MooCalendar
//  Created by Jakit on 16/11/21.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooCalendar.h"
#import "MooCalendarCell.h"
#import "MooCalendarBody.h"

#define defaultPaddingHorizontal 20
#define defaultWidth [UIScreen mainScreen].bounds.size.width - defaultPaddingHorizontal * 2
#define defaultPaddingHorizontalOfFrame 5
#define defaultPaddingVerticalOfFrame 10
#define defaultMarginVertical 12
#define defaultHeightOfWeekdays 26
#define defaultWidthOfCell ([UIScreen mainScreen].bounds.size.width - defaultPaddingHorizontal * 2) / 7
#define defaultHeightOfCell 40
#define defaultEdgeLengthOfTile 34

@interface MooCalendar() <UICollectionViewDelegate, UICollectionViewDataSource, MooCalendarBodyDelegate>
{
    @private
    UIView *_header;
    MooCalendarBody *_calendar;
    
    NSUInteger _cellCount;
    NSUInteger _rowCount;
    NSUInteger _days;
    NSUInteger _foreDays;
    
    NSInteger _currentYear;
    NSInteger _currentMonth;
    NSInteger _today;
    
    CAShapeLayer *_selectLayer;
    CAShapeLayer *_selectMaskLayer;
    CGRect _originFrameOfSelectedLayer;
}

@end

@implementation MooCalendar

- (MooCalendar *)initWithPosition:(CGPoint)position
{
    self = [super initWithFrame:CGRectMake(position.x, position.y, [UIScreen mainScreen].bounds.size.width, defaultMarginVertical * 2 + defaultHeightOfWeekdays + defaultPaddingVerticalOfFrame * 2 + 100)];
    if (self) {
        // Init header
        _header = [[UIView alloc] initWithFrame:CGRectMake(defaultPaddingHorizontal, defaultMarginVertical, defaultWidth, defaultHeightOfWeekdays)];
        
        // Init flow layout for collection view
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(defaultWidthOfCell, defaultHeightOfCell)];
        [layout setHeaderReferenceSize:CGSizeZero];
        [layout setMinimumInteritemSpacing:0];
        [layout setMinimumLineSpacing:0];
        
        // Init collection view calendar
        _calendar = [[MooCalendarBody alloc] initWithFrame:CGRectMake(defaultPaddingHorizontal, defaultMarginVertical + defaultHeightOfWeekdays + defaultPaddingVerticalOfFrame, defaultWidth, 0) collectionViewLayout:layout];
        [_calendar registerClass:[MooCalendarCell class] forCellWithReuseIdentifier:@"MooCalendarCell"];
        [_calendar setDelegate:self];
        [_calendar setDataSource:self];
        [_calendar setMooCalendarBodyDelegate:self];
        
        // Init vars
        _cellCount = 0;
        _rowCount = 0;
        _days = 0;
        _foreDays = 0;
        
        // Init properties
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
        
        self.year = (NSUInteger)components.year;
        self.month = (NSUInteger)components.month;
        self.day = (NSUInteger)components.day;
        
        _currentYear = components.year;
        _currentMonth = components.month;
        _today = components.day;
        
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Init header
    _header = [[UIView alloc] initWithFrame:CGRectMake(defaultPaddingHorizontal, defaultMarginVertical, defaultWidth, defaultHeightOfWeekdays)];
    
    // Init flow layout for collection view
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(defaultWidthOfCell, defaultHeightOfCell)];
    [layout setHeaderReferenceSize:CGSizeZero];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:0];
    
    // Init collection view calendar
    _calendar = [[MooCalendarBody alloc] initWithFrame:CGRectMake(defaultPaddingHorizontal, defaultMarginVertical + defaultHeightOfWeekdays + defaultPaddingVerticalOfFrame, defaultWidth, 0) collectionViewLayout:layout];
    [_calendar registerClass:[MooCalendarCell class] forCellWithReuseIdentifier:@"MooCalendarCell"];
    [_calendar setDelegate:self];
    [_calendar setDataSource:self];
    [_calendar setMooCalendarBodyDelegate:self];
    
    // Init vars
    _cellCount = 0;
    _rowCount = 0;
    _days = 0;
    _foreDays = 0;
    
    // Init properties
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    self.year = (NSUInteger)components.year;
    self.month = (NSUInteger)components.month;
    self.day = (NSUInteger)components.day;
    
    _currentYear = components.year;
    _currentMonth = components.month;
    _today = components.day;
    
    [self initialize];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self selectMonth];
}

- (void)initialize
{
    // Init weekdays for header
    NSArray *weekdays = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
    for (int i = 0; i < [weekdays count]; i++) {
        UILabel *weekdaysLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * defaultWidthOfCell, 0, defaultWidthOfCell, defaultHeightOfWeekdays)];
        [weekdaysLabel setFont:[UIFont systemFontOfSize:14]];
        [weekdaysLabel setTextColor:[self colorFromRGBA:0xa4a4a4 withAlphaValue:1]];
        [weekdaysLabel setTextAlignment:NSTextAlignmentCenter];
        weekdaysLabel.text = weekdays[i];
        [_header addSubview:weekdaysLabel];
    }
    
    [self addSubview:_header];
    
    [_calendar setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:_calendar];
    
    _selectLayer = [CAShapeLayer layer];
    
    _originFrameOfSelectedLayer = CGRectMake(defaultPaddingHorizontal - defaultPaddingHorizontalOfFrame, _calendar.frame.origin.y - defaultPaddingVerticalOfFrame, defaultWidth + defaultPaddingHorizontalOfFrame * 2, defaultPaddingVerticalOfFrame * 2);
    
    [_selectLayer setFrame:_originFrameOfSelectedLayer];
    [_selectLayer setBackgroundColor:[self colorFromRGBA:0xfc913a withAlphaValue:1].CGColor];
    
    _selectMaskLayer = [CAShapeLayer layer];
    [_selectMaskLayer setFrame:CGRectMake(0, 0, _selectLayer.frame.size.width, _selectLayer.frame.size.height)];
    [_selectMaskLayer setFillRule:kCAFillRuleEvenOdd];
    
    [self.layer addSublayer:_selectLayer];
    
    // Refresh calendar
    [self updateCalendar];
}

- (void)updateCalendar {
    if (self.year > 2000 && self.year < 2036 && self.month > 0 && self.month < 13 && self.day > 0 && self.day < 32) {
        [self countNumbers];
        
        [_calendar reloadSections:[NSIndexSet indexSetWithIndex:0]];
        
        // Resize calendar
        [_calendar setFrame:CGRectMake(_calendar.frame.origin.x, _calendar.frame.origin.y, _calendar.frame.size.width, defaultHeightOfCell * _rowCount)];
        
        // Resize the frame of self
        CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, defaultMarginVertical * 2 + defaultHeightOfWeekdays + defaultPaddingVerticalOfFrame * 2 + defaultHeightOfCell * _rowCount);
        [self setFrame:newFrame];
        [self setCurrentFrame:newFrame];
        
        // Resize select layer
        [_selectLayer setFrame:CGRectMake(_originFrameOfSelectedLayer.origin.x, _originFrameOfSelectedLayer.origin.y, _originFrameOfSelectedLayer.size.width, _originFrameOfSelectedLayer.size.height + defaultHeightOfCell * _rowCount)];
        
        // Resize select mask layer
        [_selectMaskLayer setFrame:CGRectMake(0, 0, _selectLayer.frame.size.width, _selectLayer.frame.size.height)];
        
        UIBezierPath *originPath = [UIBezierPath bezierPathWithRect:_selectMaskLayer.frame];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:CGRectMake(1, 1, _selectLayer.frame.size.width - 2, _selectLayer.frame.size.height - 2)];
        
        [originPath appendPath:maskPath];
        [originPath setUsesEvenOddFillRule:YES];
        
        [_selectMaskLayer setPath:originPath.CGPath];
        
        [_selectLayer setMask:_selectMaskLayer];
        
        if (self.delegate != nil) {
            if ([self.delegate respondsToSelector:@selector(mooCalendarResize:)]) {
                [self.delegate mooCalendarResize:self.frame.size];
            }
        }
    }
}

- (void)countNumbers {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-01"];
    
    NSDate *time = [fmt dateFromString:[NSString stringWithFormat:@"%lu-%lu-01", (unsigned long)self.year, (unsigned long)self.month]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Get days of month
    NSRange daysRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:time];
    _days = daysRange.length;
    
    // Get first weekday of month
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:time];
    NSUInteger weekday = components.weekday;
    
    // Count fore days
    _foreDays = 0;
    if (weekday != 1) {
        if (weekday > 1) {
            _foreDays = weekday - 2;
        }
        
    } else if (weekday == 1) {
        _foreDays = 6;
    }
    
    _cellCount = _foreDays + _days;
    _rowCount = (unsigned long)ceil(_cellCount / 7.f);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MooCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MooCalendarCell" forIndexPath:indexPath];
    
    NSInteger dayOfCell = indexPath.item - _foreDays + 1;
    
    if (dayOfCell > 0) {
        cell.day.text = [NSString stringWithFormat:@"%ld", (long)dayOfCell];
        
        if (self.year > _currentYear) {
            [cell setDayStyle:MooCalendarCellNormal];
            
        } else if (self.year == _currentYear) {
            if (self.month > _currentMonth) {
                // Day after this month
                [cell setDayStyle:MooCalendarCellNormal];
                
            } else if (self.month == _currentMonth) {
                // Day in this month
                if (dayOfCell == _today) {
                    [cell setDayStyle:MooCalendarCellToday];
                    
                } else if (dayOfCell > _today) {
                    [cell setDayStyle:MooCalendarCellNormal];
                    
                } else {
                    [cell setDayStyle:MooCalendarCellPassed];
                }
                
            } else {
                [cell setDayStyle:MooCalendarCellPassed];
            }
            
        } else {
            [cell setDayStyle:MooCalendarCellPassed];
        }
        
        if (self.underlinedDays != nil) {
            if ([self.underlinedDays indexOfObject:@(dayOfCell)] != NSNotFound) {
                [cell setUnderline:YES];
                
            } else {
                [cell setUnderline:NO];
            }
            
        } else {
            [cell setUnderline:NO];
        }
        
    } else {
        cell.day.text = @"";
        [cell setDayStyle:MooCalendarCellNormal];
        [cell setUnderline:NO];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
#ifdef DEBUG
    NSLog(@"%lu", (long)indexPath.item);
#endif
    
    NSInteger dayOfCell = indexPath.item - _foreDays + 1;
    
    if (dayOfCell > 0) {
        MooCalendarCell *cell = (MooCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        // Resize select layer
        [_selectLayer setFrame:CGRectMake(_originFrameOfSelectedLayer.origin.x + defaultPaddingHorizontalOfFrame + cell.frame.origin.x + (defaultWidthOfCell - defaultEdgeLengthOfTile) / 2, _originFrameOfSelectedLayer.origin.y + defaultPaddingVerticalOfFrame + cell.frame.origin.y + (defaultHeightOfCell - defaultEdgeLengthOfTile) / 2, defaultEdgeLengthOfTile, defaultEdgeLengthOfTile)];
        
        // Resize select mask layer
        [_selectMaskLayer setFrame:CGRectMake(0, 0, defaultEdgeLengthOfTile, defaultEdgeLengthOfTile)];
        
        UIBezierPath *originPath = [UIBezierPath bezierPathWithRect:_selectMaskLayer.frame];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:CGRectMake(1, 1, _selectLayer.frame.size.width - 2, _selectLayer.frame.size.height - 2)];
        
        [originPath appendPath:maskPath];
        [originPath setUsesEvenOddFillRule:YES];
        
        [_selectMaskLayer setPath:originPath.CGPath];
        
        [_selectLayer setMask:_selectMaskLayer];
        
        // Callback
        if (self.delegate != nil) {
            if ([self.delegate respondsToSelector:@selector(mooCalendarChangeFrom:to:)]) {
                NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                [fmt setDateFormat:@"yyyy-MM-dd"];
                
                NSDate *startTime = [fmt dateFromString:[NSString stringWithFormat:@"%lu-%lu-%lu", (unsigned long)self.year, (unsigned long)self.month, (unsigned long)dayOfCell]];
                
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:startTime];
                [components setDay:components.day + 1];
                
                NSDate *endTime = [calendar dateFromComponents:components];
                
                [self.delegate mooCalendarChangeFrom:startTime.timeIntervalSince1970 to:endTime.timeIntervalSince1970];
            }
        }
        
    } else {
        [self selectMonth];
    }
}

- (void)selectMonth {
    // Resize select layer
    [_selectLayer setFrame:CGRectMake(_originFrameOfSelectedLayer.origin.x, _originFrameOfSelectedLayer.origin.y, _originFrameOfSelectedLayer.size.width, _originFrameOfSelectedLayer.size.height + defaultHeightOfCell * _rowCount)];
    
    // Resize select mask layer
    [_selectMaskLayer setFrame:CGRectMake(0, 0, _selectLayer.frame.size.width, _selectLayer.frame.size.height)];
    
    UIBezierPath *originPath = [UIBezierPath bezierPathWithRect:_selectMaskLayer.frame];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:CGRectMake(1, 1, _selectLayer.frame.size.width - 2, _selectLayer.frame.size.height - 2)];
    
    [originPath appendPath:maskPath];
    [originPath setUsesEvenOddFillRule:YES];
    
    [_selectMaskLayer setPath:originPath.CGPath];
    
    [_selectLayer setMask:_selectMaskLayer];
    
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(mooCalendarChangeFrom:to:)]) {
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            [fmt setDateFormat:@"yyyy-MM-01"];
            
            NSDate *startTime = [fmt dateFromString:[NSString stringWithFormat:@"%lu-%lu-01", (unsigned long)self.year, (unsigned long)self.month]];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:startTime];
            [components setMonth:components.month + 1];
            
            NSDate *endTime = [calendar dateFromComponents:components];
            
            [self.delegate mooCalendarChangeFrom:startTime.timeIntervalSince1970 to:endTime.timeIntervalSince1970];
        }
    }
}

- (void)touchesOnSpace {
    [self selectMonth];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIColor *)colorFromRGBA:(int)rgbValue withAlphaValue:(float)alphaValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue];
}

@end
