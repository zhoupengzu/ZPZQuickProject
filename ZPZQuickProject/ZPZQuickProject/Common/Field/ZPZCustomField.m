//
//  ZPZCustomField.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZCustomField.h"
#import "ZPZCountTimeButton.h"
#import "ZPZCustomFieldModel.h"
#import "UIImageView+WebCache.h"

@interface ZPZCustomField()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UITextField * contentField;
@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) ZPZCountTimeButton * button;
@property (nonatomic, copy) void(^eventHandler)(ZPZCustomFieldModel * currModel);
@property (nonatomic, strong) ZPZCustomFieldModel * currModel;

@end

@implementation ZPZCustomField

- (NSString *)currentContent {
    return _contentField.text;
}

- (BOOL)isFieldFirstResponder {
    return _contentField.isFirstResponder;
}

+ (ZPZCustomField *)showCustomFieldWithDataModel:(ZPZCustomFieldModel *)model andFrame:(CGRect)frame andEventHandle:(void (^)(ZPZCustomFieldModel *))eventHandle {
    ZPZCustomField * field = [[ZPZCustomField alloc] initWithFrame:frame];
    field.backgroundColor = [UIColor whiteColor];
    field.eventHandler = eventHandle;
    
    UITextField * contexField = [[UITextField alloc] init];
    contexField.backgroundColor = [UIColor clearColor];
    contexField.delegate = field;
    field.contentField = contexField;
    contexField.secureTextEntry = model.isNeedSecurity;
    [field addSubview:contexField];
    // 添加除field之外第一个控件
    switch (model.type) {
        case ZPZCustomFieldTypeDefault: { }
            break;
        case ZPZCustomFieldTypeTitle:
        case ZPZCustomFieldTypeTitle_Img:
        case ZPZCustomFieldTypeTitle_Msg:
        case ZPZCustomFieldTypeTitle_MsgCode_Bac: {
            UILabel * titleLabel = [[UILabel alloc] init];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            field.titleLabel = titleLabel;
            [field addSubview:titleLabel];
        }
            break;
        default:
            break;
    }
    // 添加除field之外的第二个控件
    switch (model.type) {
        case ZPZCustomFieldTypeDefault:
        case ZPZCustomFieldTypeTitle: { }
            break;
        case ZPZCustomFieldTypeTitle_Img: {
            UIImageView * imgView = [[UIImageView alloc] init];
            imgView.backgroundColor = [UIColor clearColor];
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            imgView.clipsToBounds = YES;
            field.imgView = imgView;
            [field addSubview:imgView];
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:field action:@selector(clickedOrTapedToHandleEvent)];
            [imgView addGestureRecognizer:tapGes];
        }
            break;
        case ZPZCustomFieldTypeTitle_MsgCode:
        case ZPZCustomFieldTypeTitle_MsgCode_Bac:
        case ZPZCustomFieldTypeField_MsgCode: {
            ZPZCountTimeButton * timeBtn = [ZPZCountTimeButton buttonWithType:UIButtonTypeCustom];
            timeBtn.layer.cornerRadius = 4;
            timeBtn.layer.masksToBounds = YES;
            field.button = timeBtn;
            timeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [timeBtn addTarget:field action:@selector(clickedOrTapedToHandleEvent) forControlEvents:UIControlEventTouchUpInside];
            [field addSubview:timeBtn];
        }
            break;
        default:
            break;
    }
    [field updateCustomFieldWithModel:model];
    return field;
}

- (void)updateCustomFieldWithModel:(ZPZCustomFieldModel *)updateModel {
    if (_currModel && _currModel.type != updateModel.type) {
        return;
    }
    _currModel = updateModel;
    [self updateSubViewsContent];
    [self updateSubViewsFrameAndStyle];
}

- (void)updateSubViewsContent {
    _contentField.attributedPlaceholder = _currModel.placeHolderAttr;
    _contentField.text = _currModel.fieldContent;
    _contentField.userInteractionEnabled = _currModel.canEdited;
    switch (_currModel.type) {
        case ZPZCustomFieldTypeDefault: { }
            break;
        case ZPZCustomFieldTypeTitle:
        case ZPZCustomFieldTypeTitle_Img:
        case ZPZCustomFieldTypeTitle_Msg:
        case ZPZCustomFieldTypeTitle_MsgCode_Bac: {
            _titleLabel.text = _currModel.title;
        }
            break;
        default:
            break;
    }
    switch (_currModel.type) {
        case ZPZCustomFieldTypeDefault:
        case ZPZCustomFieldTypeTitle: { }
            break;
        case ZPZCustomFieldTypeTitle_Img: {
            [_imgView sd_setImageWithURL:[NSURL URLWithString:_currModel.imgUrlStr] placeholderImage:_currModel.showImg];
        }
            break;
        case ZPZCustomFieldTypeTitle_Msg:
        case ZPZCustomFieldTypeTitle_MsgCode_Bac:
        case ZPZCustomFieldTypeField_MsgCode: {
            _button.defaultTitle = _currModel.msgDefaultTitle;
            _button.resetTitle = _currModel.msgResetTitle;
        }
            break;
        default:
            break;
    }
}

- (void)updateSubViewsFrameAndStyle {
    _contentField.font = _currModel.fieldContentFont;
    _contentField.textColor = _currModel.fieldContentColor;
    CGFloat leftWidth = CGRectGetWidth(self.frame);
    CGFloat contentBeginX = 0;
    switch (_currModel.type) {
        case ZPZCustomFieldTypeDefault: { }
            break;
        case ZPZCustomFieldTypeTitle:
        case ZPZCustomFieldTypeTitle_Img:
        case ZPZCustomFieldTypeTitle_Msg:
        case ZPZCustomFieldTypeTitle_MsgCode_Bac: {
            _titleLabel.textColor = _currModel.titleColor;
            _titleLabel.font = _currModel.titleFont;
            if (_titleLabel.font == nil) {
                _titleLabel.font = [UIFont systemFontOfSize:15];
            }
            CGSize titleSize = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName: _titleLabel.font}];
            titleSize.width = ceilf(titleSize.width) + 2 * _currModel.contentLRMargin;
            _titleLabel.frame = CGRectMake(0, 0, ceilf(titleSize.width), CGRectGetHeight(self.frame));
        }
            break;
        default:
            break;
    }
    switch (_currModel.type) {
        case ZPZCustomFieldTypeDefault:
        case ZPZCustomFieldTypeTitle: { }
            break;
        case ZPZCustomFieldTypeTitle_Img: {
            _imgView.frame = CGRectMake(CGRectGetWidth(self.frame) - _currModel.imgSize.width, CGRectGetHeight(self.frame) / 2 - _currModel.imgSize.height / 2, _currModel.imgSize.width, _currModel.imgSize.height);
        }
            break;
        case ZPZCustomFieldTypeTitle_Msg:
        case ZPZCustomFieldTypeField_MsgCode: {
            _button.disableColor = _currModel.msgCodeDisableColor;
            _button.normalColor = _currModel.msgNormalColor;
            if (_currModel.msgCodeFont == nil) {
                _currModel.msgCodeFont = [UIFont systemFontOfSize:15];
            }
            _button.titleLabel.font = _currModel.msgCodeFont;
            
            CGSize buttonSize = [_currModel.msgDefaultTitle sizeWithAttributes:@{NSFontAttributeName : _button.titleLabel.font}];
            buttonSize.width = ceilf(buttonSize.width) + 2 * _currModel.msgContentPadding;
            buttonSize.height = ceilf(buttonSize.height) + _currModel.msgContentPadding;
            _button.frame = CGRectMake(CGRectGetWidth(self.frame) - ceilf(buttonSize.width), CGRectGetHeight(self.frame) / 2 - ceilf(buttonSize.height) / 2, ceilf(buttonSize.width), ceilf(buttonSize.height));
        }
            break;
        case ZPZCustomFieldTypeTitle_MsgCode_Bac: {
            _button.disableColor = _currModel.msgCodeDisableColor;
            _button.normalColor = _currModel.msgNormalColor;
            _button.disableBacColor = _currModel.msgCodeDisableBacColor;
            _button.normalBacColor = _currModel.msgCodeNormalBacColor;
            if (_currModel.msgCodeFont == nil) {
                _currModel.msgCodeFont = [UIFont systemFontOfSize:15];
            }
            _button.titleLabel.font = _currModel.msgCodeFont;
            
            CGSize buttonSize = [_currModel.msgDefaultTitle sizeWithAttributes:@{NSFontAttributeName : _button.titleLabel.font}];
            buttonSize.width = ceilf(buttonSize.width) + 2 * _currModel.msgContentPadding;
            buttonSize.height = ceilf(buttonSize.height) + _currModel.msgContentPadding;
            _button.frame = CGRectMake(CGRectGetWidth(self.frame) - ceilf(buttonSize.width), CGRectGetHeight(self.frame) / 2 - ceilf(buttonSize.height) / 2, ceilf(buttonSize.width), ceilf(buttonSize.height));
        }
            break;
        default:
            break;
    }
    // 计算field的尺寸
    switch (_currModel.type) {
        case ZPZCustomFieldTypeDefault: {
            contentBeginX = _currModel.contentLRMargin;
            leftWidth = CGRectGetWidth(self.frame) - 2 * _currModel.contentLRMargin;
        }
            break;
        case ZPZCustomFieldTypeTitle: {
            contentBeginX = CGRectGetMaxX(_titleLabel.frame) + _currModel.contentLRMargin;
            leftWidth = leftWidth - CGRectGetMaxX(_titleLabel.frame) - _currModel.contentLRMargin;
        }
            break;
        case ZPZCustomFieldTypeTitle_Img: {
            contentBeginX = CGRectGetMaxX(_titleLabel.frame) + _currModel.contentLRMargin;
            leftWidth = leftWidth - CGRectGetMaxX(_titleLabel.frame) - _currModel.contentLRMargin;
            leftWidth = leftWidth - _currModel.imgSize.width - _currModel.contentLRMargin;
        }
            break;
        case ZPZCustomFieldTypeTitle_Msg:
        case ZPZCustomFieldTypeTitle_MsgCode_Bac: {
            contentBeginX = CGRectGetMaxX(_titleLabel.frame) + _currModel.contentLRMargin;
            leftWidth = leftWidth - CGRectGetMaxX(_titleLabel.frame) - _currModel.contentLRMargin;
            leftWidth = leftWidth - _button.frame.size.width - _currModel.contentLRMargin;
        }
            break;
        case ZPZCustomFieldTypeField_MsgCode: {
            contentBeginX = _currModel.contentLRMargin;
            leftWidth = CGRectGetMinX(_button.frame) - contentBeginX - _currModel.contentLRMargin;
        }
            break;
        default:
            break;
    }
    _contentField.frame = CGRectMake(contentBeginX, 0, leftWidth, CGRectGetHeight(self.frame));
}

#pragma mark - event
- (void)clickedOrTapedToHandleEvent {
    if (_eventHandler) {
        _eventHandler(_currModel);
    }
}

- (void)startCounting {
    switch (_currModel.type) {
        case ZPZCustomFieldTypeTitle_MsgCode:
        case ZPZCustomFieldTypeTitle_MsgCode_Bac:
        case ZPZCustomFieldTypeField_MsgCode: {
            [_button startWithTimeout:_currModel.timeoutInterval andFromatTitle:_currModel.countingFormat];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return _currModel.canEdited;
}

@end
