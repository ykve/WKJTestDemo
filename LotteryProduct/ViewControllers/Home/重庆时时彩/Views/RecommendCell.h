//
//  RecommendCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UILabel *numberlab;

@property (weak, nonatomic) IBOutlet UILabel *singleordoublelab;

@property (weak, nonatomic) IBOutlet UILabel *bigorsmalllab;
@end
