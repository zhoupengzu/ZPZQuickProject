//
//  ZPZPublicManager+Device.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZPublicManager+Device.h"
#import "ZPZAppDelegate.h"
#import "ZPZBaseNavigationViewController.h"

// Screen Size
#define kIphoneXSeries CGSizeMake(1125, 2436)
#define kIphoneSESeries CGSizeMake(640, 1136)
#define kIphone8PSeries CGSizeMake(1242, 2208)
#define KIphone8Series CGSizeMake(750, 1334)
#define kIphone5Series CGSizeMake(640, 1136)


@implementation ZPZPublicManager (Device)

+ (NSArray<NSNumber *> *)currentScreenSeries {
    CGSize currentModeSize = [[UIScreen mainScreen] currentMode].size;
    if (CGSizeEqualToSize(currentModeSize, kIphoneXSeries)) {
        return @[@(ZPZDeviceGenerationIphone_X)];
    }
    if (CGSizeEqualToSize(currentModeSize, kIphone8PSeries)) {
        return @[@(ZPZDeviceGenerationIphone_6P),@(ZPZDeviceGenerationIphone_6sP), @(ZPZDeviceGenerationIphone_7P), @(ZPZDeviceGenerationIphone_8P)];
    }
    if (CGSizeEqualToSize(currentModeSize, KIphone8Series)) {
        return @[@(ZPZDeviceGenerationIphone_8), @(ZPZDeviceGenerationIphone_7), @(ZPZDeviceGenerationIphone_6s), @(ZPZDeviceGenerationIphone_6)];
    }
    if (CGSizeEqualToSize(currentModeSize, kIphoneSESeries)) {
        return @[@(ZPZDeviceGenerationIphone_SE)];
    }
    if (CGSizeEqualToSize(currentModeSize, kIphone5Series)) {
        return @[@(ZPZDeviceGenerationIphone_5), @(ZPZDeviceGenerationIphone_5c), @(ZPZDeviceGenerationIphone_5s)];
    }
    return @[@(ZPZDeviceGenerationUnknow)];
}

+ (CGFloat)statusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

+ (CGFloat)navBarHeight {
    ZPZAppDelegate * delegate = [self appDelegate];
    return delegate.rootNav.navigationBar.frame.size.height;
}

@end
