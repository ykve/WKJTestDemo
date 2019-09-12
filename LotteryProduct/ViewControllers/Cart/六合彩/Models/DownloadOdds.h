//
//  DownloadOdds.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/4/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadOdds : NSObject
@property (nonatomic,copy) NSString *downURL;
@property (nonatomic,copy) NSString *version;
@end

NS_ASSUME_NONNULL_END
