//
//  HistoryArticleViewController.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/11/26.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryArticleViewController : RootCtrl

@property (nonatomic, assign) NSInteger idNum;

@property (nonatomic, assign)BOOL isHistoryVc;

@property (nonatomic, strong) FollowModel *followModel;


@end

NS_ASSUME_NONNULL_END
