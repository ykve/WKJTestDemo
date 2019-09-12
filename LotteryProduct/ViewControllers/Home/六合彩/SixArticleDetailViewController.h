//
//  SixArticleDetailViewController.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/30.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SixArticleDetailViewController : RootCtrl
/// 心水推荐的id
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *parentMemberId;
@property (nonatomic, copy) NSString *referId;


@property (nonatomic, assign)BOOL isShowHistoryBtn;

/*  是否关注  */
@property (nonatomic, copy) NSString *isAttention;

@property (nonatomic, assign)BOOL isToRootVc;

@property (nonatomic, strong) SixInfoModel *liuHeCaiModel;

@property (nonatomic, copy) NSString *titleStr;




@end

NS_ASSUME_NONNULL_END
