//
//  ZPZRequest.m
//  ZPZQuickProject
//
//  Created by zhoupengzu on 2018/7/16.
//  Copyright © 2018年 zhoupengzu. All rights reserved.
//

#import "ZPZRequest.h"
#import "ZPZPublicManager+Device.h"
#import "ZPZRequestModel.h"
#import "ZPZAppDelegate.h"
#import "AFNetworking.h"

@implementation ZPZRequest

+ (void)requestWithModel:(ZPZRequestModel *)model {
    NSDictionary * commonDic = [self commonRequestParams];
    NSMutableDictionary * requestDic = [NSMutableDictionary dictionaryWithDictionary:commonDic];
    [model.paramsDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [requestDic setObject:obj forKey:key];
    }];
    NSString * requestStr = @"";
    if (model.relativeUrl.length > 0) {
        requestStr = [requestStr stringByAppendingFormat:@"/%@?", model.relativeUrl];
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = model.timeOut;
    switch (model.method) {
        case ZPZRequestMethodGet:{
            [manager GET:requestStr parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                ZPZRequestModel * tempModel = [model copy];
                tempModel.responseObj = responseObject;
                [self checkSessionIsExpiredWithModel:tempModel];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (model.failBlock) {
                    ZPZRequestModel * failModel = [[ZPZRequestModel alloc] init];
                    failModel.error = error;
                    model.failBlock(failModel);
                }
            }];
        }
            break;
        case ZPZRequestMethodPost:{
            [manager POST:requestStr parameters:requestDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                ZPZRequestModel * tempModel = [model copy];
                tempModel.responseObj = responseObject;
                [self checkSessionIsExpiredWithModel:tempModel];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (model.failBlock) {
                    ZPZRequestModel * failModel = [[ZPZRequestModel alloc] init];
                    failModel.error = error;
                    model.failBlock(failModel);
                }
                
            }];
        }
            break;
        default:{
            NSLog(@"不存在该请求类型...");
            if (model.failBlock) {
                model.failBlock(nil);
            }
        }
            break;
    }
}

+ (void)checkSessionIsExpiredWithModel:(ZPZRequestModel *)model {
    if (![model.responseObj isKindOfClass:[NSDictionary class]]) {
        NSLog(@"返回数据格式错误...");
        if (model.failBlock) {
            model.failBlock(nil);
        }
        return;
    }
    ZPZRequestModel * tempModel = [model copy];
    NSInteger code  = [[model.responseObj objectForKey:@"code"] integerValue];
    if (code == 999) {
        NSLog(@"Session已过期");
        
    } else {
        if (model.successBlock) {
            model.successBlock(tempModel);
        }
    }
}

+ (void)autoGotoLoginViewController {
    [[ZPZPublicManager appDelegate] removeLoadingView];
    [[ZPZPublicManager appDelegate] gotoRootVCAndThenLogin];
}

+ (NSDictionary *)commonRequestParams {
    NSMutableDictionary * otherDic = [NSMutableDictionary dictionary];
    return otherDic;
}

// 文件上传
+ (void)requestToUploadFileDataWithModel:(ZPZRequestModel *)model {
    NSString * requestStr = @"";
    if (model.relativeUrl.length > 0) {
        requestStr = [requestStr stringByAppendingFormat:@"/%@?", model.relativeUrl];
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:requestStr parameters:model.paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (model.uploadData) {
            [formData appendPartWithFileData:model.uploadData name:model.name fileName:model.fileName mimeType:[model mimeTypeStr]];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (model.uploadProgress) {
                model.uploadProgress(uploadProgress);
            }
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (model.successBlock) {
            ZPZRequestModel * tempModel = [model copy];
            tempModel.responseObj = responseObject;
            model.successBlock(tempModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (model.failBlock) {
            ZPZRequestModel * failModel = [[ZPZRequestModel alloc] init];
            failModel.error = error;
            model.failBlock(failModel);
        }
    }];
}

@end
