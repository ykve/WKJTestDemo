//
//  ActivelistCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/30.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivelistCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconimgv;

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UILabel *conditionlab;

@property (weak, nonatomic) IBOutlet UILabel *desclab;

@end
