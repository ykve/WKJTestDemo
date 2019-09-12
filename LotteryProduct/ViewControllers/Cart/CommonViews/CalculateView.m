//
//  CalculateView.m
//  BuyLotteryBanner
//
//  Created by 研发中心 on 2018/12/28.
//  Copyright © 2018 研发中心. All rights reserved.
//

#import "CalculateView.h"

@interface CalculateView()<UITextFieldDelegate>


@property (nonatomic, strong)UIView *moneyView;
@property (nonatomic, strong)UIView *multiView;

@property (nonatomic, strong)UIScrollView *moneyScrollView;
@property (nonatomic, strong)UIScrollView *multiScrollView;



//倍数
@property (nonatomic, assign)NSInteger multValue;


@property (weak, nonatomic) IBOutlet UITextField *multiTextField;


@property (weak, nonatomic) IBOutlet UIButton *totalMonryBtn;

@property (weak, nonatomic) IBOutlet UIView *plusMinView;



@end

@implementation CalculateView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.multValue = 1;
    self.baseMoney = 100;
    self.plusMinView.layer.masksToBounds = YES;
    self.plusMinView.layer.cornerRadius = 15;
    self.totalMonryBtn.backgroundColor = [UIColor whiteColor];
    self.totalMonryBtn.layer.cornerRadius = 15;
    self.totalMonryBtn.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    self.multiTextField.delegate = self;
    
    [self.multiTextField addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventEditingChanged];

}


- (IBAction)BuyLotteryButtonClick:(UIButton *)sender {
    
    if (sender.tag == 10) {//删除
        NSLog(@"删除");
        
    }else  if (sender.tag == 20){//选择钱数
        
        [self.multiView removeFromSuperview];
        
        sender.selected = sender.selected ? NO : YES;
        
        if (sender.selected) {
            
            [self.fatherView addSubview:self.moneyView];
            
        }else{
            
            [self.moneyView removeFromSuperview];
        }
        
    }else  if (sender.tag == 30){//减
        
        NSInteger num = [self.multiTextField.text integerValue] - 1;
        
        if (num <= 1) {
            num = 1;
        }
        if (num >= 1000) {
            num = 1000;
        }
        self.multValue = num;
        self.multiTextField.text = [NSString stringWithFormat:@"%ld", num];
        
        self.totalMoney = self.multValue * self.baseMoney;
        NSLog(@"%f", self.totalMoney);
        

        
    }else  if (sender.tag == 40){//加
        
        NSInteger num = [self.multiTextField.text integerValue] + 1;
        
        if (num <= 1) {
            num = 1;
        }
        if (num >= 1000) {
            num = 1000;
        }
        
        self.multValue = num;
        
        self.multiTextField.text = [NSString stringWithFormat:@"%ld", num];
        
        self.totalMoney = self.multValue * self.baseMoney;
        NSLog(@"%f", self.totalMoney);
        
    }else  if (sender.tag == 50){//随机
        
        NSLog(@"随机");
        
    }else  if (sender.tag == 60){//加入购彩
        
        NSLog(@"加入采购");
        
    }
}
#pragma mark 选择的钱数
- (void)selectMonsyValue:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:
            self.baseMoney = 0.1;
            break;
        case 1:
            self.baseMoney = 0.5;
            break;
        case 2:
            self.baseMoney = 1;
            break;
        case 3:
            self.baseMoney = 5;
            break;
        case 4:
            self.baseMoney = 10;
            break;
        case 5:
            self.baseMoney = 100;
            break;
        case 6:
            self.baseMoney = 1000;
            break;
        case 7:
            self.baseMoney = 2000;
            break;
        case 8:
            self.baseMoney = 5000;
            break;
        case 9:
            self.baseMoney = 10000;
            break;
            
        default:
            break;
    }
    
    [self.totalMonryBtn setTitle:[NSString stringWithFormat:@"%.1f元", self.baseMoney ] forState:UIControlStateNormal];
    
    self.totalMoney = self.multValue * self.baseMoney;
    NSLog(@"%f", self.totalMoney);
    

    [self.moneyView removeFromSuperview];
    self.totalMonryBtn.selected = NO;
    
}

#pragma mark 选择倍数

- (void)selectMultiNum:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            self.multiNum = 5;
            break;
        case 1:
            self.multiNum = 10;
            break;
        case 2:
            self.multiNum = 20;
            break;
        case 3:
            self.multiNum = 50;
            break;
        case 4:
            self.multiNum = 100;
            break;
        case 5:
            self.multiNum = 200;
            break;
        case 6:
            self.multiNum = 500;
            break;
        case 7:
            self.multiNum = 1000;
            break;
        default:
            break;
    }
    
    self.multiTextField.text = [NSString stringWithFormat:@"%.f", self.multiNum];
    [self.multiView removeFromSuperview];

}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.moneyView removeFromSuperview];
    [self.fatherView addSubview:self.multiView];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.multiView removeFromSuperview];
}

- (void)textFieldDidChangeValue:(UITextField *)textFeild{
    
    [self.fatherView addSubview:self.moneyView];

    if ([self.multiTextField.text isEqualToString:@""]) {
        self.multiTextField.text = @"1";
    }
    
    NSInteger num = [self.multiTextField.text integerValue];
    
    if (num <= 1) {
        num = 1;
        self.multiTextField.text = @"1";
    }
    if (num >= 1000) {
        num = 1000;
        self.multiTextField.text = @"1000";
    }
    self.multValue = [textFeild.text integerValue];
    
    self.totalMoney = self.multValue * self.baseMoney;
    
    self.totalMoney = self.multValue * self.baseMoney;
    NSLog(@"%f", self.totalMoney);
    

}


- (UIView *)moneyView{
    
    if (!_moneyView) {
        _moneyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.origin.y - 50, self.fatherView.frame.size.width, 50)];
        _moneyView.backgroundColor = [UIColor redColor];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:_moneyView.bounds];
        scrollView.backgroundColor = [UIColor colorWithRed:193/255.0 green:173/255.0 blue:127/255.0 alpha:1.0];
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        self.moneyScrollView = scrollView;
        scrollView.contentSize = CGSizeMake(10 + (80 + 10) * self.moneyArray.count, 0);
      
        for (int i = 0; i < self.moneyArray.count; i++) {
            CGFloat w = 80;
            CGFloat h = 30;
            CGFloat y = 10;
            CGFloat margin = 10;
            CGFloat x = margin + (w + margin) * i;
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
            
            button.layer.cornerRadius = 10;
            
            button.layer.shadowColor = [UIColor blackColor].CGColor;
            button.layer.shadowOpacity = 0.8f;
            button.layer.shadowRadius = 4.f;
            button.layer.shadowOffset = CGSizeMake(4,4);

            
            [button setTitle:[NSString stringWithFormat:@"%@", self.moneyArray[i]] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
            button.tag = i;
            [button addTarget:self action:@selector(selectMonsyValue:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [scrollView addSubview:button];
            
        }
        
        [_moneyView addSubview:scrollView];
        
        
    }
    
    return _moneyView;
}


- (UIView *)multiView{
    
    if (!_multiView) {
        _multiView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.origin.y - 50, self.fatherView.frame.size.width, 50)];
        _multiView.backgroundColor = [UIColor redColor];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:_multiView.bounds];
        scrollView.backgroundColor = [UIColor colorWithRed:193/255.0 green:173/255.0 blue:127/255.0 alpha:1.0];
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        self.multiScrollView = scrollView;
        scrollView.contentSize = CGSizeMake(10 + (80 + 10) * self.multiArray.count, 0);
        

        for (int i = 0; i < self.multiArray.count; i++) {
            CGFloat w = 80;
            CGFloat h = 30;
            CGFloat y = 10;
            CGFloat margin = 10;
            CGFloat x = margin + (w + margin) * i;
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
            
            button.layer.cornerRadius = 10;
            
            button.layer.shadowColor = [UIColor blackColor].CGColor;
            button.layer.shadowOpacity = 0.8f;
            button.layer.shadowRadius = 4.f;
            button.layer.shadowOffset = CGSizeMake(4,4);
            
            button.tag = i;
            
            [button setTitle:[NSString stringWithFormat:@"%@", self.multiArray[i]] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
            button.tag = i;
            [button addTarget:self action:@selector(selectMultiNum:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollView addSubview:button];
            
        }
        
        [_multiView addSubview:scrollView];
        
        
    }
    
    return _multiView;
}


@end
