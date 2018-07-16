//
//  ZPZTabBarManager.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZTabBarManager.h"
#import "ZPZTabBarModel.h"
#import "ZPZProjectConstant.h"
#import "ZPZPublicManager.h"

@implementation ZPZTabBarManager
@dynamic tabBarWidth;
@dynamic tabCount;

+ (CGFloat)tabBarWidth {
    return kProjectMainScreenWidth;
}

+ (NSInteger)tabCount {
    return 3;
}

+ (NSArray<ZPZTabBarModel *> *)defaultTabBarDataSource {
    // 准备通用数据
    CGFloat allWidth = [self tabBarWidth];
    NSInteger tabCount = [self tabCount];
    CGFloat itemWidth = ceilf(allWidth / tabCount);
    CGFloat imgWH = 24;
    CGFloat beginY = 5;
    CGRect imgFrame = CGRectMake(itemWidth / 2 - imgWH / 2, beginY, imgWH, imgWH);
    CGRect titleFrame = CGRectMake(0, CGRectGetMaxY(imgFrame) + 3, itemWidth, 10);
    CGRect redDotFrame = CGRectMake(CGRectGetMinX(imgFrame) + 20, 6, 6, 6);
    UIColor * normalColor = [ZPZPublicManager colorWithHexString:kDeepTextColor_4a4a4a];
    UIColor * selectColor = [ZPZPublicManager colorWithHexString:kTextColor_ffc700];
    UIFont * titleFont = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:10];
    
    NSMutableArray * dataSource = [NSMutableArray array];
    // 首页
    ZPZTabBarModel * mainModel = [[ZPZTabBarModel alloc] init];
    mainModel.type = ZPZTabBarItemTypeHome;
    mainModel.style = ZPZTabBarStyleTitle_IconImage;
    mainModel.title = @"麦芽分期";
    mainModel.selectIconImageStr = @"home_active";
    mainModel.normalIconImageStr = @"home_default";
    mainModel.redDotImageStr = @"red_dot";
    mainModel.isHaveRedDot = NO;
    mainModel.isSelected = YES;
    mainModel.imageFrame = imgFrame;
    mainModel.titleFrame = titleFrame;
    mainModel.redDotFrame = redDotFrame;
    mainModel.normalTitleColor = normalColor;
    mainModel.selectedTitleColor = selectColor;
    mainModel.titleFont = titleFont;
    [dataSource addObject:mainModel];
    
    // 订单
    ZPZTabBarModel * orderModel = [[ZPZTabBarModel alloc] init];
    orderModel.type = ZPZTabBarItemTypeOrder;
    orderModel.style = ZPZTabBarStyleTitle_IconImage;
    orderModel.title = @"订单";
    orderModel.selectIconImageStr = @"orders_active";
    orderModel.normalIconImageStr = @"orders_default";
    orderModel.redDotImageStr = @"red_dot";
    orderModel.isHaveRedDot = NO;
    orderModel.isSelected = NO;
    orderModel.imageFrame = imgFrame;
    orderModel.titleFrame = titleFrame;
    orderModel.redDotFrame = redDotFrame;
    orderModel.normalTitleColor = normalColor;
    orderModel.selectedTitleColor = selectColor;
    orderModel.titleFont = titleFont;
    [dataSource addObject:orderModel];
    
    // 我的
    ZPZTabBarModel * mineModel = [[ZPZTabBarModel alloc] init];
    mineModel.type = ZPZTabBarItemTypeMine;
    mineModel.style = ZPZTabBarStyleTitle_IconImage;
    mineModel.title = @"我的";
    mineModel.selectIconImageStr = @"user_active";
    mineModel.normalIconImageStr = @"user_default";
    mineModel.redDotImageStr = @"red_dot";
    mineModel.isHaveRedDot = NO;
    mineModel.isSelected = NO;
    mineModel.imageFrame = imgFrame;
    mineModel.titleFrame = titleFrame;
    mineModel.redDotFrame = redDotFrame;
    mineModel.normalTitleColor = normalColor;
    mineModel.selectedTitleColor = selectColor;
    mineModel.titleFont = titleFont;
    [dataSource addObject:mineModel];
    
    return dataSource;
}

@end
