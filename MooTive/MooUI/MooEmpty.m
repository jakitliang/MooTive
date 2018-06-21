//
//  MooEmpty.m
//  Created by Jakit on 16/7/28.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooEmpty.h"

@implementation MooEmpty

- (MooEmpty *)init
{
    self = [super init];
    if (self) {
        width = height = 130;
        [self setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - width / 2, 40, width, height)];
        [self setBackgroundColor:[UIColor clearColor]];
        [self initialize];
        [self setHidden:YES];
    }
    return self;
}

- (void)initialize {
    imgvPicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [imgvPicture setBackgroundColor:[UIColor clearColor]];
    [self addSubview:imgvPicture];
}

- (void)setPictureWithImage:(UIImage *)image {
    [imgvPicture setImage:image];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
