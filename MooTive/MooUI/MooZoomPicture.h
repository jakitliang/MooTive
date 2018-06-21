//
//  MooZoomPicture.h
//  Created by Jakit on 16/8/17.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MooWait.h"
#import "MooWeb.h"

@interface MooZoomPicture : UIScrollView <UIScrollViewDelegate>
{
    @private
    UIImageView *image;
    MooWait *wait;
    MooWeb *web;
}

- (MooZoomPicture *)initWithFrame:(CGRect)frame;

- (void)loadImage:(UIImage *)img;

- (void)loadImageWithURL:(NSString *)URL;

@end
