//
//  ZPZRequestModel.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZRequestModel.h"

@implementation ZPZRequestModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _timeOut = 60;
        _method = ZPZRequestMethodPost;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    ZPZRequestModel * model = [[ZPZRequestModel alloc] init];
    model.method = self.method;
    model.timeOut = self.timeOut;
    model.relativeUrl = self.relativeUrl;
    model.paramsDic = self.paramsDic;
    model.uploadData = self.uploadData;
    model.name = self.name;
    model.fileName = self.fileName;
    model.mimeType = self.mimeType;
    model.error = self.error;
    model.responseObj = self.responseObj;
    model.successBlock = self.successBlock;
    model.uploadProgress = self.uploadProgress;
    model.failBlock = self.failBlock;
    return model;
}

- (NSString *)mimeTypeStr {
    switch (_mimeType) {
        case ZPZMimeTypeImage_Png: {
            return @"image/png";
        }
            
        default:
            return @"";
    }
}

@end
