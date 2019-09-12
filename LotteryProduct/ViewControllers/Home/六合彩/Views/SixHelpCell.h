//
//  SixHelpCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drawlab.h"
@interface SixHelpCell : UITableViewCell

//@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (strong, nonatomic) IBOutletCollection(Drawlab) NSArray *numberlabs;

@end
