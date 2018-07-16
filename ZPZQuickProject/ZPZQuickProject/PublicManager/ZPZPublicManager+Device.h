//
//  ZPZPublicManager+Device.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZPublicManager.h"

/**
 * 手机型号，表示是IPhone几
 */
typedef NS_ENUM(NSInteger, ZPZDeviceGeneration) {
    ZPZDeviceGenerationUnknow = 100,
    ZPZDeviceGenerationIphone_5,
    ZPZDeviceGenerationIphone_5c,
    ZPZDeviceGenerationIphone_5s,
    ZPZDeviceGenerationIphone_6,
    ZPZDeviceGenerationIphone_6P,
    ZPZDeviceGenerationIphone_6s,
    ZPZDeviceGenerationIphone_6sP,
    ZPZDeviceGenerationIphone_SE,
    ZPZDeviceGenerationIphone_7,
    ZPZDeviceGenerationIphone_7P,
    ZPZDeviceGenerationIphone_8,
    ZPZDeviceGenerationIphone_8P,
    ZPZDeviceGenerationIphone_X,
};

@interface ZPZPublicManager (Device)
/**
 * 获取和当前尺寸相同的所有手机型号
 * @return 数组里的NSNumber是MYDeviceGeneration类型的包装
 */
+ (NSArray<NSNumber *> *)currentScreenSeries;
/**
 * 获取导航栏高度、状态栏高度
 */
+ (CGFloat)statusBarHeight;
+ (CGFloat)navBarHeight;

@end
