//
//  MooCalendarBody.h
//  MooCalendar
//  Created by Jakit on 16/11/28.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MooCalendarBodyDelegate;

@interface MooCalendarBody : UICollectionView

@property (nonatomic, weak) id<MooCalendarBodyDelegate> mooCalendarBodyDelegate;

@end

@protocol MooCalendarBodyDelegate <NSObject>

@optional

- (void)touchesOnSpace;

@end
