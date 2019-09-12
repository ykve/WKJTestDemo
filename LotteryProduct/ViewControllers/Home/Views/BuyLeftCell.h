//
//  HomeCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrartHomeSubModel.h"
@interface BuyLeftCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;

@property (nonatomic, assign) CPTBuyTicketType type;
@property (strong, nonatomic)  CrartHomeSubModel *model;

@end
