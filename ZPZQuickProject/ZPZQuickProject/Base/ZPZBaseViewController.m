//
//  ZPZBaseViewController.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZBaseViewController.h"
#import "ZPZPublicManager+Device.h"
#import "ZPZProjectConstant.h"

@interface ZPZBaseViewController ()

@property (nonatomic, copy) void(^leftEventHandle)(void);
@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation ZPZBaseViewController

- (CGFloat)noServiceTopMarginWithNav {
    return [ZPZPublicManager statusBarHeight] + [ZPZPublicManager navBarHeight] + 60;
}

- (CGPoint)leftPoint {
    return CGPointMake(10, [ZPZPublicManager statusBarHeight]);
}

- (CGRect)leftItemFrame {
    return CGRectMake(self.leftPoint.x, self.leftPoint.y, [ZPZPublicManager navBarHeight], [ZPZPublicManager navBarHeight]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [ZPZPublicManager colorWithHexString:kBaseColor_f9f9f9];
    self.navigationItem.hidesBackButton = YES;
    //    self.fd_prefersNavigationBarHidden = NO;
}

- (void)showLeftBtnWithEventHandle:(void(^)(void))eventHandle {
    [self setLeftBtnWithImgStr:kNavLeftBtnImgName andImgSize:kNavLeftBtnImgSize andEventHandle:eventHandle];
}

- (void)setLeftBtnWithImgStr:(NSString *)imgStr andImgSize:(CGSize)imgSize andEventHandle:(void(^)(void))eventHandle {
    _leftEventHandle = eventHandle;
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 0, [ZPZPublicManager navBarHeight], [ZPZPublicManager navBarHeight]);
    _leftBtn.backgroundColor = [UIColor clearColor];
    [_leftBtn addTarget:self action:@selector(clickedLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    //    [_leftBtn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(_leftBtn.frame) - imgSize.height / 2, imgSize.width, imgSize.height)];
    imgView.backgroundColor = [UIColor clearColor];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = [UIImage imageNamed:imgStr];
    [_leftBtn addSubview:imgView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
}

- (void)setNavTitle:(NSString *)title {
    [self setNavTitle:title andFontSize:@(17) withColor:[ZPZPublicManager colorWithHexString:kDeepTextColor_4a4a4a]];
}

- (void)setNavTitle:(NSString *)title andFontSize:(NSNumber *)fontSize withColor:(UIColor *)color {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kProjectMainScreenWidth, [ZPZPublicManager navBarHeight])];
    _titleLabel.text = title;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = color;
    _titleLabel.font = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:fontSize.floatValue];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel sizeToFit];  // 这一行很重要
    self.navigationItem.titleView = _titleLabel;
}

- (void)updateNavSubViewsFrame {
    __block CGFloat leftMaxX = 0;
    __block CGFloat rightMinX = kProjectMainScreenWidth;
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectGetMaxX(obj.customView.frame) >= leftMaxX) {
            leftMaxX = CGRectGetMaxX(obj.customView.frame);
        }
    }];
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectGetMinX(obj.customView.frame) <= rightMinX) {
            rightMinX = CGRectGetMinX(obj.customView.frame);
        }
    }];
    self.navigationItem.titleView.frame = CGRectMake(leftMaxX, 0, rightMinX - leftMaxX, [ZPZPublicManager navBarHeight]);
}

- (void)clickedLeftBtn {
    if (_leftEventHandle) {
        _leftEventHandle();
    }
}

- (void)dealloc {
    NSLog(@"%@ released", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
