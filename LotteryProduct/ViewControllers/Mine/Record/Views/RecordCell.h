//
//  RecordCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (weak, nonatomic) IBOutlet UILabel *typelab;

@property (weak, nonatomic) IBOutlet UILabel *pricelab;

@property (weak, nonatomic) IBOutlet UILabel *banlancelab;

@end
