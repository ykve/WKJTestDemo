//
//  CrartHomeSubModel.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/12.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CrartHomeSubModel : NSObject


@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , copy) NSString               *icon;
@property (nonatomic , assign) NSInteger              updateTime;
@property (nonatomic , assign) BOOL                  cateName;
@property (nonatomic , copy) NSString              * intro;
@property (nonatomic , copy) NSString              * startlottoTimes;
@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , assign) NSInteger              lotteryId;
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , assign) BOOL                  isWork;
@property (nonatomic , assign) NSInteger             endTime;
@property (nonatomic , assign) NSInteger             categoryId;


@end

NS_ASSUME_NONNULL_END
