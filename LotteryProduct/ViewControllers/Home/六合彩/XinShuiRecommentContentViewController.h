//
//  XinShuiRecommentContentViewController.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"
#import "PCInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XinShuiRecommentContentViewController : RootCtrl

@property (nonatomic, strong) SixInfoModel *liuHeCaiModel;

@property (nonatomic, copy) NSString *downloadType;

//轮播器
@property (nonatomic, strong)SDCycleScrollView *bannerView;

@property (nonatomic, strong)UIView *tableVeiwHeaderView;


- (void)closeBannerView;


@end

NS_ASSUME_NONNULL_END
