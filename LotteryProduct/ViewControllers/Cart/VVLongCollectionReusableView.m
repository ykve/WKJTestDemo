//
//  VVLongCollectionReusableView.m
//  LotteryProduct
//
//  Created by pt c on 2019/7/28.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "VVLongCollectionReusableView.h"

@implementation VVLongCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"-";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor colorWithHex:@"#666666"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    
}

@end
