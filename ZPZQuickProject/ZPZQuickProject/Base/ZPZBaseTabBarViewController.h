//
//  ZPZBaseTabBarViewController.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPZTabBarManager.h"

@interface ZPZBaseTabBarViewController : UITabBarController

@property (nonatomic, strong) UIViewController * needToPushVC;

- (void)showRedDotViewOfType:(ZPZTabBarItemType)type;
- (void)hideRedDotViewOfType:(ZPZTabBarItemType)type;

@end
