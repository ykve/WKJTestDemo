//
//  FansCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/17.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "FansCell.h"

@implementation FansCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIImageView *)headimgv {
    
    if (!_headimgv) {
        
        _headimgv = [[UIImageView alloc]init];
        _headimgv.contentMode = UIViewContentModeScaleAspectFill;
        _headimgv.layer.masksToBounds = YES;
        _headimgv.layer.cornerRadius = 20;
        [self.contentView addSubview:_headimgv];
    }
    return _headimgv;
}

-(UILabel *)namelab {
    
    if (!_namelab) {
        
        _namelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
        [self.contentView addSubview:_namelab];
    }
    return _namelab;
}

-(UIButton *)attentionBtn {
    
    if (!_attentionBtn) {
        
        _attentionBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"+ 关注" andTitleColor:LINECOLOR andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(attentionClick:) andType:UIButtonTypeCustom];
        [_attentionBtn setTitle:@"取消关注" forState:UIControlStateSelected];
        _attentionBtn.layer.cornerRadius = 5;
        _attentionBtn.layer.borderColor = LINECOLOR.CGColor;
        _attentionBtn.layer.borderWidth = 1;
        [self.contentView addSubview:_attentionBtn];
    }
    return _attentionBtn;
}

-(void)setModel:(FansModel *)model {
    
    _model = model;
    
    [self.headimgv sd_setImageWithURL:IMAGEPATH(model.heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
    self.namelab.text = model.nickname;
    self.attentionBtn.selected = model.isFocus;
    
    [self layoutIfNeeded];
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.headimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.headimgv.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
}

-(void)attentionClick:(UIButton *)sender {
    
    [WebTools postWithURL:@"/circle/focusOrCancle" params:@{@"memberId":@(self.model.memberId),@"type":@(self.model.isFocus + 1)} success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info finish:^{
            
            self.model.isFocus = !self.model.isFocus;
            
            self.attentionBtn.selected = self.model.isFocus;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UPDATAFANSCOUNT" object:nil];
        }];
        
    } failure:^(NSError *error) {
        
        
    } showHUD:NO];
}

@end
