//
//  VVLongCollectionViewCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/7/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "VVLongCollectionViewCell.h"

@interface VVLongCollectionViewCell ()
@property (nonatomic, strong) UIImageView *checkImageView;
@end

@implementation VVLongCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor colorWithHex:@"#DDDDDD"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHex:@"#999999"];
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    UIImageView *checkImageView = [[UIImageView alloc] init];
    checkImageView.image = [UIImage imageNamed:@"ic_buyLot_check"];
    checkImageView.hidden = YES;
    [self addSubview:checkImageView];
    _checkImageView = checkImageView;
    
    [checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_top).offset(2);
        make.centerX.mas_equalTo(self.mas_right).offset(-2);
        make.size.mas_equalTo(13);
    }];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (self.selected) {
        self.backgroundColor = [UIColor colorWithHex:@"#B39660"];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.checkImageView.hidden = NO;
    } else {
        self.backgroundColor = [UIColor colorWithHex:@"#DDDDDD"];
        self.titleLabel.textColor =  [UIColor colorWithHex:@"#999999"];
        self.checkImageView.hidden = YES;
    }
}

@end
