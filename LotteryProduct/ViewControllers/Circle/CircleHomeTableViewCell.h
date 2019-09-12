//
//  CircleHomeTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/3/11.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIView *backVeiw;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end

NS_ASSUME_NONNULL_END
