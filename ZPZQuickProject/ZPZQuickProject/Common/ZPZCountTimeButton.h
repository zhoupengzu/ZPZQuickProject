//
//  ZPZCountTimeButton.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPZCountTimeButton : UIButton

@property (nonatomic, strong) UIColor * disableColor;
@property (nonatomic, strong) UIColor * normalColor;
@property (nonatomic, copy) NSString * defaultTitle;
@property (nonatomic, copy) NSString * resetTitle;
@property (nonatomic, strong) UIColor * disableBacColor;
@property (nonatomic, strong) UIColor * normalBacColor;

- (void)startWithTimeout:(NSTimeInterval)timeout andFromatTitle:(NSString *)formatTitle;
- (void)stop;

@end
