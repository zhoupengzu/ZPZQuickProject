//
//  ZPZAlertModel.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZAlertModel.h"
#import "ZPZPublicManager.h"
#import "ZPZProjectConstant.h"

@implementation ZPZAlertModel

-(instancetype)init {
    self = [super init];
    if (self) {
        _alignment = NSTextAlignmentLeft;
        _bacColor = [UIColor clearColor];
        [self defaultTitleAndContentColorAndFont];
    }
    return self;
}

- (void)useDefaultActionColorAndFont {
    _textFont = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:17];
    _textColor = [ZPZPublicManager colorWithHexString:kTextColor_ffc700];
}

- (void)useDefaultTitleColorAndFont {
    _alignment = NSTextAlignmentCenter;
    [self defaultTitleAndContentColorAndFont];
}

- (void)useDefaultContentColorAndFont {
    [self defaultTitleAndContentColorAndFont];
}

- (void)useDefaultTipContentColorAndFont {
    _textColor = [UIColor colorWithWhite:119 / 255.f alpha:1];
    _textFont = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:12];
}

- (void)defaultTitleAndContentColorAndFont {
    _textFont = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:15];
    _textColor = [ZPZPublicManager colorWithHexString:kDeepTextColor_4a4a4a];
}

+ (ZPZAlertModel *)convienceForTitleWithTitle:(NSString *)title {
    ZPZAlertModel * model = [[ZPZAlertModel alloc] init];
    [model useDefaultTitleColorAndFont];
    model.alignment = NSTextAlignmentCenter;
    model.text = title;
    return model;
}

+ (ZPZAlertModel *)convienceForContentWithContent:(NSString *)content {
    ZPZAlertModel * model = [[ZPZAlertModel alloc] init];
    [model useDefaultContentColorAndFont];
    model.alignment = NSTextAlignmentCenter;
    model.text = content;
    return model;
}

+ (ZPZAlertModel *)convienceForTipContentWithTip:(NSString *)tip {
    ZPZAlertModel * model = [[ZPZAlertModel alloc] init];
    [model useDefaultTipContentColorAndFont];
    model.alignment = NSTextAlignmentCenter;
    model.text = tip;
    return model;
}

+ (NSArray<ZPZAlertModel *> *)convienceForActionWithTitleArr:(NSArray<NSString *> *)titleArr {
    NSMutableArray * actionArr = [NSMutableArray array];
    [titleArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZPZAlertModel * action = [[ZPZAlertModel alloc] init];
        action.text = obj;
        [action useDefaultActionColorAndFont];
        [actionArr addObject:action];
    }];
    return actionArr;
}

@end
