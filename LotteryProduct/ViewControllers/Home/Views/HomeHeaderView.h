//
//  HomeHeaderView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeHeaderViewDelegate <NSObject>

- (void)clickSixRecommetNews:(UIButton *)sender;

@end

@interface HomeHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIView *noticeView;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;

@property (weak, nonatomic) IBOutlet UIImageView *activityimgv;
@property (weak, nonatomic) IBOutlet UIView *commentView;

@property (weak, nonatomic) id<HomeHeaderViewDelegate> delegate;

@end
