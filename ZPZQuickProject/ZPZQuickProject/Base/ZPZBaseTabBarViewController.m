//
//  ZPZBaseTabBarViewController.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZBaseTabBarViewController.h"
#import "ZPZBaseNavigationViewController.h"
#import "ZPZAppDelegate.h"
#import "ZPZPublicManager.h"
#import "ZPZTabBarView.h"
#import "ZPZTabBarModel.h"
#import "ZPZProjectConstant.h"

@interface ZPZBaseTabBarViewController ()

@property (nonatomic, assign) BOOL hasConfigTabBar;
@property (nonatomic, strong) ZPZTabBarView * tabBarView;
@property (nonatomic, strong) UIViewController * homeVC;
@property (nonatomic, strong) UIViewController * orderVC;
@property (nonatomic, strong) UIViewController * mineVC;

@end

@implementation ZPZBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_hasConfigTabBar) {
        [self configTabBar];
        [self updateSelectedController];
    }
    if (_needToPushVC) {
        UIViewController * tempVC = _needToPushVC;
        _needToPushVC = nil;
        [[ZPZPublicManager appDelegate].rootNav pushViewController:tempVC animated:YES];
    }
}
/**
 * 添加tabBar
 */
- (void)configTabBar {
    _hasConfigTabBar = YES;
    __weak ZPZBaseTabBarViewController * weakSelf = self;
    NSArray<ZPZTabBarModel *> * dataSource = [ZPZTabBarManager defaultTabBarDataSource];
    _tabBarView = [[ZPZTabBarView alloc] initWithFrame:CGRectMake(0, 0, [ZPZTabBarManager tabBarWidth], self.tabBar.frame.size.height) andDataSource:dataSource];
    _tabBarView.selectedItem = ^(ZPZTabBarModel *selectModel) {
        NSLog(@"%@", selectModel.title);
        [weakSelf updateSelectedController];
    };
    [self.tabBar addSubview:_tabBarView];
    [self updateNewShadowImg];
}

- (void)updateNewShadowImg {
    UIGraphicsBeginImageContext(CGSizeMake(kProjectMainScreenWidth, 0.5));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [ZPZPublicManager colorWithHexString:kSepLineColor_e4e4e4].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, kProjectMainScreenWidth, 0.5));
    UIImage * shadowImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:shadowImage];
    
    UIGraphicsBeginImageContext(CGSizeMake(kProjectMainScreenWidth, self.tabBar.frame.size.height));
    context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, kProjectMainScreenWidth, self.tabBar.frame.size.height));
    UIImage * tabBarBacImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.tabBar.backgroundImage = tabBarBacImage;
}
/**
 * 做选中展示更新
 */
- (void)updateSelectedController {
    ZPZBaseNavigationViewController * rootNav = [ZPZPublicManager appDelegate].rootNav;
    ZPZTabBarModel * selectedModel = [_tabBarView currentSelectItemModel];
    switch (selectedModel.type) {
        case ZPZTabBarItemTypeHome:{
            if (_homeVC == nil) {
                _homeVC = [[UIViewController alloc] init];
            }
            rootNav.viewControllers = @[];
            [rootNav pushViewController:_homeVC animated:NO];
        }
            break;
        case ZPZTabBarItemTypeOrder:{
            if (_orderVC == nil) {
                _orderVC = [[UIViewController alloc] init];
            }
            rootNav.viewControllers = @[];
            [rootNav pushViewController:_orderVC animated:NO];
        }
            break;
        case ZPZTabBarItemTypeMine: {
            if (_mineVC == nil) {
                _mineVC = [[UIViewController alloc] init];
            }
            rootNav.viewControllers = @[];
            [rootNav pushViewController:_mineVC animated:NO];
        }
            break;
        default:
            break;
    }
}

- (void)showRedDotViewOfType:(ZPZTabBarItemType)type {
    ZPZTabBarModel * tempModel = [_tabBarView tabModelAccordingType:type];
    tempModel.isHaveRedDot = YES;
    [_tabBarView updateItemWithModelOutOfEvent:tempModel];
}

- (void)hideRedDotViewOfType:(ZPZTabBarItemType)type {
    ZPZTabBarModel * tempModel = [_tabBarView tabModelAccordingType:type];
    tempModel.isHaveRedDot = NO;
    [_tabBarView updateItemWithModelOutOfEvent:tempModel];
}

@end
