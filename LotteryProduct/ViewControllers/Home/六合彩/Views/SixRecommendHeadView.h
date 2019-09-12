//
//  SixRecommendHeadView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendDetailModel.h"

@protocol SixRecommendHeadViewDelegate <NSObject>

- (void)attentionSomeone:(UIButton *)sender;

@end

@interface SixRecommendHeadView : UIView

@property (nonatomic, strong) UIImageView *headimgv;

@property (nonatomic, strong) UIImageView *iconimgv;

@property (nonatomic, strong) UILabel *namelab;

//@property (nonatomic, strong) UILabel *sourcelab;

@property (nonatomic, strong) UILabel *titlelab;

@property (nonatomic, strong) UILabel *contentlab;

@property (nonatomic, strong) UIButton *attentionBtn;

@property (nonatomic, assign)CGFloat height;


@property (nonatomic, strong) RecommendDetailModel *model;

@property (nonatomic,weak) id<SixRecommendHeadViewDelegate> delegate;


@end
