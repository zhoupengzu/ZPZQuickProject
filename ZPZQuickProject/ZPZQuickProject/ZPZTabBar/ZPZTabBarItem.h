//
//  ZPZTabBarItem.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPZTabBarModel;
@class ZPZTabBarItem;

typedef void(^ZPZTabBarclickedTabItem)(ZPZTabBarItem * item);

@interface ZPZTabBarItem : UIView

@property (nonatomic, strong, readonly) UILabel * titleLabel;
@property (nonatomic, strong, readonly) UIImageView * iconImageView;
@property (nonatomic, strong, readonly) UIImageView * redDotImgView;
/**
 * 该item的数据源，存储了和该数据源相关的信息
 */
@property (nonatomic, strong, readonly) ZPZTabBarModel * itemModel;
/**
 * 事件回调
 */
@property (nonatomic, copy, readonly) ZPZTabBarclickedTabItem clickedItem;

- (instancetype)initWithItemSource:(ZPZTabBarModel *)itemModel andEventBlock:(ZPZTabBarclickedTabItem)eventBlock;
- (void)updateItemWithModel:(ZPZTabBarModel *)itemModel;

@end
