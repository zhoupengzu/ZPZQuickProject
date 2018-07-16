//
//  ZPZCustomFieldModel.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZPZCustomFieldType) {
    ZPZCustomFieldTypeDefault = 10,  // 默认只有编辑框
    ZPZCustomFieldTypeTitle,    // 主标题 + 编辑框
    ZPZCustomFieldTypeTitle_Img,  // 主标题 + 编辑框 + 图片（带手势）
    ZPZCustomFieldTypeTitle_ImgCode = ZPZCustomFieldTypeTitle_Img,  //主标题 + 编辑框 + 图片验证码，和MYCustomFieldTypeTitle_Img相同
    ZPZCustomFieldTypeTitle_Msg,
    ZPZCustomFieldTypeTitle_MsgCode = ZPZCustomFieldTypeTitle_Msg,   // 主标题 + 编辑框 + 手机验证码
    ZPZCustomFieldTypeTitle_MsgCode_Bac, // 主标题 + 编辑框 + 手机验证码(带定制背景)
    
    ZPZCustomFieldTypeField_MsgCode, // 编辑框 + 手机验证码
};

@interface ZPZCustomFieldModel : NSObject

@property (nonatomic, assign) ZPZCustomFieldType type;

/**
 * title
 */
@property (nonatomic, strong) UIColor * titleColor;
@property (nonatomic, strong) UIFont * titleFont;
@property (nonatomic, copy) NSString * title;
/**
 * field
 */
@property (nonatomic, strong) NSAttributedString * placeHolderAttr;
@property (nonatomic, strong) UIFont * fieldContentFont;
@property (nonatomic, strong) UIColor * fieldContentColor;
@property (nonatomic, copy) NSString * fieldContent;
@property (nonatomic, assign) CGFloat contentLRMargin;
@property (nonatomic, assign) BOOL isNeedSecurity;
@property (nonatomic, assign) BOOL canEdited;
/**
 * 倒计时按钮或者正常按钮
 */
@property (nonatomic, strong) UIColor * msgCodeNormalBacColor;
@property (nonatomic, strong) UIColor * msgCodeDisableBacColor;
@property (nonatomic, strong) UIFont * msgCodeFont;
@property (nonatomic, strong) UIColor * msgCodeDisableColor;
@property (nonatomic, strong) UIColor * msgNormalColor;
@property (nonatomic, copy) NSString * msgDefaultTitle;
@property (nonatomic, copy) NSString * msgResetTitle;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, copy) NSString * countingFormat;  // 格式为：%@秒后重新获取
@property (nonatomic, assign) CGFloat msgContentPadding;
/**
 * 图片
 */
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, copy) NSString * imgUrlStr;
@property (nonatomic, strong) UIImage * showImg;

/**
 * 一些默认方法
 */
+ (UIColor *)defaultTitleColor;
+ (UIFont *)defaultTitleFont;
+ (UIColor *)defaultContentColor;
+ (UIFont *)defaultContentFont;
+ (UIColor *)defaultContentPlaceHolderColor;
+ (NSAttributedString *)defaultContentPlaceHolderAttrWithStr:(NSString *)placeHolder;

@end
