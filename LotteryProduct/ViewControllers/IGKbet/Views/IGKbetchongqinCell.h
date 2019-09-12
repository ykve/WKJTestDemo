//
//  IGKbetchongqinCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGKbetchongqinCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerY;

@property (weak, nonatomic) IBOutlet UILabel *versionslab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnW;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnH;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberlabs;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numSubTitleLbls;
@property (weak, nonatomic) IBOutlet UIView *bottomMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleBottomMargin;


@property (weak, nonatomic) IBOutlet UILabel *totallab;

@property (weak, nonatomic) IBOutlet UIImageView *nextimgv;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rights;

@property (weak, nonatomic) IBOutlet UIView *topmargin;



@end
