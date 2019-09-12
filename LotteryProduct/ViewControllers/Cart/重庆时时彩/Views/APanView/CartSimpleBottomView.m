//
//  CartSimpleBottomView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CartSimpleBottomView.h"
#import "NSString+Size.h"

@interface CartSimpleBottomView()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *moneyView;
@property (nonatomic, strong)UIView *multiView;

@property (nonatomic, strong)UIScrollView *moneyScrollView;

//倍数
@property (nonatomic, assign)NSInteger multValue;


@property (weak, nonatomic) IBOutlet UITextField *multiTextField;


@property (weak, nonatomic) IBOutlet UIView *plusMinView;

@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIView *centerView;


@end

@implementation CartSimpleBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.delBtn.layer.masksToBounds = YES;
    self.delBtn.layer.borderWidth = 1;
    self.delBtn.layer.borderColor = [UIColor colorWithHex:@"#333333"].CGColor;
    self.delBtn.cornerRadius = 5; 
    self.delBtn.backgroundColor = [[CPTThemeConfig shareManager] CartSimpleBottomViewDelBtnBackgroundColor];
    [self.delBtn setImage:IMAGE([[CPTThemeConfig shareManager] CartSimpleBottomViewDelBtnImage]) forState:UIControlStateNormal];
    [self.delBtn setTitleColor:[[CPTThemeConfig shareManager] CO_BuyDelBtn] forState:UIControlStateNormal];
    
    self.publishBtn.layer.masksToBounds = YES;
    self.publishBtn.layer.cornerRadius = 5;
    self.multValue = 1;
    self.baseMoney = 100;
    self.plusMinView.layer.masksToBounds = YES;
    self.plusMinView.layer.cornerRadius = 15;
    self.backgroundColor = CLEAR;
    self.textField.placeholder = @"请输入金额";
    [self.textField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(refreshUI:) forControlEvents:UIControlEventEditingChanged];
    
    CGFloat paddingLeftWidth = self.textField.frame.size.width/5-3;
    [self.textField setValue:@(paddingLeftWidth) forKey:@"paddingLeft"];
    
    
    self.bottomTopView.backgroundColor = [[CPTThemeConfig shareManager] CartSimpleBottomViewTopBackgroundColor];
    self.centerView.backgroundColor = [[CPTThemeConfig shareManager] CartSimpleBottomViewTopBackgroundColor];
    self.textField.backgroundColor = [[CPTThemeConfig shareManager] Fantan_textFieldColor];
    
    [self.textField setValue:[[CPTThemeConfig shareManager] Fantan_tfPlaceholdColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.textField.textColor = [[CPTThemeConfig shareManager] CO_Buy_textFieldText];
    
//    self.textField.backgroundColor = [UIColor greenColor];
    
    UIImage *jianImg = [[CPTThemeConfig shareManager] Fantan_JianImg];
    UIImage *addImg = [[CPTThemeConfig shareManager] Fantan_AddImg];
    [self.jjBtn setImage:jianImg forState:UIControlStateNormal];
    [self.addBtn setImage:addImg forState:UIControlStateNormal];

    
    self.publishBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_buyBottomViewBtn];
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{

    [self.fatherView addSubview:self.moneyView];
    [[NSNotificationCenter defaultCenter] postNotificationName:CPTSHOWMONEYUI object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0) {
    CGFloat textWidth = [textField.text widthWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToHeight:20];
    CGFloat paddingLeftWidth = self.textField.frame.size.width/5 - (textWidth / 2);
    
    [textField setValue:@(paddingLeftWidth) forKey:@"paddingLeft"];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CPTHIDDENMONEYUI object:nil];
}
- (void)textFieldDidChangeValue:(UITextField *)textFeild{
    
    if ([self.multiTextField.text isEqualToString:@""]) {
        self.multiTextField.text = @"1";
    }
    
    NSInteger num = [self.textField.text integerValue];
    
    if (num <= 1) {
        num = 1;
        self.textField.text = @"1";
    }
    
}


- (IBAction)clearClick:(UIButton *)sender {
    
    if (self.bottomClickBlock) {
        self.bottomClickBlock(1,sender);
    }
}

- (void)refreshUI:(UITextField *)sender{
    if (self.bottomClickBlock) {
        self.bottomClickBlock(11,sender);
    }
}

- (IBAction)publishClick:(UIButton *)sender {
    
    if (self.bottomClickBlock) {

        self.bottomClickBlock(5,sender);
    }
}

- (IBAction)addClick:(UIButton *)sender {
    NSInteger money = [self.textField.text integerValue];
    money = money +1;
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)money];
    if (self.bottomClickBlock) {
        self.bottomClickBlock(10,sender);
    }
}

- (IBAction)jjClick:(UIButton *)sender {
    NSInteger money = [self.textField.text integerValue];
    money = money -1;
    if(money<=0){
        money = 0;
    }
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)money];
    if (self.bottomClickBlock) {
        self.bottomClickBlock(10,sender);
    }
}
#pragma mark 选择的钱数
- (void)selectMonsyValue:(UIButton *)sender{
    
    self.pricetype = sender.tag;
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
    
    
    self.totalMoney = self.multValue * self.baseMoney;
    NSLog(@"%f", self.totalMoney);
    
    [self endEditing:YES];
    [self.moneyView removeFromSuperview];
    
}

- (NSInteger)checkIsOkToBuy{
    NSInteger totleAvailable = 0;
    NSMutableDictionary * dic = [[CPTBuyDataManager shareManager] checkTmpCartArrayByType:self.superType superPlayKey:self.superPlayKey eachMoney:[self.textField.text integerValue]];
    NSInteger  num = [dic[CPTCART_TOTLEAvailable] integerValue];
    if(num>0){
        return num;
    }
    return totleAvailable;
}

- (NSInteger)checkLimitCount{
    NSInteger totleAvailable = 0;
    NSMutableDictionary * dic = [[CPTBuyDataManager shareManager] checkTmpCartArrayByType:self.superType superPlayKey:self.superPlayKey eachMoney:[self.textField.text integerValue]];
    NSInteger  num = [dic[CPTCART_LimitCount] integerValue];
    if(num>0){
        return num;
    }
    return totleAvailable;
}

- (void)refreshUI{
    NSInteger money = [self.textField.text integerValue];
    
    if (money <= 0) {
        money = 0;
        self.textField.text = @"";
    }
    //    if (money >= 10000) {
    //        money = 10000;
    //        self.textField.text = @"10000";
    //    }
    
    NSMutableDictionary * dic = [[CPTBuyDataManager shareManager] checkTmpCartArrayByType:self.superType superPlayKey:self.superPlayKey eachMoney:[self.textField.text integerValue]];
    UIColor *colorll = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_ViewC];
    NSString * num = [NSString stringWithFormat:@"%ld",(long)[dic[CPTCART_TOTLEAvailable] integerValue]];
    NSString * totle = [NSString stringWithFormat:@"%ld",(long)[dic[CPTCART_TOTLEMONEY] integerValue]];
    NSMutableAttributedString *totlettr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 注 %@ 元",num,totle]];
    [totlettr addAttribute:NSForegroundColorAttributeName value:colorll range:NSMakeRange(0, num.length)];
    [totlettr addAttribute:NSForegroundColorAttributeName value:colorll range:NSMakeRange(num.length + 3, totle.length)];
    
    self.pricelab.attributedText = totlettr;
    
    CGFloat max = [dic[CPTCART_MAXWIN] floatValue];
    NSString * maxWin;
    if(max>=100000.00){
        maxWin = [NSString stringWithFormat:@"%.2f万",max/10000.00];
    }
    else{
        maxWin = [NSString stringWithFormat:@"%.2f",[dic[CPTCART_MAXWIN] floatValue]];
    }
    NSMutableAttributedString *maxWinttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最高中 %@ 元",maxWin]];
    [maxWinttr addAttribute:NSForegroundColorAttributeName value:colorll range:NSMakeRange(4, maxWin.length)];
    [maxWinttr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(4, maxWin.length)];
    self.maxpricelab.attributedText = maxWinttr;
}

- (UIView *)moneyView{
    
    if (!_moneyView) {
        _moneyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.origin.y - 50, self.fatherView.frame.size.width, 50)];
        _moneyView.backgroundColor = [UIColor greenColor];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:_moneyView.bounds];
        scrollView.backgroundColor = [UIColor clearColor];
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

- (NSArray *)moneyArray{
    if (!_moneyArray) {
        _moneyArray = @[@"1角",@"5角",@"1元",@"5元",@"10元",@"100元",@"1000元",@"2000元",@"5000元",@"10000元"];
    }
    
    return _moneyArray;
}


@end
