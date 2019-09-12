//
//  ExpertOrderCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushOrderModel.h"
@interface ExpertOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lottery_namelab;
@property (weak, nonatomic) IBOutlet UILabel *lottery_playlab;
@property (weak, nonatomic) IBOutlet UILabel *lottery_issuelab;
@property (weak, nonatomic) IBOutlet UILabel *lottery_oddslab;
@property (weak, nonatomic) IBOutlet UILabel *lottery_pricelab;
@property (weak, nonatomic) IBOutlet UILabel *addpricelab;
@property (weak, nonatomic) IBOutlet UILabel *safelab;
@property (weak, nonatomic) IBOutlet UILabel *totalpricelab;
@property (weak, nonatomic) IBOutlet UILabel *numbercountlab;
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;
//@property (weak, nonatomic) IBOutlet UIButton *forrowBtn;

@property (weak, nonatomic) IBOutlet UIView *resultstautlView;
@property (weak, nonatomic) IBOutlet UIImageView *resultimgv;
@property (weak, nonatomic) IBOutlet UILabel *resultpricelab;
@property (assign, nonatomic) NSInteger finishStatus;





@property (strong, nonatomic) PushOrderModel *model;

@property (copy, nonatomic) void (^publishBlock)(void);





@end
