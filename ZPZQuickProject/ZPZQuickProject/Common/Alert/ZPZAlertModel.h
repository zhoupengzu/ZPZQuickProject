//
//  ZPZAlertModel.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZPZCustomFieldModel;

@interface ZPZAlertModel : NSObject

@property (nonatomic, copy) NSString * text;
@property (nonatomic, assign) NSTextAlignment alignment;
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, strong) UIFont * textFont;
@property (nonatomic, strong) UIColor * bacColor;
/**
 * 使用在MYAlertField类中
 */
@property (nonatomic, strong) ZPZCustomFieldModel * contentFieldModel;
/**
 * 默认按钮的颜色和字体
 */
- (void)useDefaultActionColorAndFont;
/**
 * 默认标题颜色和字体
 */
- (void)useDefaultTitleColorAndFont;
/**
 * 默认内容颜色和字体
 */
- (void)useDefaultContentColorAndFont;
/**
 * 默认提示内容颜色和字体
 */
- (void)useDefaultTipContentColorAndFont;

+ (ZPZAlertModel *)convienceForTitleWithTitle:(NSString *)title;
+ (ZPZAlertModel *)convienceForContentWithContent:(NSString *)content;
+ (ZPZAlertModel *)convienceForTipContentWithTip:(NSString *)tip;
+ (NSArray<ZPZAlertModel *> *)convienceForActionWithTitleArr:(NSArray<NSString *> *)titleArr;

@end
