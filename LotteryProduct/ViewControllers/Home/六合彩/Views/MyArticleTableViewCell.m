//
//  MyArticleTableViewCell.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/12.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "MyArticleTableViewCell.h"

@interface MyArticleTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;

@end

@implementation MyArticleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titlelab.textColor = MAINCOLOR;
    self.headimgv.layer.cornerRadius = 20;
    self.headimgv.layer.masksToBounds = YES;
    
    self.editBtn.layer.masksToBounds = YES;
    self.editBtn.layer.cornerRadius = 3;
    self.zanBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.seperatorLine.backgroundColor = [UIColor colorWithHex:@"F1F1F1"];

}


- (void)setModel:(RecommendlistModel *)model{
    
    _model = model;
    
    if ([model.type isEqualToString:@"大神"]) {
        
        self.iconimgv.image = IMAGE(@"大神");
    }
    else if ([model.type isEqualToString:@"大师"]) {
        
        self.iconimgv.image = IMAGE(@"大师");
    }
    else if ([model.type isEqualToString:@"彩帝"]) {
        self.iconimgv.image = IMAGE(@"彩帝");
    }
    else if ([model.type isEqualToString:@"高手"]) {
        
        self.iconimgv.image = IMAGE(@"高手");
    }
    
    
    NSMutableAttributedString *titleStr=  [[NSMutableAttributedString alloc] initWithData:[model.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:NSMakeRange(0, titleStr.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:NSMakeRange(0, titleStr.length)];
    
    [paragraphStyle setLineSpacing:12];
    
    [titleStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleStr.length)];

    
    self.titlelab.attributedText = titleStr;
    
    self.seecountlab.text = INTTOSTRING(model.realViews);
    self.timelab.text = model.createTime;
    self.remarkNumLbl.text = [NSString stringWithFormat:@"%ld", (long)model.commentCount];;
    self.zanNumLbl.text = [NSString stringWithFormat:@"%ld", (long)model.totalAdmire];
    [self.headimgv sd_setImageWithURL:IMAGEPATH(model.heads) placeholderImage:IMAGE(@"touxiang")];
    
    self.sourcelab.text = [NSString stringWithFormat:@"来自彩圈:%@",model.referrer];
    
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


- (IBAction)clickZanBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickZanBtn:)]) {
        [self.delegate clickZanBtn:sender];
    }
}


- (IBAction)clickEditBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(editArticle:)]) {
        [self.delegate editArticle:sender];
    }
}

@end
