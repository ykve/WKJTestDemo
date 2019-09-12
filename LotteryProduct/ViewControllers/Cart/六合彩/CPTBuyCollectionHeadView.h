//
//  CCPTBuyCollectionHeadView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPTBuyCollectionHeadView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UIView *pointView2;
@property (weak, nonatomic) IBOutlet UIView *pointView3;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (copy, nonatomic) void(^segmentClick)(NSInteger index);


@end
