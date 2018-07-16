//
//  ZPZTabBarView.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZTabBarView.h"
#import "ZPZTabBarItem.h"
#import "ZPZTabBarModel.h"

@interface ZPZTabBarView()

@property (nonatomic, strong) NSMutableArray<ZPZTabBarItem *> * dataSource;

@end

@implementation ZPZTabBarView

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray<ZPZTabBarModel *> *)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        _dataSource = [NSMutableArray array];
        if (dataSource.count == 0) { } else {
            CGFloat itemWidth = ceilf(frame.size.width / dataSource.count);
            CGFloat itemHeight = frame.size.height;
            __weak ZPZTabBarView * weakSelf = self;
            [dataSource enumerateObjectsUsingBlock:^(ZPZTabBarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZPZTabBarItem * item = [[ZPZTabBarItem alloc] initWithItemSource:obj andEventBlock:^(ZPZTabBarItem * blockItem) {
                    [weakSelf clickedTabItem:blockItem];
                }];
                item.frame = CGRectMake(idx * itemWidth, 0, itemWidth, itemHeight);
                [item updateItemWithModel:obj];
                [weakSelf.dataSource addObject:item];
                [self addSubview:item];
            }];
        }
    }
    return self;
}

- (void)updateItemWithModel:(ZPZTabBarModel *)itemModel {
    if (itemModel ==  nil) {
        return;
    }
    __block ZPZTabBarItem * item = nil;
    [_dataSource enumerateObjectsUsingBlock:^(ZPZTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.itemModel.type == itemModel.type) {
            item = obj;
            [obj updateItemWithModel:[itemModel copy]];
        }
        // 对于选中状态需要做特殊处理，因为每次只能有一个被选中
        if (itemModel.isSelected) {
            if (obj.itemModel.type != itemModel.type) {
                obj.itemModel.isSelected = NO;
                [obj updateItemWithModel:obj.itemModel];
            }
        }
    }];
    // 判断是否有已选中的，如果有，则不处理，否则，默认选中第一个，并触发选中事件
    if (itemModel.isSelected) {
        [self clickedTabItem:item];
    } else {
        __block BOOL isHaveSelected = NO;
        [_dataSource enumerateObjectsUsingBlock:^(ZPZTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.itemModel.isSelected) {
                isHaveSelected = YES;
                * stop = YES;
            }
        }];
        if (!isHaveSelected) {
            [self clickedTabItem:_dataSource.firstObject];
        }
    }
}

- (void)updateItemWithModelOutOfEvent:(ZPZTabBarModel *)itemModel {
    if (itemModel ==  nil) {
        return;
    }
    [_dataSource enumerateObjectsUsingBlock:^(ZPZTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.itemModel.type == itemModel.type) {
            [obj updateItemWithModel:[itemModel copy]];
            *stop = YES;
        }
    }];
}

- (void)clickedTabItem:(ZPZTabBarItem *)item {
    if (_selectedItem && item) {
        [_dataSource enumerateObjectsUsingBlock:^(ZPZTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (item != obj) {
                obj.itemModel.isSelected = NO;
            } else {
                obj.itemModel.isSelected = YES;
            }
            [obj updateItemWithModel:obj.itemModel];
        }];
        _selectedItem([item.itemModel copy]);
    }
}

- (ZPZTabBarModel *)currentSelectItemModel {
    __block ZPZTabBarModel * model = nil;
    [_dataSource enumerateObjectsUsingBlock:^(ZPZTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.itemModel.isSelected) {
            model = obj.itemModel.copy;
            *stop = YES;
        }
    }];
    return model;
}

- (ZPZTabBarModel *)tabModelAccordingType:(ZPZTabBarItemType)type {
    __block ZPZTabBarModel * model = nil;
    [_dataSource enumerateObjectsUsingBlock:^(ZPZTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.itemModel.type == type) {
            model = [obj.itemModel copy];
            *stop = YES;
        }
    }];
    return model;
}

@end
