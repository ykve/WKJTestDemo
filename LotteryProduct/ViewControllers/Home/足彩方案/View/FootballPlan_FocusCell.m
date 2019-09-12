//
//  FootballPlan_FocusCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/24.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "FootballPlan_FocusCell.h"

@implementation FootballPlan_FocusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setDataWithModel:(FootballRemarkListModel *)model{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"mrtx"]];
    _nameLabel.text = model.referrer;
    NSArray *retArr = [model.number componentsSeparatedByString:@","];
    for (UIView *vv in self.retView.subviews) {
        [vv removeFromSuperview];
    }
    if(retArr.count>1){
        for(int i = 0;i<retArr.count;i++){
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(24*i, 0, 20, 20)];
            lab.layer.cornerRadius = 3;
            lab.layer.masksToBounds = YES;
            lab.textColor = [UIColor whiteColor];
            lab.font = [UIFont systemFontOfSize:13];
            lab.textAlignment = NSTextAlignmentCenter;
            NSString *num = retArr[i];
            lab.text = num.integerValue == 0?@"红":@"黑";
            if([lab.text isEqualToString: @"红"]){
                lab.backgroundColor = [UIColor redColor];
            }else if ([lab.text isEqualToString:@"黑"]){
                lab.backgroundColor = [UIColor blackColor];
            }
            [self.retView addSubview:lab];
        }
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
