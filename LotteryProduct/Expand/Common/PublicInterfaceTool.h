//
//  PublicInterfaceTool.h
//  LotteryProduct
//
//  Created by pt c on 2019/8/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublicInterfaceTool : NSObject

+ (void)getWechatInfoSuccess:(void (^)(BaseData *data))success failure:(void (^)(NSError *error))failure;
    
@end

NS_ASSUME_NONNULL_END
