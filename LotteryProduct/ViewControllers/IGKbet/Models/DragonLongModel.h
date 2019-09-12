//
//  DragonLongModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/7/29.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DragonLongModel : NSObject

///
@property (nonatomic, assign) NSInteger dragonNum;
///
@property (nonatomic, copy) NSString *dragonTip;

//[
// {
//     "dragonNum": 5,
//     "dragonTip": "彩种:PC蛋蛋玩法:大小,连开大,5期"
// },
// {
//     "dragonNum": 14,
//     "dragonTip": "彩种:PC蛋蛋玩法:大小,连开小,14期"
// }
// ]


@end

NS_ASSUME_NONNULL_END
