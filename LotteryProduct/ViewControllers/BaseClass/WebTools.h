//
//  WebTools.h
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/16.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebTools : NSObject

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(BaseData *data))success failure:(void (^)(NSError *error))failure;

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(BaseData *data))success failure:(void (^)(NSError *error))failure showHUD:(BOOL )bl;

// 通用请求, 需要自己传请求方法(传@"POST"或@"GET")
+ (void)requestURL:(NSString *)urlStr
        httpMethod:(NSString *)method
            params:(NSMutableDictionary *)params
       complection:(void (^) (id response))succ
             error:(void (^) (NSError *err, id errMsg))fail;


/**
 上传图片
 
 @param images 图片
 @param code H1：产品图，H2 ：启动引导页图，H3：活动轮播图，H4：活动详情图，H5：房间视频，M1：app的logo，M2：意见反馈（图片），M3：用户头像，A1 ：后台管理用户头像
 @param uploadProgress 上传进度
 */
+ (void)rj_upImage:(NSArray<UIImage *> *)images code:(NSString *)code progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(BaseData *data))success failure:(void (^)(NSError *error))failure;

+(id)changeType:(id)myObj;
+(NSDictionary*)signDic:(NSDictionary*)dic;

@end
