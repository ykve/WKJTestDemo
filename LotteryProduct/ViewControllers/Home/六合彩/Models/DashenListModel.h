//
//  DashenListModel.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/25.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DashenListModel : NSObject


@property (nonatomic, copy) NSString *winRate;//胜率
@property (nonatomic, copy) NSString *recommender;
@property (nonatomic, copy) NSString *cicleId;//帖子ID
@property (nonatomic, copy) NSString *recommenderId;//推荐人ID
@property (nonatomic, copy) NSString *winsNumber;//中奖次数
@property (nonatomic, copy) NSString *fansNumber;//粉丝数量
@property (nonatomic, copy) NSString *continuousNumber;
@property (nonatomic, copy) NSString *photoUrl;
@property (nonatomic, copy) NSString *sort;




@end

NS_ASSUME_NONNULL_END
