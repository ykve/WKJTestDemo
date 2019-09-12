//
//  CirclelistCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/15.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CirclelistCell.h"

@implementation CirclelistCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
     if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
         
         self.bgView = [[UIView alloc]init];
         self.bgView.backgroundColor = [[CPTThemeConfig shareManager] Circle_Cell_BackgroundC]; //[UIColor colorWithHex:@"2C3036"];//daniel
         [self addSubview:self.bgView];
         [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
             
             make.edges.equalTo(self);
         }];
     }
    return self;
}

-(UIImageView *)headimgv {
    
    if (!_headimgv) {
        
        _headimgv = [[UIImageView alloc]init];
        _headimgv.contentMode = UIViewContentModeScaleAspectFill;
        _headimgv.layer.masksToBounds = YES;
        _headimgv.layer.cornerRadius = 22;
        [self addSubview:_headimgv];
    }
    return _headimgv;
}

-(UILabel *)namelab {
    
    if (!_namelab) {
        
        _namelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(14) andTitleColor:[UIColor lightGrayColor] andBackgroundColor:CLEAR andTextAlignment:0];
        [self addSubview:_namelab];
    }
    return _namelab;
}

-(UILabel *)contentlab {
    
    if (!_contentlab) {
        
        _contentlab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:[UIFont systemFontOfSize:15 weight:UIFontWeightRegular] andTitleColor:[[CPTThemeConfig shareManager] Circle_Cell_ContentlabC] andBackgroundColor:CLEAR andTextAlignment:0];
        _contentlab.numberOfLines = 0;
        [self addSubview:_contentlab];
    }
    return _contentlab;
}

-(UILabel *)timelab {
    
    if (!_timelab) {
        
        _timelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:[UIColor lightGrayColor] andBackgroundColor:CLEAR andTextAlignment:0];
        [self addSubview:_timelab];
    }
    return _timelab;
}

-(UIButton *)likeBtn {
    
    if (!_likeBtn) {
        
        _likeBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:[UIColor lightGrayColor] andBackgroundImage:nil andImage:IMAGE(@"圈子点赞") andTarget:self andAction:@selector(likeClick:) andType:UIButtonTypeCustom];
        [_likeBtn setImage:IMAGE(@"赞_选中") forState:UIControlStateSelected];
        [_likeBtn setTitleColor:[UIColor colorWithHex:@"ED6630"] forState:UIControlStateNormal];

        [self addSubview:_likeBtn];
    }
    return _likeBtn;
}

-(UIButton *)commentBtn {
    
    if (!_commentBtn) {
        
        _commentBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:[UIColor lightGrayColor] andBackgroundImage:nil andImage:IMAGE(@"圈子评论") andTarget:self andAction:@selector(commentClick:) andType:UIButtonTypeCustom];
        [self addSubview:_commentBtn];
        [_commentBtn setTitleColor:[UIColor colorWithHex:@"ED6630"] forState:UIControlStateNormal];
    }
    return _commentBtn;
}

-(UILabel *)useselfdaylab {
    
    if (!_useselfdaylab) {
        
        _useselfdaylab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:BOLDFONT(18) andTitleColor:[UIColor blackColor] andBackgroundColor:CLEAR andTextAlignment:1];
        [self addSubview:_useselfdaylab];
    }
    return _useselfdaylab;
}

-(UILabel *)useselfmonthlab {
    
    if (!_useselfmonthlab) {
        
        _useselfmonthlab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(14) andTitleColor:[UIColor lightGrayColor] andBackgroundColor:CLEAR andTextAlignment:1];
        [self addSubview:_useselfmonthlab];
    }
    return _useselfmonthlab;
}

-(UIButton *)attentionBtn {
    
    if (!_attentionBtn) {
        
        _attentionBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"关注" andTitleColor:[[CPTThemeConfig shareManager] Circle_Cell_AttentionBtn_TitleC] andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(attentionClick:) andType:UIButtonTypeCustom];
        [_attentionBtn setImage:IMAGE(@"关注") forState:UIControlStateNormal];
        _attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        _attentionBtn.layer.cornerRadius = 5;
        _attentionBtn.layer.borderColor = [[CPTThemeConfig shareManager] Circle_Cell_AttentionBtn_TitleC].CGColor;
        _attentionBtn.layer.borderWidth = 1;
        _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_attentionBtn];
    }
    return _attentionBtn;
}

-(UIButton *)deleteBtn {
    
    if (!_deleteBtn) {
        
        _deleteBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"circledelete") andTarget:self andAction:@selector(deleteClick:) andType:UIButtonTypeCustom];
        [self addSubview:_deleteBtn];
    }
    return _deleteBtn;
}

-(CirclePhotosView *)photosView {
    
    if (!_photosView) {
        
        _photosView = [[CirclePhotosView alloc]init];
        _photosView.backgroundColor = CLEAR;
        
        [self addSubview:_photosView];
    }
    return _photosView;
}

//-(UIView *)line {
//    
//    if (!_line) {
//        
//        _line = [[UIView alloc]init];
//        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        [self addSubview:_line];
//    }
//    return _line;
//}

//-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
//
//    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
//
//        self.bgView = [[UIView alloc]init];
//        self.bgView.backgroundColor = [UIColor colorWithHex:@"2D2F36"];
//        [self addSubview:self.bgView];
//        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.edges.equalTo(self);
//        }];
//    }
//    return self;
//}

-(void)layoutSubviews {
    
    
    [self.headimgv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.headimgv.mas_right).offset(10);
        make.top.equalTo(self.headimgv.mas_top);
//        make.centerY.equalTo(self.headimgv);
    }];

    
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.headimgv.mas_top);
//        make.centerY.equalTo(self.namelab);
        make.size.mas_equalTo(CGSizeMake(75, 25));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.namelab);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.namelab);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.headimgv.mas_bottom).offset(-20);
        
    }];
    [self.photosView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.namelab);
        make.top.equalTo(self.contentlab.mas_bottom).offset(10);
        CGSize photos_size = [CirclePhotosView sizeWithImages:self.model.circlePost.imageurlArray width:SCREEN_WIDTH - 74 andMargin:10];
        make.size.mas_equalTo(photos_size);
    }];
    
    [self.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.namelab);
        make.top.equalTo(self.photosView.mas_bottom).offset(10);
    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.timelab);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.commentBtn.mas_left).offset(-15);
        make.centerY.equalTo(self.timelab);
    }];
    
    [self.useselfdaylab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(30);
        make.size.mas_equalTo(CGSizeMake(44, 25));
    }];
    
    [self.useselfmonthlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.useselfdaylab.mas_bottom).offset(4);
        make.centerX.equalTo(self.useselfdaylab);
        make.height.equalTo(@18);
    }];

//    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.bottom.right.equalTo(self);
//        make.height.equalTo(@1);
//    }];
    
}

-(void)setModel:(CircleModel *)model {
    
    _model = model;
    [self.headimgv yy_setImageWithURL:IMAGEPATH(model.postMember.heads) placeholder:DEFAULTHEAD];

    self.namelab.textColor = [[CPTThemeConfig shareManager] Circle_Title_nameColor];

    self.namelab.text = model.postMember.nickname;
    self.contentlab.text = model.circlePost.content;
    [self.likeBtn setTitle:[NSString stringWithFormat:@" %ld ",(long)model.circlePost.praiseNumber] forState:UIControlStateNormal];
    self.likeBtn.selected = model.circlePost.meHasPraise;
    [self.commentBtn setTitle:[NSString stringWithFormat:@" %ld ",(long)model.circlePost.replyNumber] forState:UIControlStateNormal];
    
    NSString *time = [Tools returnchuototime:model.circlePost.createTime.stringValue.length > 10 ? [model.circlePost.createTime.stringValue substringToIndex:10] : model.circlePost.createTime.stringValue];
    self.timelab.text = time;

    self.useselfmonthlab.text = [NSString stringWithFormat:@"%@月",[time substringWithRange:NSMakeRange(5, 2)]];
    self.useselfdaylab.text = [time substringWithRange:NSMakeRange(8, 2)];
    self.useselfmonthlab.hidden = !self.isusercircle;
    self.useselfdaylab.hidden = !self.isusercircle;
    self.timelab.hidden = self.isusercircle;
    self.headimgv.hidden = self.isusercircle;
    [self.attentionBtn setTitle:model.postMember.isFocus == 0 ? @"关注" : @" 取消关注" forState:UIControlStateNormal];
    UIImage *normalImg = IMAGE(@"关注");
    UIImage *selectlImg = IMAGE(@"");

    
    [self.attentionBtn setImage:model.postMember.isFocus == 0 ? normalImg : selectlImg forState:UIControlStateNormal];
    if ([Person person].uid.integerValue == model.postMember.memberId) {
        
        self.attentionBtn.hidden = YES;
        self.deleteBtn.hidden = NO;
    }
    else {
        self.attentionBtn.hidden = NO;
        self.deleteBtn.hidden = YES;
    }
    self.photosView.imageurlArray = model.circlePost.imageurlArray;
    
    [self layoutIfNeeded];
}



+(CGFloat)getHeight:(CircleModel *)model {
    
    CGFloat content_h = [Tools createLableHighWithString:model.circlePost.content andfontsize:15 andwithwidth:SCREEN_WIDTH - 74];
    
    CGFloat photos_h = [CirclePhotosView sizeWithImages:model.circlePost.imageurlArray width:SCREEN_WIDTH - 74 andMargin:10].height;
    
    return 10 + 44 + 10 + content_h + photos_h + 30 + 10 ;

}

-(void)likeClick:(UIButton *)sender {
    
    if (self.circleClickBlock) {
        
        self.circleClickBlock(1, sender);
    }
}

-(void)commentClick:(UIButton *)sender {
    
    if (self.circleClickBlock) {
        
        self.circleClickBlock(2, sender);
    }
}

-(void)attentionClick:(UIButton *)sender {
    
    if (self.circleClickBlock) {
        
        self.circleClickBlock(3, sender);
    }
}

-(void)deleteClick:(UIButton *)sender {
    
    if (self.circleClickBlock) {
        
        self.circleClickBlock(4,sender);
    }
}


@end
