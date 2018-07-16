//
//  ZPZTabBarItem.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZTabBarItem.h"
#import "ZPZTabBarModel.h"

@implementation ZPZTabBarItem

- (instancetype)initWithItemSource:(ZPZTabBarModel *)itemModel andEventBlock:(ZPZTabBarclickedTabItem)eventBlock {
    self = [super init];
    if (self) {
        _clickedItem = eventBlock;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedItem)];
        [self addGestureRecognizer:tapGes];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconImageView];
        
        _redDotImgView = [[UIImageView alloc] init];
        _redDotImgView.backgroundColor = [UIColor clearColor];
        _redDotImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_redDotImgView];
        
        [self updateItemWithModel:itemModel];
    }
    return self;
}

- (void)updateItemWithModel:(ZPZTabBarModel *)itemModel {
    _itemModel = [itemModel copy];
    _titleLabel.frame = itemModel.titleFrame;
    _iconImageView.frame = itemModel.imageFrame;
    
    _titleLabel.text = itemModel.title;
    _titleLabel.font = itemModel.titleFont;
    if (itemModel.isSelected) {
        _titleLabel.textColor = itemModel.selectedTitleColor;
        _iconImageView.image = [UIImage imageNamed:itemModel.selectIconImageStr];
    } else {
        _iconImageView.image = [UIImage imageNamed:itemModel.normalIconImageStr];
        _titleLabel.textColor = itemModel.normalTitleColor;
    }
    _redDotImgView.frame = itemModel.redDotFrame;
    _redDotImgView.image = [UIImage imageNamed:itemModel.redDotImageStr];
    if (itemModel.isHaveRedDot) {
        _redDotImgView.hidden = NO;
    } else {
        _redDotImgView.hidden = YES;
    }
}

- (void)tapedItem {
    if (_clickedItem) {
        _clickedItem(self);
    }
}

@end
