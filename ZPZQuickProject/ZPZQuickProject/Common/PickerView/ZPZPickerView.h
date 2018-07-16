//
//  ZPZPickerView.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPZPickerView : UIView

@property (nonatomic, copy) NSInteger(^numberOfComponentsInMYPickerView)(ZPZPickerView * pickerView);
@property (nonatomic, copy) NSInteger(^numberOfRowsInComponents)(ZPZPickerView * pickerView, NSInteger compIndex);
// 有默认值
@property (nonatomic, copy) CGFloat(^rowHeightOfMYPickerViewInComponents)(ZPZPickerView * pickerView, NSInteger compIndex);
@property (nonatomic, copy) NSString *(^contentOfRowsOfMYPickerViewInComponents)(ZPZPickerView * pickerView, NSInteger compIndex, NSInteger rowIndex);
@property (nonatomic, copy) void(^scrollToSelectedRowsOfComponent)(ZPZPickerView * pickerView, NSInteger compIndex, NSInteger rowIndex);

- (instancetype)initWithCompletion:(void(^)(void))complete andCancelBlock:(void(^)(void))cancel;
- (void)reloadPickerView;
- (void)reloadPickerViewAtCompIndex:(NSInteger)compIndex;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)compIndex animated:(BOOL)animated;
- (void)showPickerView;

@end
