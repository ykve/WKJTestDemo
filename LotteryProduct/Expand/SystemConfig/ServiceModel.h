//
//  ServiceModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/8/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServiceModel : NSObject

+ (ServiceModel *)sharedInstance;

///
@property (nonatomic, copy) NSString *serverUrl;
/// 
@property (nonatomic, assign) BOOL isBeta;

-(NSArray *)ipArray;

@end

NS_ASSUME_NONNULL_END
