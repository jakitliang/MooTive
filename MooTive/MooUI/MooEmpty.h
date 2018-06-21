//
//  MooEmpty.h
//  Created by Jakit on 16/7/28.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MooEmpty : UIView
{
    @private
    CGFloat width;
    CGFloat height;
    
    UIImageView *imgvPicture;
}

- (void)setPictureWithImage:(UIImage *)image;

@end
