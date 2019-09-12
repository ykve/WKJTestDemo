//
//  BettingDetailCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BettingDetailCell.h"

@implementation BettingDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID
{
    BettingDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BettingDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    self.backgroundColor = [UIColor colorWithHex:@"#EFEFF4"];
    
    UILabel *titlelab = [[UILabel alloc] init];
    titlelab.text = @"-";
    titlelab.font = [UIFont systemFontOfSize:13];
    titlelab.textColor = [UIColor colorWithHex:@"#666666"];
    titlelab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titlelab];
    _titlelab = titlelab;
    
    [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    
    UILabel *contentlab = [[UILabel alloc] init];
    contentlab.text = @"-";
    contentlab.font = [UIFont systemFontOfSize:13];
    contentlab.textColor = [UIColor colorWithHex:@"#666666"];
    contentlab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:contentlab];
    _contentlab = contentlab;
    
    [contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titlelab.mas_centerY);
        make.left.equalTo(titlelab.mas_right).offset(20);
    }];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
