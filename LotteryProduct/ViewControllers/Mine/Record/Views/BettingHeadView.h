//
//  BettingHeadView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettingHeadView : UIView

@property (weak, nonatomic) IBOutlet UIButton *beforBtn;
@property (weak, nonatomic) IBOutlet UIButton *afterBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UILabel *datelab;
@property (weak, nonatomic) IBOutlet UIButton *lotteryBtn;
@property (weak, nonatomic) IBOutlet UIButton *putmoneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *addmoneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (copy, nonatomic) void(^selectClickBlock)(NSInteger index,UIButton *sender);


@end
