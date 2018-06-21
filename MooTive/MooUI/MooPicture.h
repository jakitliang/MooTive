//
//  MooPicture.h
//  Created by Jakit on 16/7/19.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MooWeb.h"
#import "MooWait.h"

@interface MooPicture : UIView
{
    @private
    UIImageView *imgvPicture;
    CGAffineTransform origTransform;
    MooWeb *mWeb;
    MooWait *wait;
    CGPoint lastLocation;
}

- (instancetype)initWithFrame:(CGRect)frame;

- (MooPicture *)initWithFrame:(CGRect)frame withImage:(UIImage *)image;

- (void)setImage:(UIImage *)image;

- (void)loadImageWithURL:(NSString *)URL;

- (void)loadImageWithURL:(NSString *)URL withDefaultImage:(UIImage *)image;

@end
