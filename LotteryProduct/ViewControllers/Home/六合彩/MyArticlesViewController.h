//
//  MyArticlesViewController.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/4.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyArticlesViewController : RootCtrl

@property (nonatomic, assign)BOOL isShowEditBtn;

@property (nonatomic, strong)FollowModel *followModel;


@end

NS_ASSUME_NONNULL_END
