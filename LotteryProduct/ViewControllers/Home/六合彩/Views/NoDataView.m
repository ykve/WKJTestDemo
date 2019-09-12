//
//  NoDataView.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/9.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "NoDataView.h"

@interface NoDataView ()

@property (nonatomic, strong) UIButton *connectFailBtn;

@property (nonatomic, strong)UILabel *noDataLbl;



@end

@implementation NoDataView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
//    [self addSubview:self.connectFailBtn];
    [self addSubview:self.noDataLbl];
    
    return self;
}

- (UILabel *)noDataLbl{
    if (!_noDataLbl) {
        _noDataLbl = [[UILabel alloc] initWithFrame:CGRectMake((self.width - 100)/2, 20, 100, 20)];
        _noDataLbl.text = @"没有数据";
        _noDataLbl.textAlignment = NSTextAlignmentCenter;
        _noDataLbl.textColor = [UIColor lightGrayColor];
        _noDataLbl.font = [UIFont systemFontOfSize:14];
    }
 
    return _noDataLbl;
}

- (UIButton *)connectFailBtn{
    if (_connectFailBtn) {
        _connectFailBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.width - 60)/2, 20, 60, 30)];
        [_connectFailBtn setTitle:@"重新加载" forState: UIControlStateNormal];
    }
    return _connectFailBtn;
}

@end
