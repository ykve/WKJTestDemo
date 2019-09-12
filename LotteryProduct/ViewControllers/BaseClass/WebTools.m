//
//  WebTools.m
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/16.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import "WebTools.h"

#import "NSString+MD5.h"
#import "AppDelegate.h"
#import "MainTabbarCtrl.h"
#import "SSZipArchive.h"
#import "LoginAlertViewController.h"
#import "MineCtrl.h"

#define LAST_CONTROLLER [AppDelegate currentViewController]

#pragma mark - association
NSString*const WDSessionDataTask = @"WDSessionDataTask";

@implementation WebTools

+ (AFHTTPSessionManager *)shareAFManager{
    static AFHTTPSessionManager *manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [AFHTTPSessionManager manager];
    });
    return manger;
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(BaseData *data))success failure:(void (^)(NSError *error))failure{
    [self postWithURL:url params:params success:success failure:failure  showHUD:YES];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(BaseData *data))success failure:(void (^)(NSError *error))failure showHUD:(BOOL )bl{
    
    [Person person].neturl = url;
    [Person person].netparmas = params;
    [Person person].successBlock = success;
    [Person person].failureBlock = failure;
    [Person person].show = bl;
    NSString*strUrl = [NSString stringWithFormat:@"%@%@",kServerUrl,url];
    if([url containsString:@"paymentRequestByUser.json"]){
        strUrl = [NSString stringWithFormat:@"%@%@",kPAYAPI,url];
    }
    if(bl){
        [[AppDelegate shareapp] showGif];
    }
    
    AFHTTPSessionManager *manager = [WebTools shareAFManager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer.timeoutInterval = 30.f;
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    if ([Person person].uid && [Person person].token) {
        
        strUrl = [NSString stringWithFormat:@"%@?uid=%@&token=%@",strUrl,[Person person].uid,[Person person].token];
    }
    
    NSMutableDictionary *msuparams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    if ([Person person].uid && [Person person].token) {
        
        //        [msuparams addEntriesFromDictionary:@{@"uid":[Person person].uid, @"token":[Person person].token}];
    }
    
    NSDictionary*enDic = [self signDic:msuparams];
    
    //    [enDic addEntriesFromDictionary:@{@"uid":Person person].uid, @"token":[Person person].token}];
    
//    MBLog(@"请求地址：%@",strUrl);
//    MBLog(@"发送：%@",enDic);
    
    // 2.发送请求
    NSURLSessionDataTask*dataTask = [manager POST:strUrl parameters:enDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(bl){
            [[AppDelegate shareapp] dismissGif];
        }
        if (success) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            dic = [WebTools changeType:dic];
            

            BaseData *basedata = [BaseData mj_objectWithKeyValues:dic];

            if (basedata.status.integerValue == 1 || basedata.status.integerValue == 1027){
                [[AppDelegate shareapp] saveServerTime:basedata.time*1000];
                success(basedata);
            } else if ((basedata.status.integerValue == 1010 || basedata.status.integerValue == 1011)){
                //                dispatch_sync(dispatch_get_main_queue(), ^{
                if ([Person person].showlogin == NO) {
                    
                    [Person person].uid = nil;
                    [Person person].token = nil;
                    [[Person person]deleteCore];
                    
                    if ([LAST_CONTROLLER isKindOfClass:[LoginAlertViewController class]]) {
                        return ;
                    }
                    if ([[AppDelegate currentViewController] isKindOfClass:[MineCtrl class]]) {
                        return;
                    }
                    success(basedata);
                    LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                    login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    [LAST_CONTROLLER presentViewController:login animated:YES completion:nil];
                    login.loginBlock = ^(BOOL result) {
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
                        
                    };
                    
                }
                //                });
            } else {
                
                NSLog(@"%@",LAST_CONTROLLER);
                if(bl){
                    [[AppDelegate shareapp] dismissGif];
                }
                if (failure) {
                    failure(nil);
                }
                
                if(basedata.status.integerValue == 1036){
                    
                    
                } else if(basedata.status.integerValue == 500){
                    
                    [MBProgressHUD showError:basedata.info toView:LAST_CONTROLLER.view duration:2];
                    if ([basedata.info isEqualToString:@"全员禁言中！"]) {
                         [[NSNotificationCenter defaultCenter] postNotificationName:kNoTalkingNotification object:nil];
                    }
                    
                } else {
                    if (basedata.status.integerValue == -1) {
                        
                        //                    [MBProgressHUD showError:@"网络连接失败" toView:LAST_CONTROLLER.view duration:2];
                        if ([NSString isIncludeChineseInString:[NSString stringWithFormat:@"%@", basedata.info]]) {
                            if ([basedata.info containsString:@"未知错误"]) {
                                return ;
                            }
                            [MBProgressHUD showError:basedata.info toView:LAST_CONTROLLER.view duration:2];
                            
                        }else{
                            //                        [MBProgressHUD showError:@"温馨提示 ：咦？！网络连接失败了~" toView:LAST_CONTROLLER.view duration:2];
                            
                        }
                        
                    } else {
                        
                        if ([NSString isIncludeChineseInString:[NSString stringWithFormat:@"%@", basedata.info]]) {
                            NSString *errorstr = basedata.info.length > 0 ? basedata.info : @"网络加载失败，请重新加载";
                            if ([errorstr containsString:@"当前版本有误，请卸载重装"]) {
                                return ;
                            }
                            if ([errorstr containsString:@"未知错误"]) {
                                return ;
                            }
                            [MBProgressHUD showError:errorstr toView:LAST_CONTROLLER.view duration:2];
                        } else {
                            [MBProgressHUD showError:@"温馨提示 ：咦？！网络连接失败了~" toView:LAST_CONTROLLER.view duration:2];
                        }
                        
                    }
                }
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MBLog(@"strUrl: %@,error:%@",strUrl,[NSString stringWithFormat:@"%@", error]);
        //        [MBProgressHUD showError:[NSString stringWithFormat:@"%@", error]];
        if(bl){
            [[AppDelegate shareapp] showFailedGif];
        }
        if (!([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"]||[error.userInfo[@"idNSLocalizedDescription"] isEqualToString:@"已取消"])) {
            if (failure) {
                failure(error);
            }
        }
    }];
    
    if (LAST_CONTROLLER) {
        objc_removeAssociatedObjects(LAST_CONTROLLER);
        objc_setAssociatedObject(LAST_CONTROLLER, &WDSessionDataTask, dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


#pragma mark - 上传文件

/**
 上传图片
 
 @param images 图片
 @param code H1：产品图，H2 ：启动引导页图，H3：活动轮播图，H4：活动详情图，H5：房间视频，M1：app的logo，M2：意见反馈（图片），M3：用户头像，A1 ：后台管理用户头像
 @param uploadProgress 上传进度
 */
+ (void)rj_upImage:(NSArray<UIImage *> *)images code:(NSString *)code progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(BaseData *data))success failure:(void (^)(NSError *error))failure {
    
    NSMutableArray<NSData *> *datas = [NSMutableArray array];
    for (UIImage *image in images) {
        
        //        UIImage *newimg = [Tools compressImageWith:image];
        
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        
        [datas addObject:data];
    }
    [self rj_updata:datas code:code fileName:@"file" fileType:@"jpg" mimeType:@"image/*" progress:uploadProgress success:success failure:failure];
}

/**
 上传文件
 
 @param datas 数据
 @param code H1：产品图，H2 ：启动引导页图，H3：活动轮播图，H4：活动详情图，H5：房间视频，M1：app的logo，M2：意见反馈（图片），M3：用户头像，A1 ：后台管理用户头像
 @param fileName 后台接收的名字（file）
 @param type 文件后缀
 @param mimeType 文件类型
 @param uploadProgress 上传进度
 */
+ (void)rj_updata:(NSArray<NSData *> *)datas code:(NSString *)code fileName:(NSString *)fileName fileType:(NSString *)type mimeType:(NSString *)mimeType progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(BaseData *data))success failure:(void (^)(NSError *error))failure {
    
    NSString*strUrl = [NSString stringWithFormat:@"%@%@",kUploadFileUrl,@"fileEntry/oss/uploadFile"];
    
    [[AppDelegate shareapp] showGif];
    
    AFHTTPSessionManager *manager =  [WebTools shareAFManager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer.timeoutInterval = 15.f;
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    if ([Person person].uid && [Person person].token) {
        
        strUrl = [NSString stringWithFormat:@"%@?uid=%@&token=%@",strUrl,[Person person].uid,[Person person].token];
    }
    
    NSString *time = [NSString stringWithFormat:@"%.0f", [[NSDate alloc] initWithTimeIntervalSinceNow:0].timeIntervalSince1970];
    
    NSString *paramsStr = [NSString stringWithFormat:@"code=%@&time=%@&type=%@", code, time,@"image"];
    
    NSString *sign = [[NSString stringWithFormat:@"%@%@",MD5KEY,paramsStr] MD5];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:sign forKey:@"apisign"];
    [params setValue:code forKey:@"code"];
    [params setValue:time forKey:@"time"];
    [params setValue:@"image" forKey:@"type"];
    //    [params setValue:@"" forKey:@"data"];
    
    [manager POST:strUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger count = datas.count;
        
        if (datas && count > 0) {
            for(int i = 0 ; i < count ; i++ ){
                
                NSData *data = datas[i];
                
                NSString *fileFullName = [NSString stringWithFormat:@"%@.%@",fileName, type];
                
                [formData appendPartWithFileData:data name:fileName fileName:fileFullName mimeType:mimeType];
            }
        }
        
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[AppDelegate shareapp] dismissGif];
        
        if (success) {
            NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            dic = [WebTools changeType:dic];
            
            MBLog(@"获取数据：%@",dic);
            
            BaseData *basedata = [BaseData mj_objectWithKeyValues:dic];
            
            if (basedata.status.integerValue == 1){
                
                success(basedata);
            }
            else if (basedata.status.integerValue == 1010 || basedata.status.integerValue == 1011){
                
                if ([Person person].showlogin == NO) {
                    
                    [Person person].uid = nil;
                    [Person person].token = nil;
                    [[Person person]deleteCore];
                    //                    LoginCtrl *login = [[LoginCtrl alloc]initWithNibName:NSStringFromClass([LoginCtrl class]) bundle:[NSBundle mainBundle]];
                    //                    @weakify(self)
                    //                    login.loginBlock = ^(BOOL result) {
                    //
                    //                        @strongify(self)
                    //                        if(result == YES) {
                    //
                    //                            [self rj_updata:datas code:code fileName:fileName fileType:type mimeType:mimeType progress:uploadProgress success:success failure:failure];
                    //                        }
                    //
                    //                        [Person person].showlogin = NO;
                    //
                    //
                    //                    };
                    if ([LAST_CONTROLLER isKindOfClass:[LoginAlertViewController class]]) {
                        return ;
                    }
                    
                    LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
                    login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                    [LAST_CONTROLLER presentViewController:login animated:YES completion:nil];
                    @weakify(self)
                    login.loginBlock = ^(BOOL result) {
                        @strongify(self)
                        if(result == YES) {
                            
                            [self rj_updata:datas code:code fileName:fileName fileType:type mimeType:mimeType progress:uploadProgress success:success failure:failure];
                        }
                        
                        [Person person].showlogin = NO;
                    };
                    
                    
                    [Person person].showlogin = YES;
                }
                
            }
            else{
                
                NSLog(@"%@",LAST_CONTROLLER);
                [[AppDelegate shareapp] showFailedGif];
                
                if (failure) {
                    failure(nil);
                }
                
                if (basedata.status.integerValue == -1) {
                    
                    [MBProgressHUD showError:@"网络连接失败" toView:LAST_CONTROLLER.view duration:2];
                }
                else{
                    NSString *errorstr = basedata.info.length > 0 ? basedata.info : @"网络加载失败，请重新加载";
                    
                    [MBProgressHUD showError:errorstr toView:LAST_CONTROLLER.view duration:2];
                }
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (!([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"]||[error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"已取消"])) {
            [[AppDelegate shareapp] showFailedGif];
            
            //            gifLoading.state = CLLoadStateFailed;
            //            @weakify(self)
            //            gifLoading.retryBlcok = ^{
            //                @strongify(self)
            //                NSLog(@"重试");
            //
            [self rj_updata:datas code:code fileName:fileName fileType:type mimeType:mimeType progress:uploadProgress success:success failure:failure];
            //            };
            
            if (failure) {
                failure(error);
            }
        }
    }];
}

+(NSDictionary*)signDic:(NSDictionary*)dic{
    NSDictionary*jsonDic = nil;
    if (dic) {
        //        jsonStr = [self dictionaryToJson:dic];
        jsonDic = dic;
    }else{
        jsonDic = @{};
    }
    
    NSString *jsonStr = [self dictionaryToJson:jsonDic];
    
    NSString *appendStr = [NSString stringWithFormat:@"%@%@",MD5KEY,jsonStr];
    
    NSString *signStr = [appendStr MD5];
    
    return @{@"data":jsonDic,@"apisign":signStr};
}

//字典NSDictionary转成Json字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = [NSError new];
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:&parseError];
    NSString * jsonstr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonstr;
}
#pragma mark - 字典转字符串
+(NSString*)parametersFromDic:(NSDictionary*)dic{
    NSMutableString*dicStr=[NSMutableString string];
    for (NSString *key in dic) {
        if (dicStr.length) {
            [dicStr appendFormat:@"&%@=",key];
        }else{
            [dicStr appendFormat:@"%@=",key];
        }
        
        [dicStr appendString:[NSString stringWithFormat:@"%@",dic[key]]];
        
    }
    return dicStr;
}

#pragma mark - 多层字典转字符串--没有签名
+(NSString*)stringFromMutableDic:(NSDictionary*)dic{
    NSMutableDictionary*dicFromDic=[NSMutableDictionary dictionary];
    NSMutableDictionary*strFromDic=[NSMutableDictionary dictionary];
    for (NSString*key in dic) {
        if ([dic[key] isKindOfClass:[NSString class]] ) {
            [strFromDic setObject:dic[key] forKey:key];
        }else if ([dic[key] isKindOfClass:[NSNumber class]] ) {
            [strFromDic setObject:dic[key] forKey:key];
        }else{
            [dicFromDic setObject:dic[key] forKey:key];
        }
    }
    
    NSMutableString*muStr=[[NSMutableString alloc]initWithString:[WebTools parametersFromDic:strFromDic]];
    for (NSString*key in dicFromDic) {
        [muStr appendString:[NSString stringWithFormat:@"&%@=",key]];
        [muStr appendString:[WebTools dictionaryToJson:dicFromDic[key]]];
    }
    return muStr;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}


+ (void)getOddsWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(BaseData *data))success failure:(void (^)(NSError *error))failure {
    
    [Person person].neturl = url;
    [Person person].netparmas = params;
    [Person person].successBlock = success;
    [Person person].failureBlock = failure;
    
    NSString*strUrl = [NSString stringWithFormat:@"%@%@",kServerUrl,url];
    
    
    AFHTTPSessionManager *manager = [WebTools shareAFManager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer.timeoutInterval = 15.f;
    
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    if ([Person person].uid && [Person person].token) {
        
        strUrl = [NSString stringWithFormat:@"%@?uid=%@&token=%@",strUrl,[Person person].uid,[Person person].token];
    }
    
    NSMutableDictionary *msuparams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    NSDictionary*enDic=[self signDic:msuparams];
    
    MBLog(@"请求地址：%@",strUrl);
    MBLog(@"发送：%@",enDic);
    
    // 2.发送请求
    NSURLSessionDataTask*dataTask = [manager POST:strUrl parameters:enDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            dic = [WebTools changeType:dic];
            
            MBLog(@"获取数据：%@",dic);
            
            BaseData *basedata = [BaseData mj_objectWithKeyValues:dic];
            
            if (basedata.status.integerValue == 1){
                
                success(basedata);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (!([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"]||[error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"已取消"])) {
            
            if (failure) {
                failure(error);
            }
        }
    }];
    
    if (LAST_CONTROLLER) {
        objc_removeAssociatedObjects(LAST_CONTROLLER);
        objc_setAssociatedObject(LAST_CONTROLLER, &WDSessionDataTask, dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}





@end
