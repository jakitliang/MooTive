//
//  MooSlider.h
//  Created by Jakit on 16/8/18.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MooSliderDelegate;

@interface MooSlider : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, weak) id<MooSliderDelegate> mooSliderDelegate;

- (MooSlider *)initWithFrame:(CGRect)frame;

@end

@protocol MooSliderDelegate <NSObject>

@optional

- (void)mooSliderTouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)mooSliderTouchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)mooSliderTouchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

- (void)mooSliderDidScroll:(MooSlider *)mooSlider;

- (void)mooSliderWillBeginDragging:(MooSlider *)mooSlider;
- (void)mooSliderWillEndDragging:(MooSlider *)mooSlider withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

@end
