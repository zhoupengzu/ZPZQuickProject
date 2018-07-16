//
//  ZPZBaseNavigationViewController.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZBaseNavigationViewController.h"
#import "ZPZPublicManager.h"
#import "ZPZProjectConstant.h"

@interface ZPZBaseNavigationViewController ()

@end

@implementation ZPZBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawShadowImage];
}

- (void)drawShadowImage {
    UIGraphicsBeginImageContext(CGSizeMake(kProjectMainScreenWidth, 0.5));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [ZPZPublicManager colorWithHexString:kSepLineColor_e4e4e4].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, kProjectMainScreenWidth, 0.5));
    UIImage * shadowImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationBar setShadowImage:shadowImage];
}

@end
