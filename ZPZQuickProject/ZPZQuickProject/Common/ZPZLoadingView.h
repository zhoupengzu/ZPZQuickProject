//
//  ZPZLoadingView.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPZLoadingView : UIView

+ (ZPZLoadingView *)showLoadingViewInView:(UIView *)containerView;
+ (ZPZLoadingView *)showLoadingViewInView:(UIView *)containerView withTitle:(NSString *)title;

@end
