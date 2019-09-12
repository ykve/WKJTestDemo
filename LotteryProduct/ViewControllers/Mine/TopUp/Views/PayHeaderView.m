//
//  PayHeaderView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PayHeaderView.h"

@implementation PayHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    
//    UIView *bottomView = [[UIView alloc] init];
//    bottomView.backgroundColor = [UIColor colorWithHex:@"#ECECEC"];
//    //    bottomView.layer.masksToBounds = YES;
//    [topBackView addSubview:bottomView];
//    //    bottomView.clipsToBounds = YES;
//
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(topBackView);
//        make.height.mas_equalTo(37);
//    }];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.image = [UIImage imageNamed:@"tw_pay_yhk"];
    [self addSubview:headImageView];
    _headImageView = headImageView;
    
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(23, 21));
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"-";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headImageView.mas_right).offset(8);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    UILabel *ddLabel = [UILabel new];
    ddLabel.text = @"-";
    ddLabel.font = [UIFont systemFontOfSize:15];
    ddLabel.textColor = [UIColor colorWithHex:@"#999999"];
    ddLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:ddLabel];
    _ddLabel = ddLabel;
    
    [ddLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(0.5));
    }];
   
    
}

@end
