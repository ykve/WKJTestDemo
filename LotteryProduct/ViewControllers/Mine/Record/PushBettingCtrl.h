//
//  PushBettingCtrl.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/17.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"
#import "BettingModel.h"

// title推单
@interface PushBettingCtrl : RootCtrl<UITextFieldDelegate>

@property (nonatomic, strong) BettingModel *model;
@property (weak, nonatomic) IBOutlet UIButton *upLoadImgBtn;
@property (weak, nonatomic) IBOutlet UITextField *bonusTF;


@end
