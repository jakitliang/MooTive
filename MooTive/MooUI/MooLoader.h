//
//  MooLoader.h
//  Created by Jakit on 16/6/30.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MooCommon.h"

typedef enum {
    MooLoaderOnDrag,
    MooLoaderOnLoad,
    MooLoaderOnFinished
} MooLoaderStatus;

@interface MooLoader : UIView
{
    @private
    MooCommon *mc;
}

@property NSString *readyText;
@property NSString *loadingText;
@property (nonatomic, weak) UIColor *textColor;
@property NSString *dragText;
@property MooLoaderStatus status;
@property UILabel *lblLoading;

- (MooLoader *)init;
- (void)startDrag;
- (void)startLoading:(void (^)(void))completion;
- (void)endLoading;

@end
