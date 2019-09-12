//
//  CPTInfoManager.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPTInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CPTInfoManager : NSObject
@property(strong,nonatomic)CPTInfoModel *model;

//shareUrl    String    分享网址
//twoCode    String    二维码
//androidUrl    String    安卓下载包
//iosUrl    String    IOS下载包
//aboutUs    String    关于我们
//serviceContract    String    服务协议
//service_qq1    String    客服QQ1
//service_qq2    String    客服QQ2
+ (id)shareManager;
-(void)checkModelCallBack:(void (^)(CPTInfoModel *model,BOOL isSuccess))success;

@end



NS_ASSUME_NONNULL_END
