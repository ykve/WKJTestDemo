//
//  HomeHeaderView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdView.h"
@protocol HomeHeaderViewNewDelegate <NSObject>

- (void)clickIcon:(UIButton *)sender;
- (void)clickSixRecommetNews:(UIButton *)sender;
- (void)clickClose;
- (void)clickEditBtn;
- (void)clickKefu;
- (void)didClickChongzhi;
-(void)didClickTiXian;
- (void)goLHCHistory;
@end

@interface HomeHeaderViewNew : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIView *noticeView;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIView *touTiaoBg;
@property (weak, nonatomic) IBOutlet UIView *botView;

@property (weak, nonatomic) id<HomeHeaderViewNewDelegate> delegate;
@property (weak, nonatomic) IBOutlet AdView *adView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightC;
@property (weak, nonatomic) IBOutlet UIView *topBg;
@property (nonatomic, copy) void (^clickCell)(NSInteger index);

- (void)showBuyViewNeedReload:(BOOL)needReload;
- (void)showInfoViewNeedReload:(BOOL)needReload;
- (void)loadLhcData;
- (void)checkMoney;
@end
