//
//  ZPZAlertField.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPZAlertModel.h"
#import "ZPZCustomFieldModel.h"

@interface ZPZAlertField : UIView

@property (nonatomic, copy, readonly) NSString * fieldContent;

+ (ZPZAlertField *)showAlertViewInView:(UIView *)containerView
                        andTitleModel:(nonnull ZPZAlertModel *)titleModel
                         contentModel:(nonnull ZPZAlertModel *)contentModel
                      andActionModels:(nonnull NSArray<ZPZAlertModel *> *)actionModels
                      andEventHandler:(void(^)(ZPZAlertModel * action, NSString * content, NSInteger index))hanlder;
+ (ZPZAlertField *)showAlertViewInView:(UIView *)containerView
                        andTitleModel:(ZPZAlertModel *)titleModel
                        contentModels:(NSArray<ZPZAlertModel *> *)contentModel
                      andActionModels:(NSArray<ZPZAlertModel *> *)actionModels
                      andEventHandler:(void (^)(ZPZAlertModel *, NSArray<NSString *> *, NSInteger))hanlder;
- (void)showAlertField;

@end
