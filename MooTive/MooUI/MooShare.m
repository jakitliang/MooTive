//
//  MooShare.m
//  Created by Jakit on 16/8/22.
//  Copyright © 2016年 Jakit. All rights reserved.
//

#import "MooShare.h"
#import "MooCommon.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "../Frameworks/QQ/TencentOpenAPI.framework/Headers/QQApiInterface.h"
#import "../Frameworks/QQ/TencentOpenAPI.framework/Headers/QQApiInterfaceObject.h"

@interface MooShare()
{
    @private
    MooCommon *mc;
}

@end

@implementation MooShare

static MooShare *mooShare;

- (MooShare *)init
{
    width = [UIScreen mainScreen].bounds.size.width;
    height = 170;
    
    self = [self initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - height, width, height)];
    
    return self;
}

- (MooShare *)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

+ (MooShare *)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mooShare = [[MooShare alloc] init];
    });
    return mooShare;
}

- (void)initialize
{
    mc = [[MooCommon alloc] init];
    [self setBackgroundColor:[mc colorFromRGBA:0xdddddd withAlphaValue:1]];
    
    // Definition of Elements
    CGFloat widthOfButtonCancel = self.frame.size.width;
    CGFloat heightOfButtonCancel = 48;
    
    CGFloat heightOfSeparator = 1;
    
    CGFloat widthOfShareList = self.frame.size.width;
    CGFloat heightOfShareList = self.frame.size.height - heightOfButtonCancel - heightOfSeparator;
    
    CGFloat widthOfShareButton, heightOfShareButton;
    widthOfShareButton = heightOfShareButton = 52;
    
    // Init parent views
    shareList = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthOfShareList, heightOfShareList)];
    [shareList setBackgroundColor:[UIColor whiteColor]];
    
    btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, heightOfShareList + heightOfSeparator, widthOfButtonCancel, heightOfButtonCancel)];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setBackgroundImage:[mc imageWithColor:[UIColor whiteColor] withWidth:16 withHeight:16] forState:UIControlStateNormal];
    [btnCancel setBackgroundImage:[mc imageWithColor:[mc colorFromRGBA:0xf2f2f2 withAlphaValue:1] withWidth:16 withHeight:16] forState:UIControlStateHighlighted];
    [btnCancel setBackgroundImage:[mc imageWithColor:[mc colorFromRGBA:0xf2f2f2 withAlphaValue:1] withWidth:16 withHeight:16] forState:UIControlStateSelected];
    [btnCancel setTitleColor:[mc colorFromRGBA:0x333333 withAlphaValue:1] forState:UIControlStateNormal];
    [btnCancel.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [btnCancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:shareList];
    [self addSubview:btnCancel];
    
    btnCover = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [btnCover setBackgroundColor:[UIColor blackColor]];
    [btnCover addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    // Init sharing buttons
    UIButton *btnWeixin = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 8 - widthOfShareButton / 2, 23, widthOfShareButton, heightOfShareButton)];
    [btnWeixin setBackgroundImage:[UIImage imageNamed:@"icon_weixinhaoyou"] forState:UIControlStateNormal];
    [btnWeixin addTarget:self action:@selector(shareToWeixinFriendWithMessage) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lblWeixin = [[UILabel alloc] initWithFrame:CGRectMake(btnWeixin.center.x - 28, heightOfShareList - 23 - 14, 58, 14)];
    [lblWeixin setFont:[UIFont systemFontOfSize:14]];
    [lblWeixin setTextAlignment:NSTextAlignmentCenter];
    [lblWeixin setTextColor:[mc colorFromRGBA:0x333333 withAlphaValue:1]];
    lblWeixin.text = @"微信好友";
    
    UIButton *btnWeixinMoment = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 8 * 3 - widthOfShareButton / 2, 23, widthOfShareButton, heightOfShareButton)];
    [btnWeixinMoment setBackgroundImage:[UIImage imageNamed:@"icon_pengyouquan"] forState:UIControlStateNormal];
    [btnWeixinMoment addTarget:self action:@selector(shareToWeixinMomentWithMessage) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lblWeixinMoment = [[UILabel alloc] initWithFrame:CGRectMake(btnWeixinMoment.center.x - 28, heightOfShareList - 23 - 14, 56, 14)];
    [lblWeixinMoment setFont:[UIFont systemFontOfSize:14]];
    [lblWeixinMoment setTextAlignment:NSTextAlignmentCenter];
    [lblWeixinMoment setTextColor:[mc colorFromRGBA:0x333333 withAlphaValue:1]];
    lblWeixinMoment.text = @"朋友圈";
    
    UIButton *btnQQ = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 8 * 5 - widthOfShareButton / 2, 23, widthOfShareButton, heightOfShareButton)];
    [btnQQ setBackgroundImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateNormal];
    [btnQQ addTarget:self action:@selector(shareToQQFriendWithMessage) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lblQQ = [[UILabel alloc] initWithFrame:CGRectMake(btnQQ.center.x - 28, heightOfShareList - 23 - 14, 56, 14)];
    [lblQQ setFont:[UIFont systemFontOfSize:14]];
    [lblQQ setTextAlignment:NSTextAlignmentCenter];
    [lblQQ setTextColor:[mc colorFromRGBA:0x333333 withAlphaValue:1]];
    lblQQ.text = @"QQ好友";
    
    UIButton *btnQZone = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 8 * 7 - widthOfShareButton / 2, 23, widthOfShareButton, heightOfShareButton)];
    [btnQZone setBackgroundImage:[UIImage imageNamed:@"icon_qqzone"] forState:UIControlStateNormal];
    [btnQZone addTarget:self action:@selector(shareToQZoneWithMessage) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lblQZone = [[UILabel alloc] initWithFrame:CGRectMake(btnQZone.center.x - 28, heightOfShareList - 23 - 14, 56, 14)];
    [lblQZone setFont:[UIFont systemFontOfSize:14]];
    [lblQZone setTextAlignment:NSTextAlignmentCenter];
    [lblQZone setTextColor:[mc colorFromRGBA:0x333333 withAlphaValue:1]];
    lblQZone.text = @"QQ空间";
    
    [shareList addSubview:btnWeixin];
    [shareList addSubview:lblWeixin];
    [shareList addSubview:btnWeixinMoment];
    [shareList addSubview:lblWeixinMoment];
    [shareList addSubview:btnQQ];
    [shareList addSubview:lblQQ];
    [shareList addSubview:btnQZone];
    [shareList addSubview:lblQZone];
    
    // Setting the default state
    [btnCover setAlpha:0];
    [btnCover setHidden:YES];
    [self setAlpha:0];
    [self setHidden:YES];
    
    origCenter = self.center;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setVisible:(BOOL)visible {
    if (visible && self.alpha == 0) {
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [nav.topViewController.view addSubview:btnCover];
        [nav.topViewController.view addSubview:self];
        
        [self setCenter:CGPointMake(origCenter.x, origCenter.y + self.frame.size.height)];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self setHidden:NO];
            self.alpha = 1.f;
            
            [btnCover setHidden:NO];
            btnCover.alpha = 0.21;
            
            [self setCenter:origCenter];
        }];
        
    } else if (!visible && self.alpha == 1.f) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
            btnCover.alpha = 0;
            
            [self setCenter:CGPointMake(origCenter.x, origCenter.y + self.frame.size.height)];
            
        } completion:^(BOOL finished) {
            [self setHidden:YES];
            [btnCover setHidden:YES];
            
            [self removeFromSuperview];
            [btnCover removeFromSuperview];
        }];
    }
}

- (void)cancel {
    [self setVisible:NO];
}

- (void)sendMessageToWeixinWithMessage:(MooShareMessage *)shareMessage withScene:(int)scene {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        // 好友分享
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = shareMessage.title;
        message.description = shareMessage.content;
        [message setThumbImage:[UIImage imageWithData:shareMessage.imageData]];
        
        WXWebpageObject *web = [WXWebpageObject object];
        web.webpageUrl = shareMessage.URL;
        
        message.mediaObject = web;
        message.mediaTagName = @"分享";
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = scene;
        
        [WXApi sendReq:req];
        
    } else {
        [mc alertInfo:@"温馨提示" withMessage:@"您尚未安装微信"];
    }
}

- (void)sendMessageToQQWithMessage:(MooShareMessage *)shareMessage withFlag:(uint64_t)flag {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        QQApiNewsObject *news = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareMessage.URL] title:shareMessage.title description:shareMessage.content previewImageData:shareMessage.imageData];
        
        if (flag) {
            [news setCflag:flag];
        }
        
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:news];
        
#ifdef DEBUG
        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
        NSLog(@"Send result: %d", sent);
#else
        [QQApiInterface sendReq:req];
#endif
        
    } else {
        [mc alertInfo:@"温馨提示" withMessage:@"您尚未安装QQ"];
    }
}

- (void)shareToWeixinFriendWithMessage {
    if (self.shareMessage != nil) {
        [self sendMessageToWeixinWithMessage:self.shareMessage withScene:0];
        
    } else {
#ifdef DEBUG
        NSLog(@"尚未设置消息");
#endif
    }
}

- (void)shareToWeixinMomentWithMessage {
    if (self.shareMessage != nil) {
        [self sendMessageToWeixinWithMessage:self.shareMessage withScene:1];
        
    } else {
#ifdef DEBUG
        NSLog(@"尚未设置消息");
#endif
    }
}

- (void)shareToQQFriendWithMessage {
    if (self.shareMessage != nil) {
        [self sendMessageToQQWithMessage:self.shareMessage withFlag:0];
        
    } else {
#ifdef DEBUG
        NSLog(@"尚未设置消息");
#endif
    }
}

- (void)shareToQZoneWithMessage {
    if (self.shareMessage != nil) {
        [self sendMessageToQQWithMessage:self.shareMessage withFlag:kQQAPICtrlFlagQZoneShareOnStart];
        
    } else {
#ifdef DEBUG
        NSLog(@"尚未设置消息");
#endif
    }
}

@end
