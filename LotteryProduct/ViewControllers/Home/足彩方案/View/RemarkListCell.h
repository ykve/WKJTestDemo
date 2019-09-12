//
//  RemarkListCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/27.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemarkListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RemarkListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setDataWithModel:(RemarkListModel *)model;
@end

NS_ASSUME_NONNULL_END
