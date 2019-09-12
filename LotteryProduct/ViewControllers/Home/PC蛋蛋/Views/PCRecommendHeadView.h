//
//  PCRecommendHeadView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCFreeRecommendModel.h"
@interface PCRecommendHeadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nexttime2lab;
@property (weak, nonatomic) IBOutlet UILabel *nextversion2lab;

@property (weak, nonatomic) IBOutlet UILabel *fristrecommendlab;
@property (weak, nonatomic) IBOutlet UILabel *secondrecommendlab;
@property (weak, nonatomic) IBOutlet UILabel *thirdrecommendlab;

@property (strong, nonatomic) PCFreeRecommendModel *model;



















@end
