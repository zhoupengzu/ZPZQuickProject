//
//  ZPZTabBarModel.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPZTabBarManager.h"

@interface ZPZTabBarModel : NSObject<NSCopying>

/**
 * Tab的样式类型
 */
@property (nonatomic, assign) ZPZTabBarStyle style;
/**
 * Tab的内容类型，一般用该变量来区分唯一性
 */
@property (nonatomic, assign) ZPZTabBarItemType type;
/**
 * 内容
 */
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * selectIconImageStr;  // 选中状态的图片
@property (nonatomic, copy) NSString * normalIconImageStr;  // 正常展示时的图片
@property (nonatomic, copy) NSString * redDotImageStr; // 小红点图片
/**
 * 小红点
 */
@property (nonatomic, assign) BOOL isHaveRedDot;   // 是否含有小红点
/**
 * 状态
 */
@property (nonatomic, assign) BOOL isSelected; // 当前是否被选中

/**
 * 位置
 */
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect redDotFrame;
/**
 * 颜色
 */
@property (nonatomic, strong) UIColor * normalTitleColor;
@property (nonatomic, strong) UIColor * selectedTitleColor;
/**
 * 字体
 */
@property (nonatomic, strong) UIFont * titleFont;

@end
