//
//  MooPictureDisplay.h
//  Created by Jakit on 16/8/12.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MooCommon.h"

@interface MooPictureDisplay : UIScrollView <UIScrollViewDelegate>
{
    UILabel *lblPage;
    NSInteger numberOfPages;
    MooCommon *mc;
}

- (MooPictureDisplay *)initWithFrame:(CGRect)frame;

- (void)loadImagesWithURLs:(NSArray *)URLs;

- (void)setCurrentPicture:(NSInteger)currentPicture;

@end
