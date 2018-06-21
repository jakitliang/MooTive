//
//  MooShare.h
//  Created by Jakit on 16/8/22.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MooShareMessage.h"

@interface MooShare : UIView
{
    @private
    UIView *shareList;
    UIButton *btnCancel;
    UIButton *btnCover;
    CGFloat width;
    CGFloat height;
    CGPoint origCenter;
}

@property MooShareMessage *shareMessage;

- (MooShare *)init;

- (MooShare *)initWithFrame:(CGRect)frame;

+ (MooShare *)share;

- (void)setVisible:(BOOL)visible;

@end
