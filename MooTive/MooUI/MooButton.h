//
//  MooButton.h
//  Created by Jakit on 16/6/23.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MooButton : UIButton

@property int mid;
@property NSString *info;
@property id data;

@property UIImageView *iconImage;

@property UILabel *textLabel;

- (void)roundCornerRadius:(CGFloat)radius;

- (void)buttonWithIcon:(UIImage *)icon withText:(NSString *)text withFont:(UIFont *)font;

@end
