//
//  FollowModel.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/8.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FollowModel : NSObject

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *heads;

@property (nonatomic , copy) NSString *referrerId;
@property (nonatomic , assign) NSInteger parentMemberId;

@property (nonatomic , copy) NSString *ID;




@end

NS_ASSUME_NONNULL_END
