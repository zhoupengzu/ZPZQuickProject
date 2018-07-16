//
//  ZPZCustomFieldModel.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZCustomFieldModel.h"
#import "ZPZPublicManager.h"
#import "ZPZProjectConstant.h"

@implementation ZPZCustomFieldModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _type = ZPZCustomFieldTypeDefault;
        _countingFormat = @"%@秒后重新获取";
        _canEdited = YES;
    }
    return self;
}

+ (UIColor *)defaultTitleColor {
    return [ZPZPublicManager colorWithHexString:kDeepTextColor_4a4a4a];
}

+ (UIFont *)defaultTitleFont {
    return [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:15];
}

+ (UIColor *)defaultContentColor {
    return [UIColor colorWithWhite:119 / 255.f alpha:1];
}

+ (UIFont *)defaultContentFont {
    return [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:15];
}

+ (UIColor *)defaultContentPlaceHolderColor {
    return [ZPZPublicManager colorWithHexString:kPlaceHolderColor_dedede];
}

+ (NSAttributedString *)defaultContentPlaceHolderAttrWithStr:(NSString *)placeHolder {
    return [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSFontAttributeName: [self defaultContentFont], NSForegroundColorAttributeName : [self defaultContentPlaceHolderColor]}];
}

@end
