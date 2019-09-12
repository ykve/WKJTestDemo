//
//  TodayOneCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayOneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberlab;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *unreadlabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *readlabs;

@end
