//
//  SendOrderListCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/5/10.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chat_OrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SendOrderListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *gameNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *issueLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel1;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel2;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel3;
- (void)setDataWithModel:(Chat_OrderListModel *)model;

@end

NS_ASSUME_NONNULL_END
