//
//  HistoryArticleTableViewCell.m
//  HappyChat
//
//  Created by 研发中心 on 2018/11/24.
//  Copyright © 2018 研发中心. All rights reserved.
//

#import "HistoryArticleTableViewCell.h"
#import "RecommendlistModel.h"
#import "RecommendDetailModel.h"

@interface HistoryArticleTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *seperatotLine;
@property (weak, nonatomic) IBOutlet UIButton *loginVisibleBtn;

@end

@implementation HistoryArticleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titlelab.textColor = MAINCOLOR;
    self.titlelab.numberOfLines = 5;
    self.titlelab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.headimgv.layer.cornerRadius = 18;
    self.headimgv.layer.masksToBounds = YES;
    
    self.editBtn.layer.masksToBounds = YES;
    self.editBtn.layer.cornerRadius = 3;
    self.zanBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.seperatotLine.backgroundColor = [UIColor colorWithHex:@"F1F1F1"];
    self.remarkNumLbl.textAlignment = NSTextAlignmentLeft;
    
}
- (IBAction)edit:(id)sender {
    if ([self.delegate respondsToSelector:@selector(editArticle:)]) {
        [self.delegate editArticle:sender];
    }
}

- (void)setModel:(RecommendlistModel *)model{
    
    _model = model;
    
    if ([model.type isEqualToString:@"大神"]) {
        self.iconimgv.image = IMAGE(@"大神");
    } else if ([model.type isEqualToString:@"大师"]) {
        self.iconimgv.image = IMAGE(@"大师");
    } else if ([model.type isEqualToString:@"彩帝"]) {
        self.iconimgv.image = IMAGE(@"彩帝");
    } else if ([model.type isEqualToString:@"高手"]) {
        self.iconimgv.image = IMAGE(@"高手");
    } else {
        self.iconimgv.image = IMAGE(@"");
    }
    
    self.titlelab.text = model.title;
    
    self.timelab.text = model.createTime;
    self.seecountlab.text = [Tools getWanString:model.realViews];
    self.remarkNumLbl.text = [Tools getWanString:model.commentCount];
    self.zanNumLbl.text = [Tools getWanString:model.totalAdmire];
    [self.headimgv sd_setImageWithURL:IMAGEPATH(model.heads) placeholderImage:IMAGE(@"touxiang")];
//    self.sourcelab.text = [NSString stringWithFormat:@"来自彩圈:%@",model.referrer];
    NSString *nicknameStr = [NSString stringWithFormat:@"来自彩圈:%@",model.referrer];
    
    if (nicknameStr.length  > 10) {
        self.sourcelab.text = [nicknameStr substringToIndex:10];
    }else{
        if (nicknameStr.length > 0) {
            self.sourcelab.text = nicknameStr;
        } else {
            self.sourcelab.text = @"-";
        }
        
    }
    
    if (model.loginViewFlag) {
        self.loginVisibleBtn.hidden = NO;
    }else{
        self.loginVisibleBtn.hidden = YES;
    }
    
    if ([model.locked isEqualToString:@"1"]) {
        self.editBtn.backgroundColor = [UIColor lightGrayColor];
        self.editBtn.enabled = NO;
        [self.editBtn setTitle:@"已锁帖" forState:UIControlStateNormal];
        [self.editBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }else{
        self.editBtn.backgroundColor = MAINCOLOR;
        [self.editBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
}

- (IBAction)didClickZanBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickZanBtn:)]) {
        [self.delegate clickZanBtn:sender];
    }
}

@end
