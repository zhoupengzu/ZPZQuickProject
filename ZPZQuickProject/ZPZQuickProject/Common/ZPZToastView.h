//
//  ZPZToastView.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZPZToastType) {
    ZPZToastTypeTitle,
    ZPZToastTypeTitle_Img,
};

@interface ZPZToastView : UIView

+ (ZPZToastView *)showToastViewInView:(UIView *)superView withType:(ZPZToastType)type andTitle:(NSString *)title andToastIcon:(NSString *)toastIcon andTimeInterval:(NSTimeInterval)interval andFinishedHanlder:(void(^)(void))hanlder;
+ (ZPZToastView *)showToastViewInView:(UIView *)superView withBacColor:(UIColor *)bacColor withType:(ZPZToastType)type andTitle:(NSString *)title withStyleTitleColor:(UIColor *)titleColor andTitleFont:(UIFont *)titleFont andToastIcon:(NSString *)toastIcon andTimeInterval:(NSTimeInterval)interval andFinishedHanlder:(void(^)(void))hanlder;

@end
