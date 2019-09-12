//
//  BettinglistCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettinglistCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *backview;

@property (weak, nonatomic) IBOutlet UIImageView *iconimgv;

@property (weak, nonatomic) IBOutlet UILabel *lotterylab;

@property (weak, nonatomic) IBOutlet UILabel *typelab;

@property (weak, nonatomic) IBOutlet UILabel *issuelab;

@property (weak, nonatomic) IBOutlet UILabel *creattimelab;

@property (weak, nonatomic) IBOutlet UILabel *resultlab;

@property (weak, nonatomic) IBOutlet UILabel *oddslab;

@property (weak, nonatomic) IBOutlet UILabel *paymoneylab;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;


@end
