//
//  PK10FreeRecommendCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/21.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PK10FreeRecommendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ranklab;

@property (weak, nonatomic) IBOutlet Drawlab *resultlab;

@property (weak, nonatomic) IBOutlet UILabel *recommendlab;

@property (weak, nonatomic) IBOutlet UILabel *singleordoblelab;

@property (weak, nonatomic) IBOutlet UILabel *bigorsmalllab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultlab_width;

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@end
