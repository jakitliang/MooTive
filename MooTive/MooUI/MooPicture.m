//
//  MooPicture.m
//  Created by Jakit on 16/7/19.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooPicture.h"

@implementation MooPicture

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (MooPicture *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        mWeb = [[MooWeb alloc] init];
        wait = [[MooWait alloc] init];
        [self addSubview:wait];
        
        imgvPicture = [[UIImageView alloc] initWithFrame:frame];
        [imgvPicture setBackgroundColor:[UIColor colorWithRed:(double)(rand() % 10) / 10 green:(double)(rand() % 10) / 10 blue:(double)(rand() % 10) / 10 alpha:1]];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onScale:)];
        [imgvPicture addGestureRecognizer:pinchGesture];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onDrag:)];
        [imgvPicture addGestureRecognizer:panGesture];
        [imgvPicture setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [self addGestureRecognizer:tapGesture];
        
        [self addSubview:imgvPicture];
        
        origTransform = imgvPicture.transform;
    }
    return self;
}

- (MooPicture *)initWithFrame:(CGRect)frame withImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        mWeb = [[MooWeb alloc] init];
        wait = [[MooWait alloc] init];
        [self addSubview:wait];
        
        imgvPicture = [[UIImageView alloc] initWithFrame:frame];
        [imgvPicture setUserInteractionEnabled:YES];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onScale:)];
        [imgvPicture addGestureRecognizer:pinchGesture];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onDrag:)];
        [imgvPicture addGestureRecognizer:panGesture];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [self addGestureRecognizer:tapGesture];
        
        [self addSubview:imgvPicture];
        
        [imgvPicture setImage:image];
        [imgvPicture setContentMode:UIViewContentModeScaleAspectFit];
        
        origTransform = imgvPicture.transform;
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    [imgvPicture setImage:image];
    [imgvPicture setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)loadImageWithURL:(NSString *)URL {
    [wait startAnimating];
    [mWeb curl:URL withMethod:@"GET" withParam:nil completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError == nil) {
            UIImage *picture = [UIImage imageWithData:data];
            [imgvPicture setImage:picture];
            [imgvPicture setContentMode:UIViewContentModeScaleAspectFit];
            
        } else {
#ifdef DEBUG
            NSLog(@"图片加载失败");
#endif
        }
        
        [wait stopAnimating];
    }];
}

- (void)loadImageWithURL:(NSString *)URL withDefaultImage:(UIImage *)image {
    [wait startAnimating];
    [mWeb curl:URL withMethod:@"GET" withParam:nil completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
#ifdef DEBUG
            NSLog(@"图片加载失败");
#endif
            [imgvPicture setImage:image];
            
        } else {
            UIImage *picture = [UIImage imageWithData:data];
            [imgvPicture setImage:picture];
        }
        
        [imgvPicture setContentMode:UIViewContentModeScaleAspectFit];
        [wait stopAnimating];
    }];
}

- (void)onScale:(UIPinchGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (sender.view.frame.size.width < sender.view.superview.frame.size.width || sender.view.frame.size.height < sender.view.superview.frame.size.height) {
            [sender.view setTransform:origTransform];
            [sender.view setCenter:self.superview.center];
        }
    }
    
    [sender.view setTransform:CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale)];
    [sender setScale:1];
}

- (void)onDrag:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:sender.view.superview];
    [sender.view setCenter:CGPointMake(sender.view.center.x + translation.x, sender.view.center.y + translation.y)];
    [sender setTranslation:CGPointZero inView:sender.view.superview];
}

- (void)onTap:(UITapGestureRecognizer *)sender {
    [self removeFromSuperview];
}

@end
