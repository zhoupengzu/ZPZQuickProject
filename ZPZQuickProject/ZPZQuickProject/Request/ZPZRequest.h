//
//  ZPZRequest.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZPZRequestModel;

@interface ZPZRequest : NSObject

+ (void)requestWithModel:(ZPZRequestModel *)model;
+ (void)requestToUploadFileDataWithModel:(ZPZRequestModel *)model;

@end
