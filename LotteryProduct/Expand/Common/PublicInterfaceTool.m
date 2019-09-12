//
//  PublicInterfaceTool.m
//  LotteryProduct
//
//  Created by pt c on 2019/8/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "PublicInterfaceTool.h"

@implementation PublicInterfaceTool


+ (void)getWechatInfoSuccess:(void (^)(BaseData *data))success failure:(void (^)(NSError *error))failure {
    [WebTools postWithURL:@"/wechat/initInfo.json" params:nil success:^(BaseData *data) {
        if(data.status.integerValue == 1){
            if (success) {
//                data.data[@"chatRoom"] = @(0);
//                data.data[@"chatRoomPack"] = @(0);
                success(data);
            }
        } else {
            if (success) {
                success(data);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
