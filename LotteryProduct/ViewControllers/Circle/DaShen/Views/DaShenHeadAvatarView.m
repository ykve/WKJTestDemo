//
//  DaShenHeadAvatarView.m
//  LotteryProduct
//
//  Created by pt c on 2019/9/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "DaShenHeadAvatarView.h"

@interface DaShenHeadAvatarView ()



@end

@implementation DaShenHeadAvatarView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGFloat marginWidht = 20;
    UIImageView *headImg = [[UIImageView alloc] init];
    headImg.layer.cornerRadius = 65/2;
    headImg.layer.masksToBounds = YES;
    [self addSubview:headImg];
    _headImg = headImg;

    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(marginWidht);
        if (self.imgWidht > 0) {
            make.size.mas_equalTo(self.imgWidht);
        } else {
            make.size.mas_equalTo(65);
        }
    }];
    
    UIImageView *ccImg = [[UIImageView alloc] init];
    ccImg.image = [UIImage imageNamed:@"redcircle"];
    [self addSubview:ccImg];
    _ccImg = ccImg;

    [ccImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(marginWidht);
        if (self.imgWidht > 0) {
            make.size.mas_equalTo(self.imgWidht);
        } else {
            make.size.mas_equalTo(65);
        }
    }];
    
    
    UIImageView *ttImg = [[UIImageView alloc] init];
    [self addSubview:ttImg];
    _ttImg = ttImg;

    [ttImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headImg.mas_left).offset(2);
        make.centerY.equalTo(headImg.mas_top).offset(2);
        make.size.mas_equalTo(26);
    }];
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"-";
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor darkGrayColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *ppLabel = [[UILabel alloc] init];
    ppLabel.text = @"-";
    ppLabel.font = [UIFont systemFontOfSize:15];
    ppLabel.textColor = [UIColor darkGrayColor];
    ppLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:ppLabel];
    _ppLabel = ppLabel;

    [ppLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(nameLabel.mas_top).offset(-5);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(15);
    }];

}

- (void)setImgWidht:(CGFloat)imgWidht {
    _imgWidht = imgWidht;
    
    [self.headImg mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.imgWidht > 0) {
            make.size.mas_equalTo(self.imgWidht);
        } else {
            make.size.mas_equalTo(65);
        }
    }];
    
    [self.ccImg mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.imgWidht > 0) {
            make.size.mas_equalTo(self.imgWidht);
        } else {
            make.size.mas_equalTo(65);
        }
    }];
    
    [self.ttImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headImg.mas_left).offset(3);
        make.centerY.equalTo(self.headImg.mas_top).offset(3);
    }];
    
    self.headImg.layer.cornerRadius = imgWidht/2;
    self.headImg.layer.masksToBounds = YES;
    
//    self.ccImg.layer.cornerRadius = imgWidht/2;
//    self.ccImg.layer.masksToBounds = YES;
    
}

@end
