//
//  ZPZTabBarModel.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZTabBarModel.h"

@implementation ZPZTabBarModel

- (id)copyWithZone:(NSZone *)zone {
    ZPZTabBarModel * model = [[ZPZTabBarModel alloc] init];
    model.style = self.style;
    model.type = self.type;
    model.title = self.title;
    model.normalIconImageStr = self.normalIconImageStr;
    model.selectIconImageStr = self.selectIconImageStr;
    model.redDotImageStr = self.redDotImageStr;
    model.isSelected = self.isSelected;
    model.isHaveRedDot = self.isHaveRedDot;
    model.imageFrame = self.imageFrame;
    model.titleFrame = self.titleFrame;
    model.redDotFrame = self.redDotFrame;
    model.normalTitleColor = self.normalTitleColor;
    model.selectedTitleColor = self.selectedTitleColor;
    model.titleFont = self.titleFont;
    return model;
}

@end
