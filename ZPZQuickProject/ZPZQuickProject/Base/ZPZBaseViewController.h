//
//  ZPZBaseViewController.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPZBaseViewController : UIViewController

/**
 * 和导航栏位置相同的左侧的第一个按钮的位置的坐标，多用于自定义时
 */
@property (nonatomic, assign) CGPoint leftPoint;
@property (nonatomic, assign) CGRect leftItemFrame;

/**
 * 设置导航了左侧的返回按钮
 * 目前暂时只实现了只支持图片的情况
 * imgStr和imgSize如果没有特殊的要求，应该取MYProjectConstant.h文件里的相关内容
 */
- (void)showLeftBtnWithEventHandle:(void(^)(void))eventHandle;
- (void)setLeftBtnWithImgStr:(NSString *)imgStr andImgSize:(CGSize)imgSize andEventHandle:(void(^)(void))eventHandle;
/**
 * 设置导航栏标题
 */
- (void)setNavTitle:(NSString *)title;
- (void)setNavTitle:(NSString *)title andFontSize:(NSNumber *)fontSize withColor:(UIColor *)color;

@end
