//
//  PCTodayCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCTodayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberlab;

@property (weak, nonatomic) IBOutlet UILabel *firstcloselab;

@property (weak, nonatomic) IBOutlet UILabel *firstopenlab;

@property (weak, nonatomic) IBOutlet UILabel *secondcloselab;

@property (weak, nonatomic) IBOutlet UILabel *secondopenlab;

@property (weak, nonatomic) IBOutlet UILabel *thirdcloselab;

@property (weak, nonatomic) IBOutlet UILabel *thirdopenlab;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *noopenArray;

@end
