//
//  ZPZSinglePickerView.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPZSinglePickerModel;

@interface ZPZSinglePickerView : UIView

+ (ZPZSinglePickerView *)showPickerViewWithData:(NSArray<ZPZSinglePickerModel *> *)pickers andCompletion:(void(^)(NSInteger index))complete andCancelBlock:(void(^)())cancel;

@end
