//
//  CQDouniuTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/29.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQDouniuTableViewCell : UITableViewCell

//赔率
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *peiLvLabels;
//"总和大"等 label
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *ballLabels;

//底部的 button
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@end

NS_ASSUME_NONNULL_END
