//
//  LiuHeBangDanListTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeBangDanListTableViewCell.h"

@implementation LiuHeBangDanListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.winNumsLbl.layer.cornerRadius = 2;
    self.winNumsLbl.layer.masksToBounds = YES;
    self.winNumsLbl.backgroundColor = [UIColor colorWithHex:@"c01833"];
    self.iconBtn.layer.masksToBounds = YES;
    self.iconBtn.layer.cornerRadius = self.iconBtn.width/2;
    self.winRateLbl.textColor = [UIColor colorWithHex:@"c01833"];
    
}

- (void)setListModel:(DashenListModel *)listModel{
    _listModel = listModel;
    
    if (SCREEN_WIDTH <= 320) {
        if (listModel.recommender.length > 3) {
            self.nicknameLbl.text = [NSString stringWithFormat:@"%@…", [listModel.recommender substringWithRange:NSMakeRange(0, 3)]];
        }else{
            self.nicknameLbl.text = listModel.recommender;
        }
    }else if(SCREEN_WIDTH <= 375){
        if (listModel.recommender.length >=6) {
            self.nicknameLbl.text = [NSString stringWithFormat:@"%@…", [listModel.recommender substringWithRange:NSMakeRange(0, 6)]];
        }else{
            self.nicknameLbl.text = listModel.recommender;
        }
    }else{
        if (listModel.recommender.length >=8) {
            self.nicknameLbl.text = [NSString stringWithFormat:@"%@…", [listModel.recommender substringWithRange:NSMakeRange(0, 8)]];
        }else{
            self.nicknameLbl.text = listModel.recommender;
        }
    }
    
//    if (listModel.recommender.length >= 6) {
//
//        self.nicknameLbl.text = [NSString stringWithFormat:@"%@...", [listModel.recommender substringWithRange:NSMakeRange(0, 6)]];
//    }else{
//        self.nicknameLbl.text = listModel.recommender;
//    }

    self.fansLbl.text = [NSString stringWithFormat:@"粉丝数:%@",[Tools getWanString:[listModel.fansNumber integerValue]]] ;
    self.continueWinNumLbl.text = [NSString stringWithFormat:@"最大连中%@期", listModel.continuousNumber];
    
    NSInteger winrate = [listModel.winRate integerValue];
    self.winRateLbl.text = [NSString stringWithFormat:@"%zd%%", (long)winrate];
    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:listModel.photoUrl] forState:UIControlStateNormal placeholderImage:IMAGE(@"touxiang")];
    [self.rangeNumBtn setTitle:[NSString stringWithFormat:@"NO.%@", listModel.sort] forState:UIControlStateNormal];
    self.rangeNumBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    self.winNumsLbl.text = listModel.winsNumber;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
