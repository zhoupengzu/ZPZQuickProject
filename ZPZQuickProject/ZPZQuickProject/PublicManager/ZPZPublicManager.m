//
//  ZPZPublicManager.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZPublicManager.h"
#import "ZPZAppDelegate.h"
#import "ZPZProjectConstant.h"
#import "ZPZPublicManager+Device.h"

@implementation ZPZPublicManager

+ (BOOL)isFirstLaunch {
    BOOL isFirst = YES;
    NSString * isFirstStr = [[NSUserDefaults standardUserDefaults] objectForKey:kIsFirstLaunchKey_UD];
    if ([isFirstStr isKindOfClass:[NSString class]] && [isFirstStr isEqualToString:kIsFirstLaunchValue_UD]) {
        isFirst = NO;
    }
    return isFirst;
}
+ (void)recordFirstLaunch {
    if ([self isFirstLaunch]) {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:kIsFirstLaunchValue_UD forKey:kIsFirstLaunchKey_UD];
    }
}

+ (ZPZAppDelegate *)appDelegate {
    id delegate = [UIApplication sharedApplication].delegate;
    if ([delegate isKindOfClass:[ZPZAppDelegate class]]) {
        return (ZPZAppDelegate *)delegate;
    }
    return nil;
}

+ (UIFont *)getFontWithFontName:(NSString *)fontName andFontSize:(CGFloat)fontSize {
    UIFont * font = [UIFont fontWithName:fontName size:fontSize];
    if (font == nil) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

+ (NSArray<NSString *> *)guideImages {
    __block NSArray * guideArr = @[@"liuchengjiandan6p", @"fangkuan6p", @"edugao6p", @"huankuan6p"];
    NSArray<NSNumber *> * screenSeries = [self currentScreenSeries];
    [screenSeries enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (obj.integerValue) {
            case ZPZDeviceGenerationIphone_SE:
            case ZPZDeviceGenerationIphone_5:
            case ZPZDeviceGenerationIphone_5c:
            case ZPZDeviceGenerationIphone_5s:{
                guideArr = @[@"liuchengjiandan5", @"fangkuan5", @"edugao5", @"huankuan5"];
                * stop = YES;
            }
                break;
            case ZPZDeviceGenerationIphone_6:
            case ZPZDeviceGenerationIphone_7:
            case ZPZDeviceGenerationIphone_8:
            case ZPZDeviceGenerationIphone_6s:{
                guideArr = @[@"liuchengjiandan6", @"fangkuan6", @"edugao6", @"huankuan6"];
                * stop = YES;
            }
                break;
            case ZPZDeviceGenerationIphone_6P:
            case ZPZDeviceGenerationIphone_6sP:
            case ZPZDeviceGenerationIphone_7P:
            case ZPZDeviceGenerationIphone_8P:{
                guideArr = @[@"liuchengjiandan6p",@"fangkuan6p",@"edugao6p",@"huankuan6p"];
                * stop = YES;
            }
                break;
            default:{
                * stop = YES;
            }
                break;
        }
    }];
    return guideArr;
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
