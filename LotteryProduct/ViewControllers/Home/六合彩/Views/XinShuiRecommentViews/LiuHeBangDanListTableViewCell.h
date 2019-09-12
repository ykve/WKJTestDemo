//
//  LiuHeBangDanListTableViewCell.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DashenListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiuHeBangDanListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *rangeNumBtn;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;
@property (weak, nonatomic) IBOutlet UILabel *fansLbl;
@property (weak, nonatomic) IBOutlet UILabel *winNumsLbl;
@property (weak, nonatomic) IBOutlet UILabel *continueWinNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *winRateLbl;

@property (nonatomic, strong) DashenListModel *listModel;


@end

NS_ASSUME_NONNULL_END
