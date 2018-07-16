//
//  ZPZRequestModel.h
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZPZRequestModel;

/**
 * 请求类型：post还是get
 */
typedef NS_ENUM(NSInteger, ZPZRequestMethod) {
    ZPZRequestMethodGet,
    ZPZRequestMethodPost,
};

typedef NS_ENUM(NSInteger, ZPZMimeType) {
    ZPZMimeTypeDefault,
    ZPZMimeTypeImage_Png,
};

typedef void(^ZPZRequestSuccessBlock)(ZPZRequestModel * requestModel);
typedef void(^ZPZRequestFailBlock)(ZPZRequestModel * requestModel);
typedef void(^ZPZRequestUploadProgress)(NSProgress * progress);

@interface ZPZRequestModel : NSObject

/**
 * 请求方法是get还是post
 * 默认为post：MYRequestMethodPost
 */
@property (nonatomic, assign) ZPZRequestMethod method;
/**
 * 请求超时时长
 * 默认为10秒
 */
@property (nonatomic, assign) NSTimeInterval timeOut;
/**
 * 相对请求地址
 */
@property (nonatomic, copy) NSString * relativeUrl;
/**
 * 请求参数
 */
@property (nonatomic, copy) NSDictionary * paramsDic;
@property (nonatomic, strong) NSData * uploadData;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * fileName;
@property (nonatomic, assign) ZPZMimeType mimeType;
/**
 * 请求成功和失败时的回调
 */
@property (nonatomic, copy) ZPZRequestSuccessBlock successBlock;
@property (nonatomic, copy) ZPZRequestFailBlock failBlock;
@property (nonatomic, copy) ZPZRequestUploadProgress uploadProgress;
/**
 * 请求失败或者成功的原因
 */
@property (nonatomic, strong) NSError * error;   // 一般用于失败的时候
/**
 * 请求成功时的返回数据
 */
@property (nonatomic, strong) id responseObj;

- (NSString *)mimeTypeStr;

@end
