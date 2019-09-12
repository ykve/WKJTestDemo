//
//  SixRecommendHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixRecommendHeadView.h"
#import "RecommendDetailModel.h"

@implementation SixRecommendHeadView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.titlelab.baselineAdjustment = UIBaselineAdjustmentAlignCenters;

    return self;
}

-(UIImageView *)headimgv {
    
    if (!_headimgv) {
        
        _headimgv = [[UIImageView alloc]init];
        _headimgv.contentMode = UIViewContentModeScaleAspectFill;
        _headimgv.layer.cornerRadius = 15;
        _headimgv.layer.masksToBounds = YES;
        _headimgv.image = IMAGE(@"头像");
        [self addSubview:_headimgv];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        __weak typeof(self) weakSelf = self;
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.and.right.equalTo(self);
            make.top.equalTo(weakSelf.headimgv.mas_bottom).offset(15);
            make.height.equalTo(@1);
        }];
    }
    
    return _headimgv;
}

-(UIImageView *)iconimgv {
    
    if (!_iconimgv) {
        
        _iconimgv = [[UIImageView alloc]init];
//        _iconimgv.image = IMAGE(@"大神");
        _iconimgv.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconimgv];
    }
    return _iconimgv;
}

- (UIButton *)attentionBtn{
    
    if (!_attentionBtn) {
        _attentionBtn = [[UIButton alloc] init];
        _attentionBtn.backgroundColor = [[CPTThemeConfig shareManager] xinshuiDetailAttentionBtnBackGroundColor];
        [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
        [_attentionBtn setTitleColor:[[CPTThemeConfig shareManager] xinshuiDetailAttentionBtnNormalGroundColor] forState:UIControlStateNormal];
        [_attentionBtn setTitleColor:BASECOLOR forState:UIControlStateSelected];

        _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:14];

        [self addSubview:_attentionBtn];
        _attentionBtn.layer.cornerRadius = 5;
        _attentionBtn.layer.masksToBounds = YES;
        
        [_attentionBtn addTarget:self action:@selector(didClickAttentionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attentionBtn;
    
}

-(UILabel *)namelab {
    
    if (!_namelab) {
        
        _namelab = [[UILabel alloc]init];
        _namelab.font = FONT(14);
        [self addSubview:_namelab];
    }
    return _namelab;
}

//-(UILabel *)sourcelab {
//
//    if (!_sourcelab) {
//
//        _sourcelab = [[UILabel alloc]init];
//        _sourcelab.textColor = [UIColor lightGrayColor];
//        _sourcelab.font = FONT(13);
////        [self addSubview:_sourcelab];
//    }
//    return _sourcelab;
//}

-(UILabel *)titlelab {
    
    if (!_titlelab) {
        
        _titlelab = [[UILabel alloc]init];
        _titlelab.numberOfLines = 0;
        _titlelab.font = BOLDFONT(14);
        _titlelab.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_titlelab];
    }
    return _titlelab;
}

-(UILabel *)contentlab {
    
    if (!_contentlab) {
        
        _contentlab = [[UILabel alloc]init];
        _contentlab.font = FONT(14);
        _contentlab.numberOfLines = 0;
        [self addSubview:_contentlab];
    }
    return _contentlab;
}


- (void)didClickAttentionBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(attentionSomeone:)]) {
        [self.delegate attentionSomeone:btn];
    }
}
-(void)setModel:(RecommendDetailModel *)model {
    
    _model = model;
    
    [self.headimgv sd_setImageWithURL:IMAGEPATH(model.heads) placeholderImage:IMAGE(@"touxiang")];
    
    self.namelab.text = [NSString stringWithFormat:@"%@",model.referrer];
    
//    [self.self.iconimgv sd_setImageWithURL:[NSURL URLWithString:model.heads] placeholderImage:IMAGE(@"大神")];

    
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
    
    NSMutableAttributedString *titleStr=  [[NSMutableAttributedString alloc] initWithData:[ model.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];

    [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0, titleStr.length)];

    self.titlelab.attributedText = titleStr;
    
    [self layoutIfNeeded];

    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentlab.y + self.contentlab.height + 20);
    
}


-(void)layoutSubviews {
    
    [self.headimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self).offset(10);
//        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.headimgv.mas_right).offset(10);
//        make.top.equalTo(self.headimgv);
        make.centerY.equalTo(self.headimgv);
    }];
    
    
    [self.iconimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self.headimgv);
        make.width.height.equalTo(@30);
    }];
    
    [self.titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.headimgv.mas_bottom).offset(25);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@55);
        
    }];
    
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headimgv);
        make.left.equalTo(self.namelab.mas_right).offset(10);
        make.height.equalTo(@25);
        make.width.equalTo(@50);
    }];
    
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.left.and.right.equalTo(self.titlelab);
        make.left.equalTo(self).offset(10);
//        make.top.equalTo(self.headimgv.mas_bottom);
        make.top.equalTo(self.titlelab.mas_bottom).offset(0);
    }];

}

/**
 *  计算富文本的高度
 */
- (CGFloat)getAttributedStringHeightWithText:(NSAttributedString *)attributedString andWidth:(CGFloat)width andFont:(UIFont *)font {
    static UILabel *stringLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{//生成一个同于计算文本高度的label
        stringLabel = [[UILabel alloc] init];
        stringLabel.numberOfLines = 0;
    });
    stringLabel.font = font;
    stringLabel.attributedText = attributedString;
    
    return [stringLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)].height;;
}


@end
