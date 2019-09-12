//
//  ChangLongModel.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/11.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangLongModel : NSObject

/// 彩种ID
@property (nonatomic, copy) NSString *typeId;
/// 彩种名称
@property (nonatomic, copy) NSString *type;

/// 长龙ID
@property (nonatomic, assign) NSInteger ID;
/// 长龙长度
@property (nonatomic, assign) NSInteger cotegory;
/// 龙的类型
@property (nonatomic, copy) NSString *dragonType;
/// 长龙数量
@property (nonatomic, copy) NSString *dragonSum;


@property (nonatomic, copy) NSString *nextIssue;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *nextTime;


@property (nonatomic, copy) NSString *playType;
@property (nonatomic, strong) NSArray *odds;
@property (nonatomic, copy) NSString *playTag;
@property (nonatomic, assign)long playTagId;

@property (nonatomic, assign)BOOL leftSelect;
@property (nonatomic, assign)BOOL rightSelect;



@end

NS_ASSUME_NONNULL_END
