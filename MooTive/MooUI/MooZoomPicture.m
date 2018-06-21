//
//  MooZoomPicture.m
//  Created by Jakit on 16/8/17.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooZoomPicture.h"

@implementation MooZoomPicture

- (MooZoomPicture *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    web = [[MooWeb alloc] init];
    wait = [[MooWait alloc] init];
    
    [self addSubview:wait];
    [self setDelegate:self];
    [self setMinimumZoomScale:1.f];
    [self setMaximumZoomScale:3.f];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)loadImage:(UIImage *)img {
    [image setImage:img];
}

- (void)loadImageWithURL:(NSString *)URL {
    [wait startAnimating];
    
    [web curl:URL withMethod:@"GET" withParam:nil completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            UIImage *picture = [UIImage imageWithData:data];
            CGRect imageFrame;
            
            if (picture.size.width > picture.size.height || picture.size.width > [UIScreen mainScreen].bounds.size.width) {
                CGFloat widthOfPicture = [UIScreen mainScreen].bounds.size.width;
                CGFloat heightOfPicture = picture.size.height / picture.size.width * widthOfPicture;
                imageFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2 - heightOfPicture / 2, widthOfPicture, heightOfPicture);
                
            } else {
                CGFloat heightOfPicture = [UIScreen mainScreen].bounds.size.height;
                CGFloat widthOfPicture = picture.size.width / picture.size.height * heightOfPicture;
                imageFrame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - widthOfPicture / 2, 0, widthOfPicture, heightOfPicture);
            }
            
            image = [[UIImageView alloc] initWithFrame:imageFrame];
            [image setImage:picture];
            [image setContentMode:UIViewContentModeScaleAspectFit];
            
            [self addSubview:image];
            [self setContentSize:image.frame.size];
            
        } else {
#ifdef DEBUG
            NSLog(@"Error Loading Image: %@", connectionError.description);
#endif
        }
        
        [wait stopAnimating];
    }];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.contentSize.width > scrollView.bounds.size.width) ? 0 : (scrollView.bounds.size.width - scrollView.contentSize.width) / 2;
    CGFloat offsetY = (scrollView.contentSize.height > scrollView.bounds.size.height) ? 0 : (scrollView.bounds.size.height - scrollView.contentSize.height) / 2;
    [image setCenter:CGPointMake(scrollView.contentSize.width / 2 + offsetX, scrollView.contentSize.height / 2 + offsetY)];
}

@end
