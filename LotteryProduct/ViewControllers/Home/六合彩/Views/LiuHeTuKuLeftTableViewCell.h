//
//  LiuHeTuKuLeftTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/17.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiuHeTuKuLeftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *leftLine;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic, assign)BOOL isSelected;


@end

NS_ASSUME_NONNULL_END
