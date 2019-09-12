//
//  RemarkListCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/27.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RemarkListCell.h"

@implementation RemarkListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setDataWithModel:(RemarkListModel *)model{
    [_headImgView sd_setImageWithURL:[NSURL URLWithString:model.heads] placeholderImage:[UIImage imageNamed:@"mrtx"]];
    _nameLabel.text = model.nickname;
    _contentLabel.text = model.content;
    _timeLabel.text = model.createTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
