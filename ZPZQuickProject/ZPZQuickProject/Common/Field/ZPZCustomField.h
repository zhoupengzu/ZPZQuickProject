//
//  ZPZCustomField.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPZCustomFieldModel;

@interface ZPZCustomField : UIView

/**
 * 获取当前的值
 */
@property (nonatomic, copy, readonly) NSString * currentContent;
/**
 * 是否是第一响应者
 */
@property (nonatomic, assign) BOOL isFieldFirstResponder;
/**
 * 初始化和创建视图
 */
+ (ZPZCustomField *)showCustomFieldWithDataModel:(ZPZCustomFieldModel *)model andFrame:(CGRect)frame andEventHandle:(void(^)(ZPZCustomFieldModel * currModel))eventHandle;
/**
 * 更新内容
 * 包括内容和尺寸，如果type类型和初始化时的不对应，则不会做更新操作
 */
- (void)updateCustomFieldWithModel:(ZPZCustomFieldModel *)updateModel;
/**
 * 开始倒计时
 */
- (void)startCounting;

@end
