//
//  MooPage.m
//  Created by Jakit on 16/8/3.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooPage.h"

@implementation MooPage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setCurrentPage:(NSInteger)currentPage {
    UIView *item = self.subviews[currentPage];
    if (!isAnimating && currentPage != self.currentPage) {
//        NSLog(@"start Anime");
        CGRect origFrame = item.frame;
        [item setFrame:CGRectMake(item.frame.origin.x + 2, item.frame.origin.y + 2, item.frame.size.width - 4, item.frame.size.height - 4)];
        [UIView animateWithDuration:0.5 animations:^{
            [item setFrame:origFrame];
        }];
    }
    
    [super setCurrentPage:currentPage];
}

@end
