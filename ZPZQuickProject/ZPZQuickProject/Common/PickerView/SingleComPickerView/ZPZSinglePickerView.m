//
//  ZPZSinglePickerView.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZSinglePickerView.h"
#import "ZPZSinglePickerModel.h"
#import "ZPZAppDelegate.h"
#import "ZPZProjectConstant.h"
#import "ZPZPublicManager.h"

static CGFloat contentHeight = 260;

@interface ZPZSinglePickerView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) void(^selectedBlock)(NSInteger index);
@property (nonatomic, copy) void(^cancelOperation)(void);
@property (nonatomic, strong) UIPickerView * pickerView;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, copy) NSArray<ZPZSinglePickerModel *> * dataSource;

@end

@implementation ZPZSinglePickerView

+ (ZPZSinglePickerView *)showPickerViewWithData:(NSArray<ZPZSinglePickerModel *> *)pickers andCompletion:(void(^)(NSInteger index))complete andCancelBlock:(void(^)(void))cancel {
    ZPZSinglePickerView * singleView = [[ZPZSinglePickerView alloc] initWithFrame:CGRectMake(0, 0, kProjectMainScreenWidth, kProjectMainScreenHeight)];
    singleView.backgroundColor = [UIColor clearColor];
    singleView.alpha = 0;
    singleView.selectedBlock = complete;
    singleView.cancelOperation = cancel;
    //    [[MYPublicManager appDelegate].window addSubview:singleView];
    [[UIApplication sharedApplication].delegate.window addSubview:singleView];
    
    singleView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:singleView action:@selector(clickedToCancel)];
    [singleView addGestureRecognizer:tapGes];
    
    UIView * bacView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kProjectMainScreenWidth, kProjectMainScreenHeight)];
    bacView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [singleView addSubview:bacView];
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, singleView.frame.size.height, singleView.frame.size.width, contentHeight)];
    contentView.backgroundColor = [UIColor whiteColor];
    [singleView addSubview:contentView];
    singleView.contentView = contentView;
    
    UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(kProjectMargin, 0, 45, 45);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:17];
    [cancelBtn addTarget:singleView action:@selector(clickedToCancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[ZPZPublicManager colorWithHexString:@"#0076FF"] forState:UIControlStateNormal];
    [contentView addSubview:cancelBtn];
    
    UIButton* completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completeBtn.frame = CGRectMake(contentView.frame.size.width - kProjectMargin - 45, 0, 45, 45);
    [completeBtn setTitle:@"确定" forState:UIControlStateNormal];
    completeBtn.titleLabel.font = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:17];
    [completeBtn addTarget:singleView action:@selector(clickedToConfirm) forControlEvents:UIControlEventTouchUpInside];
    [completeBtn setTitleColor:[ZPZPublicManager colorWithHexString:@"#0076FF"] forState:UIControlStateNormal];
    [contentView addSubview:completeBtn];
    
    UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cancelBtn.frame), contentView.frame.size.width, 0.5)];
    line.backgroundColor = [ZPZPublicManager colorWithHexString:kSepLineColor_e4e4e4];
    [contentView addSubview:line];
    
    UIPickerView * pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), contentView.frame.size.width, contentView.frame.size.height - CGRectGetMaxY(line.frame))];
    pickerView.delegate = singleView;
    pickerView.dataSource = singleView;
    [contentView addSubview:pickerView];
    singleView.pickerView = pickerView;
    singleView.dataSource = pickers;
    [pickerView reloadAllComponents];
    // 找到选中的
    [singleView updatePickerViewSelectedRow];
    [UIView animateWithDuration:0.3 animations:^{
        singleView.alpha = 1;
        contentView.frame = CGRectMake(0, singleView.frame.size.height - contentHeight, contentView.frame.size.width, contentHeight);
    }];
    
    return singleView;
}

- (void)updatePickerViewSelectedRow {
    __weak ZPZSinglePickerView * weakSelf = self;
    [self.dataSource enumerateObjectsUsingBlock:^(ZPZSinglePickerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            [weakSelf.pickerView selectRow:idx inComponent:0 animated:YES];
            *stop = YES;
        }
    }];
}

- (void)clickedToCancel {
    if (_cancelOperation) {
        _cancelOperation();
    }
    [self hidePickerView];
}

- (void)hidePickerView {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        _contentView.frame = CGRectMake(0, self.frame.size.height, _contentView.frame.size.width, contentHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickedToConfirm {
    [self hidePickerView];
    NSInteger selectedIndex = [_pickerView selectedRowInComponent:0];
    if (_selectedBlock) {
        _selectedBlock(selectedIndex);
    }
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 32;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel  *pickerLabel = (UILabel *)view;
    if ((pickerLabel == nil) || [pickerLabel isKindOfClass:[UILabel class]])
    {
        CGRect frame =  CGRectMake(0, 0, 270, 32);
        pickerLabel = [[UILabel alloc]initWithFrame:frame];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:18];
        pickerLabel.backgroundColor = [UIColor clearColor];
    }
    //    给picker 添加内容
    if (row >= self.dataSource.count) {
        return pickerLabel;
    }
    pickerLabel.text = self.dataSource[row].showValue;
    return pickerLabel;
}

- (void)dealloc {
    NSLog(@"%@ released", NSStringFromClass(self.class));
}

@end
