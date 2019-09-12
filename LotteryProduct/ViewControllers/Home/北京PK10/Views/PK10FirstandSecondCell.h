//
//  PK10FirstandSecondCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PK10FirstandSecondCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *versionlab;

@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (weak, nonatomic) IBOutlet UILabel *sumlab;

@property (weak, nonatomic) IBOutlet UILabel *bigorsmalllab;

@property (weak, nonatomic) IBOutlet UILabel *singleanddoublelab;

@property (strong, nonatomic) IBOutletCollection(Drawlab) NSArray *Chartslabs;


@end
