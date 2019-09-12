//
//  SixRecommendCell.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SixRecommendCellDelegate <NSObject>

- (void)clickZanBtn:(UIButton *)btn;

@end

@interface SixRecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headimgv;
@property (weak, nonatomic) IBOutlet UILabel *timelab;
@property (weak, nonatomic) IBOutlet UILabel *sourcelab;
@property (weak, nonatomic) IBOutlet UIImageView *iconimgv;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UILabel *subtitlelab;
@property (weak, nonatomic) IBOutlet UILabel *seecountlab;


@property (weak, nonatomic) IBOutlet UILabel *zanNunLbl;

@property (nonatomic,weak) id<SixRecommendCellDelegate> delegate;

@end
