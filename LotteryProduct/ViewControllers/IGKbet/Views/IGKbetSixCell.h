//
//  IGKbetSixCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGKbetSixCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UILabel *versionslab;

@property (weak, nonatomic) IBOutlet UILabel *subtitlelab;

@property (weak, nonatomic) IBOutlet UIImageView *nextimgv;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberlabs;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rights;


@end
