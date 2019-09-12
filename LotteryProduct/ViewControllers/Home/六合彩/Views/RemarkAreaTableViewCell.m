//
//  RemarkAreaTableViewCell.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/11/26.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "RemarkAreaTableViewCell.h"

@interface RemarkAreaTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;

@end

@implementation RemarkAreaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.contentLbl sizeToFit];
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 8;
    self.seperatorLine.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    self.nicknameLbl.textColor = [UIColor colorWithWhite:0.5 alpha:0.5];

}

@end
