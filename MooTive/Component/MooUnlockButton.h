//
//  MooUnlockButton.h
//  Created by Jakit on 16/9/23.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>

struct MooUnlockButtonPosition {
    NSUInteger x;
    NSUInteger y;
};

typedef struct MooUnlockButtonPosition MooUnlockButtonPosition;

MooUnlockButtonPosition MooUnlockButtonPositionMake(NSUInteger x, NSUInteger y);

@interface MooUnlockButton : UIButton
{
    @private
    CGFloat _width;
    CGFloat _height;
    BOOL _marked;
}

@property MooUnlockButtonPosition position;

@property NSUInteger positionID;

@property UIImage *normalStateImage;

@property UIImage *selectedStateImage;

@property UIImage *errorStateImage;

- (BOOL)marked;

- (BOOL)isMarked;

- (void)setMarked:(BOOL)marked;

- (void)reset;

- (void)hilight;

@end
