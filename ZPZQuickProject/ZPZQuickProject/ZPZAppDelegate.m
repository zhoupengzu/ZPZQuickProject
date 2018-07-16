//
//  AppDelegate.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZAppDelegate.h"
#import "ZPZPublicManager.h"
#import "ZPZGuideViewController.h"
#import "ZPZADViewController.h"
#import "ZPZBaseTabBarViewController.h"
#import "ZPZBaseNavigationViewController.h"
#import "ZPZLoadingView.h"

@interface ZPZAppDelegate ()

@end

@implementation ZPZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _rootTabBar = [[ZPZBaseTabBarViewController alloc] init];
    _rootNav = [[ZPZBaseNavigationViewController alloc] init];
    [_rootTabBar addChildViewController:_rootNav];
    _window.rootViewController = _rootTabBar;
    // 如果是第一次启动，则不再去请求广告；如果不是第一次启动，则去请求是否需要展示广告
//    if ([ZPZPublicManager isFirstLaunch]) {
//        // 第一次启动
//        [ZPZPublicManager recordFirstLaunch];
//        // 启动引导页展示
//        ZPZGuideViewController * guideVC = [[ZPZGuideViewController alloc] init];
//        _window.rootViewController = guideVC;
//    } else {
//        //        _rootTabBar = [[MYBaseTabBarViewController alloc] init];
//        //        _rootNav = [[MYBaseNavigationViewController alloc] init];
//        //        [_rootTabBar addChildViewController:_rootNav];
//        ZPZADViewController * adVC = [[ZPZADViewController alloc] init];
//        _window.rootViewController = adVC;
//        //        [self requestAndShowAD];
//    }
    [_window makeKeyAndVisible];
    return YES;
}

- (void)gotoRootViewController {
    if (_rootTabBar == nil) {
        _rootTabBar = [[ZPZBaseTabBarViewController alloc] init];
        _rootNav = [[ZPZBaseNavigationViewController alloc] init];
        [_rootTabBar addChildViewController:_rootNav];
        _window.rootViewController = _rootTabBar;
    } else {
        _rootNav = _rootTabBar.viewControllers.firstObject;
        if ([_rootNav isKindOfClass:[ZPZBaseNavigationViewController class]]) {
            [_rootNav popToRootViewControllerAnimated:NO];
        } else {
            
        }
    }
    
}

- (void)gotoRootViewControllerAndPushToVC:(UIViewController *)pushVC {
    [self gotoRootViewController];
    if (pushVC) {
        _rootTabBar.needToPushVC = pushVC;
    }
}

- (void)gotoRootVCAndThenLogin {
    
}

- (void)removeLoadingView {
    [_window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ZPZLoadingView class]]) {
            [obj removeFromSuperview];
        }
    }];
    [_rootNav.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull inObj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([inObj isKindOfClass:[ZPZLoadingView class]]) {
                [inObj removeFromSuperview];
            }
        }];
    }];
}


@end
