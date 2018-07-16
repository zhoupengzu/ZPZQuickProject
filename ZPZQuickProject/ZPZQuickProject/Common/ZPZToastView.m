//
//  ZPZToastView.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZToastView.h"
#import "ZPZProjectConstant.h"
#import "ZPZAppDelegate.h"
#import "ZPZPublicManager+Device.h"

@interface ZPZToastView()

@property (nonatomic, copy) void(^hanlder)(void);

@end

@implementation ZPZToastView

+ (ZPZToastView *)showToastViewInView:(UIView *)superView withType:(ZPZToastType)type andTitle:(NSString *)title andToastIcon:(NSString *)toastIcon andTimeInterval:(NSTimeInterval)interval andFinishedHanlder:(void(^)(void))hanlder {
    UIFont * titleFont = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:15];
    UIColor * titleColor = [UIColor whiteColor];
    return [self showToastViewInView:superView  withBacColor:[ZPZPublicManager colorWithHexString:kDeepTextColor_4a4a4a] withType:type andTitle:title withStyleTitleColor:titleColor andTitleFont:titleFont andToastIcon:toastIcon andTimeInterval:interval andFinishedHanlder:hanlder];
}

+ (ZPZToastView *)showToastViewInView:(UIView *)superView withBacColor:(UIColor *)bacColor withType:(ZPZToastType)type andTitle:(NSString *)title withStyleTitleColor:(UIColor *)titleColor andTitleFont:(UIFont *)titleFont andToastIcon:(NSString *)toastIcon andTimeInterval:(NSTimeInterval)interval andFinishedHanlder:(void(^)(void))hanlder {
    if (superView == nil) {
        superView = [ZPZPublicManager appDelegate].window;
    }
    if (superView == nil) {
        return nil;
    }
    ZPZToastView * toastView = [[ZPZToastView alloc] initWithFrame:CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height)];
    toastView.backgroundColor = [UIColor clearColor];
    toastView.hanlder = hanlder;
    toastView.alpha = 0;
    
    UIImage * iconImg = [UIImage imageNamed:toastIcon];
    CGFloat iconWidth = iconImg.size.width;
    CGFloat iconHeight = iconImg.size.height;
    if (!iconImg) {
        type = ZPZToastTypeTitle;
    }
    CGFloat maxWidth = CGRectGetWidth(superView.frame) - 2 * kProjectMargin;
    CGFloat maxHeight = CGRectGetMaxY(superView.frame) - [ZPZPublicManager statusBarHeight] - [ZPZPublicManager navBarHeight] - 2 * kProjectMargin;
    
    switch (type) {
        case ZPZToastTypeTitle_Img: {
            maxHeight = maxHeight - (iconImg ? (kProjectMargin + iconHeight) : 0);
        }
            break;
            
        default:
            break;
    }
    
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(maxWidth, maxHeight) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : titleFont} context:NULL].size;
    CGFloat realContentHeight = ceilf(titleSize.height) + 2 * kProjectMargin;
    CGFloat realContentWidth = ceilf(titleSize.width) + 2 * kProjectMargin;
    if (realContentWidth < iconWidth) {
        realContentWidth = iconWidth + 2 * kProjectMargin;
    }
    if (realContentWidth > maxWidth) {
        realContentWidth = maxWidth;
        iconWidth = maxWidth - 2 * kProjectMargin;
    }
    switch (type) {
        case ZPZToastTypeTitle_Img: {
            if (iconImg) {
                realContentHeight = realContentHeight + kProjectMargin + iconHeight;
            }
        }
            break;
            
        default:
            break;
    }
    if (realContentHeight > maxHeight) {
        realContentHeight = maxHeight;
    }
    UIView * contentBacView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(toastView.frame) / 2 - realContentWidth / 2, CGRectGetHeight(toastView.frame) / 2 - realContentHeight / 2, realContentWidth, realContentHeight)];
    contentBacView.backgroundColor = bacColor;
    contentBacView.layer.cornerRadius = 4;
    contentBacView.layer.masksToBounds = YES;
    [toastView addSubview:contentBacView];
    switch (type) {
        case ZPZToastTypeTitle_Img: {
            UIImageView * iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(contentBacView.frame) / 2 - iconWidth / 2, kProjectMargin, iconWidth, iconHeight)];
            iconImgView.backgroundColor = [UIColor clearColor];
            iconImgView.contentMode = UIViewContentModeScaleAspectFit;
            iconImgView.image = iconImg;
            [contentBacView addSubview:iconImgView];
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kProjectMargin, CGRectGetMaxY(iconImgView.frame) + kProjectMargin, CGRectGetWidth(contentBacView.frame) - kProjectMargin * 2, ceilf(titleSize.height))];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = titleColor;
            titleLabel.font = titleFont;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.numberOfLines = 0;
            titleLabel.text = title;
            [contentBacView addSubview:titleLabel];
        }
            break;
        case ZPZToastTypeTitle: {
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kProjectMargin, kProjectMargin, CGRectGetWidth(contentBacView.frame) - kProjectMargin * 2, ceilf(titleSize.height))];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = titleColor;
            titleLabel.font = titleFont;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.numberOfLines = 0;
            titleLabel.text = title;
            [contentBacView addSubview:titleLabel];
        }
            break;
            
        default:
            break;
    }
    
    [superView addSubview:toastView];
    [UIView animateWithDuration:0.3 animations:^{
        toastView.alpha = 1;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                toastView.alpha = 0;
            } completion:^(BOOL finished) {
                [toastView removeFromSuperview];
            }];
            if (toastView.hanlder) {
                toastView.hanlder();
            }
        });
    }];
    return toastView;
}

- (void)dealloc {
    NSLog(@"%@ relased", NSStringFromClass(self.class));
}

@end
