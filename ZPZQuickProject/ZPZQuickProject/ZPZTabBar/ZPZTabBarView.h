//
//  ZPZTabBarView.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPZTabBarManager.h"

@class ZPZTabBarModel;

typedef void(^SelectedItem)(ZPZTabBarModel * selectModel);

@interface ZPZTabBarView : UIView

@property (nonatomic, copy) SelectedItem selectedItem;

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray<ZPZTabBarModel *> *)dataSource;
/**
 * 更新某一个Tab，会触发回调
 * 根据其中的type做唯一区分
 */
- (void)updateItemWithModel:(ZPZTabBarModel *)itemModel;
/**
 * 更新某一个Tab，不会触发回调，只是更新状态
 * 根据其中的type做唯一区分
 */
- (void)updateItemWithModelOutOfEvent:(ZPZTabBarModel *)itemModel;
/**
 * 获取到当前选中的Tab
 */
- (ZPZTabBarModel *)currentSelectItemModel;
/**
 * 根据类型获取Tab
 */
- (ZPZTabBarModel *)tabModelAccordingType:(ZPZTabBarItemType)type;

@end
