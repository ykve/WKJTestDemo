//
//  AttentionCollectionViewCell.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/3.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "AttentionCollectionViewCell.h"

@interface AttentionCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;


@end

@implementation AttentionCollectionViewCell

- (IBAction)CancelAttention:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(deleteAttentionPerson:)]) {
        [self.delegate deleteAttentionPerson:sender];
    }
}

- (void)setModel:(FollowModel *)model{
    
    _model = model;

    [self.iconView sd_setImageWithURL:IMAGEPATH(model.heads) placeholderImage:IMAGE(@"touxiang")];
    if (model.nickname.length > 0) {
        self.nicknameLbl.text = model.nickname;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.closeBtn.hidden = YES;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 24;
    [self.closeBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    self.nicknameLbl.textColor = [UIColor colorWithHex:@"333333"];
}

@end
