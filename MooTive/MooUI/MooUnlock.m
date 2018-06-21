//
//  MooUnlock.m
//  Created by Jakit on 16/9/23.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooUnlock.h"
#import "MooUnlockButton.h"

#define DEFAULT_Y_OFFSET 0.57
#define DEFAULT_BUTTON_WIDTH 67
#define DEFAULT_BUTTON_HEIGHT 67
#define DEFAULT_MUTIPLIER 30 / 640

@implementation MooUnlock

- (instancetype)initWithButtonImages:(NSDictionary *)images
{
    _width = _height = [UIScreen mainScreen].bounds.size.width;
    
    self = [super initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height * DEFAULT_Y_OFFSET - _height / 2, _width, _height)];
    if (self) {
        _buttonImages = images;
        _drawLayer = [CAShapeLayer layer];
        _drawPath = [UIBezierPath bezierPath];
        _mc = [MooCommon getInstance];
        self.lineColor = [UIColor whiteColor];
        
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.buttons = [[NSMutableArray alloc] init];
    self.markedOrder = [[NSMutableArray alloc] init];
    
    int count = 1;
    CGFloat margin = _width * (double)DEFAULT_MUTIPLIER;
    CGFloat sideLength = (_width - margin * 2) / 3;
    
//    NSLog(@"%f", _width);
//    NSLog(@"%f", sideLength);
//    NSLog(@"%f", _width * DEFAULT_MUTIPLIER);
//    NSLog(@"%f", (double)DEFAULT_MUTIPLIER);
    
    [_drawLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_drawLayer setFillColor:self.lineColor.CGColor];
    [_drawLayer setStrokeColor:self.lineColor.CGColor];
    [_drawLayer setLineWidth:7.0f];
    [self.layer addSublayer:_drawLayer];
    
    [_drawPath setLineWidth:7.0f];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    [maskLayer setFillColor:[UIColor blueColor].CGColor];
    [maskLayer setStrokeColor:[UIColor blueColor].CGColor];
    [maskLayer setFrame:_drawLayer.frame];
    NSLog(@"%f", maskLayer.frame.size.width);
    [maskLayer setLineWidth:0.0f];
    
    UIBezierPath *maskPathA = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UIBezierPath *maskPathB = [UIBezierPath bezierPath];
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            CGRect frameOfButton = CGRectMake(j * sideLength + sideLength / 2 - DEFAULT_BUTTON_WIDTH / 2 + margin, i * sideLength + sideLength / 2 - DEFAULT_BUTTON_HEIGHT / 2, DEFAULT_BUTTON_WIDTH, DEFAULT_BUTTON_HEIGHT);
            MooUnlockButton *button = [[MooUnlockButton alloc] initWithFrame:frameOfButton];
            
            [button setPosition:MooUnlockButtonPositionMake(i, j)];
            [button setPositionID:count];
            [button setNormalStateImage:[_buttonImages objectForKey:@"normal"]];
            [button setSelectedStateImage:[_buttonImages objectForKey:@"selected"]];
            [button setErrorStateImage:[_buttonImages objectForKey:@"error"]];
            
            [button setBackgroundImage:[_buttonImages objectForKey:@"normal"] forState:UIControlStateNormal];
            
            [self addSubview:button];
            [self.buttons addObject:button];
            
            [maskPathB moveToPoint:button.center];
            [maskPathB addArcWithCenter:button.center radius:DEFAULT_BUTTON_WIDTH / 2 startAngle:[_mc getRadian:0.f] endAngle:[_mc getRadian:0.01f] clockwise:NO];
            
            count++;
        }
    }
    
    [maskPathA appendPath:maskPathB];
    [maskPathA setUsesEvenOddFillRule:YES];
    [maskPathA addClip];
    [maskLayer setPath:maskPathA.CGPath];
    
    [_drawLayer setMask:maskLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touches began");
    MooUnlockButton *unlockButton;
    
    [self resetMarkedButtons];
    
    unlockButton = [self searchButtonWithPosition:[[touches anyObject] locationInView:self]];
    
    if (unlockButton != nil) {
        [self markButton:unlockButton];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touches moved");
    MooUnlockButton *unlockButton;
    
    unlockButton = [self searchButtonWithPosition:[[touches anyObject] locationInView:self]];
    
    if (unlockButton != nil) {
        [self markButton:unlockButton];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touches ended");
//    NSLog(@"%@", self.markedOrder);
    
    if ([self.mooUnlockDelegate respondsToSelector:@selector(getUnlockMap:)]) {
        [self.mooUnlockDelegate getUnlockMap:self.markedOrder];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (MooUnlockButton *)searchButtonWithPosition:(CGPoint)position {
    MooUnlockButton *foundButton;
    
    for (MooUnlockButton *button in self.buttons) {
        if (position.x > button.frame.origin.x && position.x < button.frame.origin.x + button.frame.size.width
            && position.y > button.frame.origin.y && position.y < button.frame.origin.y + button.frame.size.height) {
            foundButton = button;
        }
    }
    
    return foundButton;
}

- (void)markButton:(MooUnlockButton *)button {
    if (![button isMarked]) {
        if ([self.markedOrder count] > 0) {
            int lastObjectID = [[self.markedOrder lastObject] intValue] - 1;
            MooUnlockButton *lastMarkedButton = (MooUnlockButton *)self.buttons[lastObjectID];
            
            [_drawPath moveToPoint:lastMarkedButton.center];
            [_drawPath addLineToPoint:button.center];
            [_drawLayer setPath:_drawPath.CGPath];
        }
        
        [button setMarked:YES];
        [self.markedOrder addObject:@(button.positionID)];
    }
}

- (void)resetMarkedButtons {
    for (MooUnlockButton *button in self.buttons) {
        [button reset];
    }
    
    [self.markedOrder removeAllObjects];
    
    // Cleaning draw path
    _drawPath = [UIBezierPath bezierPath];
    [_drawLayer setPath:_drawPath.CGPath];
    [_drawLayer setFillColor:self.lineColor.CGColor];
    [_drawLayer setStrokeColor:self.lineColor.CGColor];
}

- (void)highlightButtons {
    for (MooUnlockButton *button in self.buttons) {
        [button hilight];
    }
    
    [_drawLayer setFillColor:[_mc colorFromRGBA:0xf84b45 withAlphaValue:1].CGColor];
    [_drawLayer setStrokeColor:[_mc colorFromRGBA:0xf84b45 withAlphaValue:1].CGColor];
}

@end
