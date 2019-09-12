//
//  QianZhongHouTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QianZhongHouTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberBallLabels;
//赔率
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *peiLvLabels;



@end

NS_ASSUME_NONNULL_END
