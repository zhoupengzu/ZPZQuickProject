//
//  ZPZCountTimeButton.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZCountTimeButton.h"

@interface ZPZCountTimeButton()
{
    dispatch_source_t _timer;
    NSTimeInterval _currInterval;
}

@end

@implementation ZPZCountTimeButton

- (instancetype)init {
    self = [super init];
    if (self) {
        _normalBacColor = _disableBacColor = [UIColor clearColor];
    }
    return self;
}

- (void)setDefaultTitle:(NSString *)defaultTitle {
    _defaultTitle = defaultTitle;
    [self setTitle:_defaultTitle forState:UIControlStateNormal];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    if (_disableColor == nil) {
        _disableColor = normalColor;
    }
    [self setTitleColor:_normalColor forState:UIControlStateNormal];
}

- (void)setNormalBacColor:(UIColor *)normalBacColor {
    _normalBacColor = normalBacColor;
    if (_disableBacColor == nil) {
        _disableBacColor = normalBacColor;
    }
    if (_timer && dispatch_source_testcancel(_timer) == 0) {
        return;
    }
    self.backgroundColor = _normalBacColor;
}

- (void)startWithTimeout:(NSTimeInterval)timeout andFromatTitle:(NSString *)formatTitle {
    if (_timer && dispatch_source_testcancel(_timer) == 0) {
        return;
    }
    self.enabled = NO;
    self.backgroundColor = _disableBacColor;
    _currInterval = timeout;
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (_currInterval <= 0) {
            [self stop];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:formatTitle, @(_currInterval)] forState:UIControlStateNormal];
                [self setTitleColor:_disableColor forState:UIControlStateNormal];
                _currInterval--;
            });
        }
    });
    dispatch_source_set_cancel_handler(_timer, ^{
        NSLog(@"canceled");
        dispatch_async(dispatch_get_main_queue(), ^{
            self.enabled = YES;
            self.backgroundColor = _normalBacColor;
            [self setTitle:(_resetTitle ? _resetTitle : _defaultTitle) forState:UIControlStateNormal];
            [self setTitleColor:_normalColor forState:UIControlStateNormal];
        });
    });
    dispatch_resume(_timer);
}

- (void)stop {
    if (!_timer) {
        return;
    }
    dispatch_cancel(_timer);
}

-(void)dealloc {
    NSLog(@"%@ released", NSStringFromClass([self class]));
}

@end
