//
//  FootballRemarkListModel.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/26.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FootballRemarkListModel : NSObject


@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *referrer;
@property (nonatomic,assign) NSInteger referrerId;

@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *realViews;//阅读数
@property (nonatomic,copy) NSString *commentCount;//评论数
@property (nonatomic,copy) NSString *heads;
@property (nonatomic,copy) NSString *head;
@property (nonatomic,copy) NSString *endTime;
@property (nonatomic,copy) NSString *startTime;
@property (nonatomic,copy) NSString *troop;

@property (nonatomic,copy) NSString *probability;



@end

NS_ASSUME_NONNULL_END
