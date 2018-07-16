//
//  ZPZAlertField.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZAlertField.h"
#import "ZPZPublicManager.h"
#import "ZPZProjectConstant.h"
#import "ZPZCustomField.h"
#import "ZPZAppDelegate.h"

#define kBaseTag 10000

static CGFloat titleHeight = 50;
static CGFloat actionHeight = 50;
static CGFloat margin = kProjectMargin;
static CGFloat contentFieldHeight = 36;
static CGFloat contentWidth = 280;

@interface ZPZAlertField()

@property (nonatomic, strong) UIView * containerView;
//@property (nonatomic, strong) MYCustomField * contentField;
@property (nonatomic, strong) NSMutableArray<ZPZCustomField *> * contentFields;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, copy) NSArray<ZPZAlertModel *> * actionModels;
@property (nonatomic, copy) void(^eventSingleFiledHander)(ZPZAlertModel * action, NSString * content, NSInteger index);
@property (nonatomic, copy) void(^eventFiledsHander)(ZPZAlertModel * action, NSArray<NSString *> * contentArr, NSInteger index);

@end

@implementation ZPZAlertField

- (NSString *)fieldContent {
    return _contentFields.firstObject.currentContent;
}

+ (ZPZAlertField *)showAlertViewInView:(UIView *)containerView andTitleModel:(ZPZAlertModel *)titleModel contentModel:(ZPZAlertModel *)contentModel andActionModels:(NSArray<ZPZAlertModel *> *)actionModels andEventHandler:(void (^)(ZPZAlertModel *, NSString *, NSInteger))hanlder {
    if (titleModel == nil || contentModel == nil || actionModels.count == 0) {
        return nil;
    }
    ZPZAlertField * field = [self showAlertViewInView:containerView andTitleModel:titleModel contentModels:@[contentModel] andActionModels:actionModels andEventHandler:nil];
    field.eventSingleFiledHander = hanlder;
    return field;
}

+ (ZPZAlertField *)showAlertViewInView:(UIView *)containerView andTitleModel:(ZPZAlertModel *)titleModel contentModels:(NSArray<ZPZAlertModel *> *)contentModel andActionModels:(NSArray<ZPZAlertModel *> *)actionModels andEventHandler:(void (^)(ZPZAlertModel *, NSArray<NSString *> *, NSInteger))hanlder {
    if (containerView == nil) {
        containerView = [ZPZPublicManager appDelegate].window;
    }
    if (titleModel == nil || contentModel.count == 0 || actionModels.count == 0) {
        return nil;
    }
    CGFloat width = CGRectGetWidth(containerView.frame);
    CGFloat height = CGRectGetHeight(containerView.frame);
    ZPZAlertField * alertField = [[ZPZAlertField alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    alertField.backgroundColor = [UIColor clearColor];
    alertField.alpha = 0;
    alertField.contentFields = [NSMutableArray array];
    
    alertField.containerView = containerView;
    alertField.actionModels = actionModels;
    alertField.eventFiledsHander = hanlder;
    [[NSNotificationCenter defaultCenter] addObserver:alertField selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:alertField selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    UIView * contentBacView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    contentBacView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [alertField addSubview:contentBacView];
    UITapGestureRecognizer * bacTapGes = [[UITapGestureRecognizer alloc] initWithTarget:alertField action:@selector(tapedBacToEndEditing)];
    [contentBacView addGestureRecognizer:bacTapGes];
    
    CGFloat contentHeight = titleHeight + margin * 2 + actionHeight + contentFieldHeight * contentModel.count + (contentModel.count - 1) * kProjectMargin;
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(width / 2 - contentWidth / 2, height / 2 - contentHeight / 2, contentWidth, contentHeight)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 4;
    contentView.layer.masksToBounds = YES;
    [alertField addSubview:contentView];
    
    alertField.contentView = contentView;
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, contentWidth - 2 * margin, titleHeight)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = titleModel.textColor;
    titleLabel.font = titleLabel.font;
    titleLabel.text = titleModel.text;
    titleLabel.textAlignment = titleModel.alignment;
    [contentView addSubview:titleLabel];
    
    UIView * topSepView = [[UIView alloc] initWithFrame:CGRectMake(margin, titleHeight, contentWidth - 2 * margin, 0.5)];
    topSepView.backgroundColor = [ZPZPublicManager colorWithHexString:kSepLineColor_e4e4e4];
    [contentView addSubview:topSepView];
    
    __block CGFloat beginY = CGRectGetMaxY(topSepView.frame) + margin;
    
    [contentModel enumerateObjectsUsingBlock:^(ZPZAlertModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView * fieldBacView = [[UIView alloc] initWithFrame:CGRectMake(margin, beginY, contentWidth - 2 * margin, contentFieldHeight)];
        fieldBacView.backgroundColor = obj.bacColor;
        
        ZPZCustomField * customField = [ZPZCustomField showCustomFieldWithDataModel:obj.contentFieldModel andFrame:CGRectMake(5, 0, fieldBacView.frame.size.width - 2 * 5, fieldBacView.frame.size.height) andEventHandle:nil];
        customField.backgroundColor = [UIColor clearColor];
        [alertField.contentFields addObject:customField];
        [fieldBacView addSubview:customField];
        [contentView addSubview:fieldBacView];
        beginY = beginY + contentFieldHeight + kProjectMargin;
    }];
    
    UIView * bottomSepView = [[UIView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(alertField.contentFields.lastObject.superview.frame) + margin, contentWidth - 2 * margin, 0.5)];
    bottomSepView.backgroundColor = [ZPZPublicManager colorWithHexString:kSepLineColor_e4e4e4];
    [contentView addSubview:bottomSepView];
    
    CGFloat actionWidth = contentView.frame.size.width / actionModels.count;
    [actionModels enumerateObjectsUsingBlock:^(ZPZAlertModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.backgroundColor = [UIColor clearColor];
        [actionBtn setTitle:obj.text forState:UIControlStateNormal];
        actionBtn.titleLabel.font = obj.textFont;
        [actionBtn setTitleColor:obj.textColor forState:UIControlStateNormal];
        actionBtn.tag = kBaseTag + idx;
        actionBtn.frame = CGRectMake(actionWidth * idx, CGRectGetMaxY(bottomSepView.frame), actionWidth, actionHeight);
        [actionBtn addTarget:alertField action:@selector(clickedActionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:actionBtn];
        
        if (idx != actionModels.count - 1) {
            UIView * sepView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(actionBtn.frame), margin + CGRectGetMinY(actionBtn.frame), 0.5, actionHeight - 2 * margin)];
            sepView.backgroundColor = [ZPZPublicManager colorWithHexString:kSepLineColor_e4e4e4];
            [contentView addSubview:sepView];
        }
    }];
    [alertField showAlertField];
    return alertField;
}

- (void)showAlertField {
    [_containerView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }];
}

- (void)tapedBacToEndEditing {
    __block BOOL isEditing = NO;
    [_contentFields enumerateObjectsUsingBlock:^(ZPZCustomField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isFieldFirstResponder) {
            isEditing = YES;
            *stop = YES;
        }
    }];
    if (isEditing) {
        [self endEditing:YES];
        return;
    }
    
    [self removeFromSuperview];
}

- (void)clickedActionBtn:(UIButton *)btn {
    [self endEditing:YES];
    [self removeFromSuperview];
    NSInteger index = btn.tag - kBaseTag;
    if (index >= _actionModels.count) {
        return;
    }
    if (_eventSingleFiledHander) {
        _eventSingleFiledHander(_actionModels[index], _contentFields.firstObject.currentContent, index);
    }
    NSMutableArray * contentArr = [NSMutableArray array];
    [_contentFields enumerateObjectsUsingBlock:^(ZPZCustomField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.currentContent) {
            [contentArr addObject:obj.currentContent];
        } else {
            [contentArr addObject:@""];
        }
    }];
    if (_eventFiledsHander) {
        _eventFiledsHander(_actionModels[index], contentArr, index);
    }
}

#pragma mark - Notification
- (void)keyboardWillShow:(NSNotification *)noti {
    NSDictionary * infoDic = noti.userInfo;
    CGRect keyboardFrame = [infoDic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    NSTimeInterval interval = [infoDic[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    UIView * editField = _contentView;
    CGRect convertFrame = [editField.superview convertRect:editField.frame toView:self];
    if (CGRectGetMaxY(convertFrame) > keyboardFrame.origin.y) {
        [UIView animateWithDuration:interval animations:^{
            self.bounds = CGRectMake(0, CGRectGetMaxY(convertFrame) - keyboardFrame.origin.y, self.frame.size.width, self.frame.size.height);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)noti {
    NSDictionary * infoDic = noti.userInfo;
    NSTimeInterval interval = [infoDic[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    [UIView animateWithDuration:interval animations:^{
        self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ released", NSStringFromClass(self.class));
}

@end
