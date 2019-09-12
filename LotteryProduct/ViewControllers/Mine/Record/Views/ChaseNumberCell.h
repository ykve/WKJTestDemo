//
//  ChaseNumberCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BettingModel.h"
@interface ChaseNumberCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconimgv;

@property (weak, nonatomic) IBOutlet UILabel *lottery_namelab;

@property (weak, nonatomic) IBOutlet UILabel *lottery_playlab;

@property (weak, nonatomic) IBOutlet UILabel *lottery_issuelab;

@property (weak, nonatomic) IBOutlet UILabel *numberlab;

@property (weak, nonatomic) IBOutlet UIScrollView *numberscrollView;

@property (weak, nonatomic) IBOutlet UILabel *oddslab;

@property (weak, nonatomic) IBOutlet UILabel *wincountlab;

@property (weak, nonatomic) IBOutlet UILabel *winpricelab;

@property (weak, nonatomic) IBOutlet UILabel *singlepricelab;

@property (weak, nonatomic) IBOutlet UILabel *progresslab;

@property (strong, nonatomic) BettingModel *model;


@end
