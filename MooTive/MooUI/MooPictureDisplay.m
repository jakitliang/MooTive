//
//  MooPictureDisplay.m
//  Created by Jakit on 16/8/12.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooPictureDisplay.h"
#import "MooZoomPicture.h"

@implementation MooPictureDisplay

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (MooPictureDisplay *)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat widthOflblPage = 162;
        CGFloat heightOflblPage = 18;
        
        [self setBackgroundColor:[UIColor blackColor]];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [self addGestureRecognizer:tapGesture];
        
        lblPage = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - widthOflblPage / 2, 33, widthOflblPage, heightOflblPage)];
        [lblPage setFont:[UIFont boldSystemFontOfSize:18]];
        [lblPage setTextColor:[UIColor whiteColor]];
        [lblPage setTextAlignment:NSTextAlignmentCenter];
        
        mc = [MooCommon getInstance];
        
        [self setPagingEnabled:YES];
        [self setDelegate:self];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
    }
    return self;
}

- (void)loadImagesWithURLs:(NSMutableArray *)URLs {
    numberOfPages = 0;
    
    [self.superview addSubview:lblPage];
//    UIView *color = [[UIView alloc] initWithFrame:self.frame];
//    [color setBackgroundColor:[UIColor blueColor]];
//    [self.superview addSubview:color];
    
    for (NSString *URL in URLs) {
        MooZoomPicture *picture = [[MooZoomPicture alloc] initWithFrame:CGRectMake(numberOfPages * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
//        [picture setBackgroundColor:[UIColor colorWithRed:0.5 green:(double)(i + 1) / 10 blue:(double)(i + 1) / 10 alpha:1]];
        [picture loadImageWithURL:URL];
        
        [self addSubview:picture];
        
        numberOfPages++;
    }
    
    lblPage.text = [NSString stringWithFormat:@"1 / %ld", (long)numberOfPages];
    
    [self setContentSize:CGSizeMake(numberOfPages * self.frame.size.width, 0)];
}

- (void)onTap:(UITapGestureRecognizer *)tapGesture {
    [lblPage removeFromSuperview];
    [self removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    lblPage.text = [NSString stringWithFormat:@"%ld / %ld", (long)(self.contentOffset.x / self.frame.size.width) + 1, (long)numberOfPages];
}

- (void)setCurrentPicture:(NSInteger)currentPicture {
    [self setContentOffset:CGPointMake(self.frame.size.width * currentPicture, 0)];
}

@end
