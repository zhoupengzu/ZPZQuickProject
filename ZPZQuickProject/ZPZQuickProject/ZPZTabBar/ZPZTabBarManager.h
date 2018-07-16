//
//  ZPZTabBarManager.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZPZTabBarModel;

typedef NS_ENUM(NSInteger, ZPZTabBarStyle) {
    ZPZTabBarStyleTitle,   // 默认的样式，只有文字
    ZPZTabBarStyleIconImage,  // 只有图片
    ZPZTabBarStyleTitle_IconImage,  // 图片和文字都有
};

typedef NS_ENUM(NSInteger, ZPZTabBarItemType) {
    ZPZTabBarItemTypeDefault,
    ZPZTabBarItemTypeHome,
    ZPZTabBarItemTypeOrder,
    ZPZTabBarItemTypeMine,
};

@interface ZPZTabBarManager : NSObject

@property (nonatomic, assign, class) NSInteger tabCount;
@property (nonatomic, assign, class) CGFloat tabBarWidth;

+ (NSArray<ZPZTabBarModel *> *)defaultTabBarDataSource;

@end
