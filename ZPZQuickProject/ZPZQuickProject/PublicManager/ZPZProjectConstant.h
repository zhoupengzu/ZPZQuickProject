//
//  ZPZProjectConstant.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#ifndef ZPZProjectConstant_h
#define ZPZProjectConstant_h

#define kIsFirstLaunchKey_UD @"isFirst"    // 是否是第一次启动的键
#define kIsFirstLaunchValue_UD @"first"    // 第一次启动的保存的值
// 直辖市
#define kProvinceLevelCity @[@"500000",@"310000",@"110000",@"120000"]

// 第三方的一些key等
// 麦芽 天机客服系统 渠道编码
#define kMYKeFuChannel   @"MY0MZ0KF0CRM01"
// 魔蝎
#define kMoXieApiKey @"6db573018bc7433da2d91fdc9c2a206b"

// qq的URL
#define kQQURL @"mqq://"

// App Store链接
#define kAppStoreLink @"itms-apps://itunes.apple.com/app/id1153218426"
#define kAppCompanyName @"北京买呀科技发展有限公司"

// 密码限制提示
#define kPwdTip @"密码长度为6～16位，至少包含数字、字母或者字符中的两种"

// 电话客服
#define kDefaultOnLineServicePhone @"1010-0668"
#define kDefaultOnLineServiceTime @"服务时间 09:00-21:00"

#define kProjectMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define kProjectMainScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kProjectMargin 15
#define kSepLineHeight 0.5

// 导航栏左侧返回按钮
#define kNavLeftBtnImgName @"icon_back"
#define kNavLeftWhiteBtnImageName @"icon_back_white"
#define kNavLeftBtnImgSize CGSizeMake(26, 26)

// 注册等成功和失败图片
#define kToastSuccessImg @"success"
#define kToastFailedImg @"fail"

// 启动广告页默认展示内容
#define kDefaultLaunchForIPhone4 @"iPhone4_default_lunch"
#define kDefaultLaunchForIPhone5 @"iPhone5_default_lunch"
#define kDefaultLaunchForIPhone7p @"iPhone7p_default_lunch"
#define kDefaultLaunchForIPhone8 @"iPhone8_default_lunch"
#define kDefaultLaunchForIPhoneX @"iPhoneX_default_lunch"

// 字体名称
#define kFontName_PingFangSC_Regular @"PingFangSC-Regular"
#define kFontName_PingFangSC_Light @"PingFangSC-Light"
#define kFontName_Helvetica_Bold @"Helvetica-Bold"
#define kFontName_PingFangSC_Medium @"PingFangSC-Medium"

// 颜色
#define kDeepTextColor_4a4a4a @"#4a4a4a"
#define kLightTextColor_c4c4c4 @"#c4c4c4"
#define kTextColor_ffc700 @"#FFC700"
#define kSepLineColor_e4e4e4 @"#e4e4e4"
#define kBaseColor_f9f9f9 @"#f9f9f9"
#define kPlaceHolderColor_dedede @"#dedede"
#define kYellowColor_ffd643 @"#ffd643"

// 按钮相关
#define kBtnNormalBacColor_fae69b @"#fae69b"
#define kBtnHighlightBacColor_efca36 @"#efca36"
#define kBtnDisabledBacColor_fae69b @"#fae69b"
#define kBtnNormalTitleColor_4a4a4a @"#4a4a4a"
#define kBtnDisabledTitleColor_a49975 @"#a49975"

// 通知
#define kNotificationLogin @"login_in"
#define kNotificationLoginOut @"login_out"

#endif /* ZPZProjectConstant_h */
