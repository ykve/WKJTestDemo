//
//  SendOrderListCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/5/10.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "SendOrderListCell.h"

@implementation SendOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setDataWithModel:(Chat_OrderListModel *)model{
    self.gameNameLabel.text = model.lotteryName;
    self.playNameLabel.text = model.playName;
    self.issueLabel.text = model.issue;
    self.percentLabel.text = [NSString stringWithFormat:@"%@%@",model.odds,@"%"];
    self.bottomLabel1.text = [NSString stringWithFormat:@"%@%@",model.bonusScale,@"%"];
    self.bottomLabel2.text = [NSString stringWithFormat:@"%@",model.ensureOdds];
    self.bottomLabel3.text = [NSString stringWithFormat:@"%@%@",model.betAmount,@"元"];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
