//
//  ZPZUILabel.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZPZLabelVerticalTextAlignment){
    ZPZLabelVerticalTextAlignmentMiddle,
    ZPZLabelVerticalTextAlignmentTop,
    ZPZLabelVerticalTextAlignmentBottom
};

@interface ZPZUILabel : UILabel

@property (nonatomic, assign) ZPZLabelVerticalTextAlignment verticalAlignment;

@end
