//
//  AppDelegate.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPZBaseTabBarViewController;
@class ZPZBaseNavigationViewController;

@interface ZPZAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) ZPZBaseTabBarViewController * rootTabBar;
@property (strong, nonatomic, readonly) ZPZBaseNavigationViewController * rootNav;
/**
 * 重新进入根视图
 * 如果根视图不存在，则创建
 */
- (void)gotoRootViewController;
- (void)gotoRootViewControllerAndPushToVC:(UIViewController *)pushVC;
/**
 * 进入根视图，然后进入登陆页面
 */
- (void)gotoRootVCAndThenLogin;
/**
 * 移除家在window上的loading
 */
- (void)removeLoadingView;


@end

