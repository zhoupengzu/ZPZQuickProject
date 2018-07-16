//
//  ZPZUITextView.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPZUILabel.h"

@interface ZPZUITextView : UITextView

@property (nonatomic, copy) NSString * placeHoldStr;
@property (nonatomic, strong) UIColor * placeHoldColor;

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

- (void)hidePlaceHolder;
- (void)showPlaceHolder;

@end
