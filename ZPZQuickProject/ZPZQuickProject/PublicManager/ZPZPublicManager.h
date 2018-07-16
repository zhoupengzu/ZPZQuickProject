//
//  ZPZPublicManager.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZPZAppDelegate;

@interface ZPZPublicManager : NSObject
/**
 * 判断是否是第一次启动
 */
+ (BOOL)isFirstLaunch;
/**
 * 记录第一次启动
 */
+ (void)recordFirstLaunch;
/**
 * 获取Appdelegate
 */
+ (ZPZAppDelegate *)appDelegate;
/**
 * 字体
 */
+ (UIFont *)getFontWithFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize;
/**
 * 获取引导图
 */
+ (NSArray<NSString *> *)guideImages;
/**
 * 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
