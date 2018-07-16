//
//  ZPZLoadingView.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZLoadingView.h"
#import "ZPZProjectConstant.h"
#import "ZPZPublicManager.h"
#import "ZPZAppDelegate.h"

#define kContentBacViewWidth 56
#define kContentBacViewHeight 56
#define kContentViewWidth 26
#define kContentViewHeight 26

@interface ZPZLoadingView()

@property (nonatomic, strong) UIView * contentBacView;
@property (nonatomic, strong) UIImageView * loadingImgView;

@end

@implementation ZPZLoadingView

+ (ZPZLoadingView *)showLoadingViewInView:(UIView *)containerView {
    return [self showLoadingViewInView:containerView withTitle:nil];
}

+ (ZPZLoadingView *)showLoadingViewInView:(UIView *)containerView withTitle:(NSString *)title {
    if (containerView == nil) {
        containerView = [ZPZPublicManager appDelegate].window;
    }
    CGRect frame = containerView.frame;
    ZPZLoadingView * loadingView = [[ZPZLoadingView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    loadingView.backgroundColor = [UIColor clearColor];
    
    CGFloat contentBacHeight = kContentBacViewHeight;
    CGFloat contentBacWidth = kContentBacViewWidth;
    CGFloat titleMargin = 10;
    UIFont * titleFont = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:15];
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(frame.size.width - 2 * kProjectMargin, frame.size.height) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : titleFont} context:NULL].size;
    if (title.length > 0) {
        contentBacHeight = contentBacHeight + titleMargin + ceilf(titleSize.height);
        contentBacWidth = MAX(contentBacWidth, ceilf(titleSize.width + 2 * kProjectMargin));
    }
    
    UIView * contentBacView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(frame) - contentBacWidth / 2, CGRectGetMidY(frame) - contentBacHeight / 2, contentBacWidth, contentBacHeight)];
    contentBacView.backgroundColor = [ZPZPublicManager colorWithHexString:kDeepTextColor_4a4a4a];
    contentBacView.layer.cornerRadius = 4;
    contentBacView.layer.masksToBounds = YES;
    contentBacView.alpha = 0;
    [loadingView addSubview:contentBacView];
    loadingView.contentBacView = contentBacView;
    
    UIImageView * loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(contentBacView.frame) / 2 - kContentViewWidth / 2, kContentBacViewHeight / 2 - kContentViewHeight / 2, kContentViewWidth, kContentViewHeight)];
    loadingImgView.backgroundColor = [UIColor clearColor];
    loadingImgView.contentMode = UIViewContentModeScaleAspectFill;
    loadingImgView.image = [UIImage imageNamed:@"loading1"];
    loadingImgView.clipsToBounds = YES;
    loadingView.loadingImgView = loadingImgView;
    [contentBacView addSubview:loadingImgView];
    
    if (title.length > 0) {
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(loadingImgView.frame) + titleMargin, contentBacWidth, ceilf(titleSize.height))];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = titleFont;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        titleLabel.text = title;
        [contentBacView addSubview:titleLabel];
    }
    
    CABasicAnimation * rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = @(0);
    rotateAnimation.toValue = @(2 * M_PI);
    rotateAnimation.duration = 1.5;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.repeatCount = HUGE_VAL;
    
    [containerView addSubview:loadingView];
    
    [UIView animateWithDuration:0.25 animations:^{
        contentBacView.alpha = 1;
    } completion:^(BOOL finished) {
        [loadingImgView.layer addAnimation:rotateAnimation forKey:@"rotate"];
    }];
    
    return loadingView;
}

- (void)dealloc {
    NSLog(@"%@ release", NSStringFromClass([self class]));
}

@end
