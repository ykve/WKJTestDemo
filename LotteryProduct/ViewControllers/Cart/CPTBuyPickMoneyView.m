
//
//  CPTBuyPickMoneyView.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/25.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuyPickMoneyView.h"

@interface CPTBuyPickMoneyView()
{
    NSArray *_moneyArray;
    NSInteger _pricetype;
}
@end

@implementation CPTBuyPickMoneyView

- (void)dealloc{
    _moneyArray = nil;
}

- (instancetype)init{
    self = [super init];
    if(self){
        _moneyArray = @[@"1元",@"5元",@"10元",@"100元",@"1000元",@"2000元",@"5000元",@"10000元"];
    }
    return self;
}

- (void)show{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(44.);
    }];
}

- (void)brokeBlock{
    if(self.clickBlock){
        _clickBlock = nil;
    }
}

- (void)configUIWith:(void (^)(NSInteger money))click {
    kWeakSelf;
    weakSelf.clickBlock = click;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self);
    }];
   
    scrollView.backgroundColor = [[CPTThemeConfig shareManager] CO_ScrMoneyNumViewBack];
    
    scrollView.bounces = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < _moneyArray.count; i++) {
        CGFloat w = 80;
        CGFloat h = 28;
        CGFloat y = 10;
        CGFloat margin = 10;
        CGFloat x = margin + (w + margin) * i;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(x, y, w, h);
        button.layer.cornerRadius = 3;
        button.layer.borderColor = [[CPTThemeConfig shareManager] CO_ScrMoneyNumBtnText].CGColor;
        button.layer.borderWidth = 0.5;
//        button.layer.shadowOpacity = 0.8f;
//        button.layer.shadowRadius = 4.f;
//        button.layer.shadowOffset = CGSizeMake(4,4);
        [button setTitle:[NSString stringWithFormat:@"%@", _moneyArray[i]] forState:UIControlStateNormal];
        [button setTitleColor:[[CPTThemeConfig shareManager] CO_ScrMoneyNumBtnText] forState:UIControlStateNormal];
        button.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_ThemeColorOne];
        button.tag = i;
        [button addTarget:self action:@selector(selectMonsyValue:) forControlEvents:UIControlEventTouchUpInside];

        [scrollView addSubview:button];
    }
    scrollView.contentSize = CGSizeMake(10 + (80 + 10) * _moneyArray.count, 0);
}

- (void)btnTouchDown:(UIButton *)button{
    button.layer.shadowOpacity = 0.8f;
    button.layer.shadowRadius = 4.f;
    button.layer.shadowOffset = CGSizeMake(4,4);
    button.layer.shadowColor = [[CPTThemeConfig shareManager] CO_NavigationBar_Title].CGColor;
}

#pragma mark 选择的钱数
- (void)selectMonsyValue:(UIButton *)sender{
//    sender.layer.shadowOpacity = 0.0f;
//    sender.layer.shadowRadius = 0.f;
//    sender.layer.shadowOffset = CGSizeMake(0,0);
        switch (sender.tag) {
        case 0:
            _pricetype = 1;
            break;
        case 1:
            _pricetype = 5;
            break;
        case 2:
            _pricetype = 10;
            break;
        case 3:
            _pricetype = 100;
            break;
        case 4:
            _pricetype = 1000;
            break;
        case 5:
            _pricetype = 2000;
            break;
        case 6:
            _pricetype = 5000;
            break;
        case 7:
            _pricetype = 10000;
            break;
            
        default:
            break;
    }
    if(self.clickBlock){
        self.clickBlock(_pricetype);
    }
}


@end
