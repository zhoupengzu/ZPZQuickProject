//
//  ZPZPickerView.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZPickerView.h"
#import "ZPZAppDelegate.h"
#import "ZPZProjectConstant.h"
#import "ZPZPublicManager.h"

static CGFloat contentHeight = 260;
static CGFloat kMYPickerViewDefaultRowHeight = 32;

@interface ZPZPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) void(^selectedBlock)(void);
@property (nonatomic, copy) void(^cancelOperation)(void);
@property (nonatomic, strong) UIPickerView * pickerView;
@property (nonatomic, strong) UIView * contentView;

@end

@implementation ZPZPickerView

- (instancetype)initWithCompletion:(void(^)(void))complete andCancelBlock:(void(^)(void))cancel {
    self = [super initWithFrame:CGRectMake(0, 0, kProjectMainScreenWidth, kProjectMainScreenHeight)];
    if (self) {
        _selectedBlock = complete;
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedToCancel)];
        [self addGestureRecognizer:tapGes];
        
        UIView * bacView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kProjectMainScreenWidth, kProjectMainScreenHeight)];
        bacView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        [self addSubview:bacView];
        
        UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, contentHeight)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(kProjectMargin, 0, 45, 45);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:17];
        [cancelBtn addTarget:self action:@selector(clickedToCancel) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitleColor:[ZPZPublicManager colorWithHexString:@"#0076FF"] forState:UIControlStateNormal];
        [contentView addSubview:cancelBtn];
        
        UIButton* completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        completeBtn.frame = CGRectMake(contentView.frame.size.width - kProjectMargin - 45, 0, 45, 45);
        [completeBtn setTitle:@"确定" forState:UIControlStateNormal];
        completeBtn.titleLabel.font = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:17];
        [completeBtn addTarget:self action:@selector(clickedToConfirm) forControlEvents:UIControlEventTouchUpInside];
        [completeBtn setTitleColor:[ZPZPublicManager colorWithHexString:@"#0076FF"] forState:UIControlStateNormal];
        [contentView addSubview:completeBtn];
        
        UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cancelBtn.frame), contentView.frame.size.width, 0.5)];
        line.backgroundColor = [ZPZPublicManager colorWithHexString:kSepLineColor_e4e4e4];
        [contentView addSubview:line];
        
        UIPickerView * pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), contentView.frame.size.width, contentView.frame.size.height - CGRectGetMaxY(line.frame))];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [contentView addSubview:pickerView];
        self.pickerView = pickerView;
        [pickerView reloadAllComponents];
    }
    return self;
}

- (void)showPickerView {
    [self reloadPickerView];
    if (self.superview) {
        return;
    }
    [[ZPZPublicManager appDelegate].window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        _contentView.frame = CGRectMake(0, self.frame.size.height - contentHeight, _contentView.frame.size.width, contentHeight);
    }];
}

- (void)reloadPickerView {
    [_pickerView reloadAllComponents];
}

- (void)reloadPickerViewAtCompIndex:(NSInteger)compIndex {
    [_pickerView reloadComponent:compIndex];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)compIndex animated:(BOOL)animated {
    [_pickerView selectRow:row inComponent:compIndex animated:animated];
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
    [self hanlderConfirmEvent];
}

- (void)hanlderConfirmEvent {
    if (_selectedBlock) {
        _selectedBlock();
    }
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    if (_numberOfComponentsInMYPickerView) {
        return _numberOfComponentsInMYPickerView(self);
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_numberOfRowsInComponents) {
        return _numberOfRowsInComponents(self, component);
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    if (_rowHeightOfMYPickerViewInComponents) {
        return _rowHeightOfMYPickerViewInComponents(self, component);
    }
    return kMYPickerViewDefaultRowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel  *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil)
    {
        
        pickerLabel = [[UILabel alloc]init];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.font = [ZPZPublicManager getFontWithFontName:kFontName_PingFangSC_Regular andFontSize:18];
        pickerLabel.backgroundColor = [UIColor clearColor];
    }
    //    给picker 添加内容
    if (_contentOfRowsOfMYPickerViewInComponents) {
        pickerLabel.text = _contentOfRowsOfMYPickerViewInComponents(self, component, row);
    } else {
        pickerLabel.text = @"";
    }
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_scrollToSelectedRowsOfComponent) {
        _scrollToSelectedRowsOfComponent(self, component, row);
    }
}

- (void)dealloc {
    NSLog(@"%@ released", NSStringFromClass(self.class));
}

@end
