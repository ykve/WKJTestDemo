//
//  CartChongqinCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartChongqinCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typelab;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (weak, nonatomic) IBOutlet UILabel *misstitlelab;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *missnumlabs;

@property (copy, nonatomic) void (^segmentBlock)(NSInteger segment);

@property (copy, nonatomic) void (^selectBlock)(NSString *string);

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rights;



@end
