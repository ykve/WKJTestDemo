//
//  BuyLotBottomView.m
//  LotteryProduct
//
//  Created by pt c on 2019/8/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "BuyLotBottomView.h"
#import "NSString+Size.h"

@interface BuyLotBottomView() <UITextFieldDelegate>

@property (strong, nonatomic) UIButton *delBtn;
@property (strong, nonatomic) UIButton *shakeBtn;
@property (strong, nonatomic) UIView *centerView;

@end

@implementation BuyLotBottomView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        [self setUI];
    }
    return self;
}



- (void)setModel:(id)model {
    
}

- (void)setUI {
    
    [self.textField addTarget:self action:@selector(refreshUI) forControlEvents:UIControlEventEditingChanged];
    self.textField.backgroundColor = [[CPTThemeConfig shareManager] Fantan_textFieldColor];
    self.textField.textColor =  [[CPTThemeConfig shareManager] CO_Fantan_textFieldTextColor];;
    [self.textField setValue:[[CPTThemeConfig shareManager] Fantan_tfPlaceholdColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.textField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
    
    
    self.bottomTopView.backgroundColor = [[CPTThemeConfig shareManager] FantanColor4];
    self.centerView.backgroundColor = [[CPTThemeConfig shareManager] FantanColor2];
    self.cartBtn.backgroundColor = [[CPTThemeConfig shareManager] FantanColor1];

    [self.addCartBtn setTitleColor:[[CPTThemeConfig shareManager] CO_BuyLotBottomView_TopView3_BtnText] forState:UIControlStateNormal];
    self.publishBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_BuyLotBottomView_BotView2_BtnBack];
    
    UIImage *jianImg = [[CPTThemeConfig shareManager] Fantan_JianImg];
    UIImage *addImg = [[CPTThemeConfig shareManager] Fantan_AddImg];
    [self.jjBtn setImage:jianImg forState:UIControlStateNormal];
    [self.addBtn setImage:addImg forState:UIControlStateNormal];
    
    UIImage *delImg =[[CPTThemeConfig shareManager] Fantan_DelImg];
    UIImage *shakeImg =[[CPTThemeConfig shareManager] Fantan_ShakeImg];
    UIImage *addToImg =[[CPTThemeConfig shareManager] Fantan_AddToBasketImg];
    UIImage *basketImg =[[CPTThemeConfig shareManager] Fantan_basketImg];
    [self.addCartBtn setImage:addToImg forState:UIControlStateNormal];
    [self.shakeBtn setImage:shakeImg forState:UIControlStateNormal];
    [self.delBtn setImage:delImg forState:UIControlStateNormal];
    [self.cartBtn setImage:basketImg forState:UIControlStateNormal];
}


- (void)initSubviews {
    
    self.backgroundColor = [UIColor redColor];
    self.userInteractionEnabled = YES;
    
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    topView.userInteractionEnabled = YES;
    [self addSubview:topView];
    _bottomTopView = topView;
    
    
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.userInteractionEnabled = YES;
    bottomView.backgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_top);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    
    CGFloat viewWidth = kSCREEN_WIDTH/3;
    CGFloat midMoreidt = 10;
    
    UIView *top1View = [[UIView alloc] init];
    top1View.backgroundColor = [UIColor clearColor];
    [topView addSubview:top1View];
    
    
    UIButton *delBtn = [[UIButton alloc] init];
    [delBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(clearClick:) forControlEvents:UIControlEventTouchUpInside];
    [delBtn setImage:[UIImage imageNamed:@"cartclear"] forState:UIControlStateNormal];
    delBtn.tag = 1000;
    [top1View addSubview:delBtn];
    _delBtn = delBtn;
    
    [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(top1View);
        make.right.mas_equalTo(top1View.mas_centerX);
    }];
    
    UIButton *shakeBtn = [[UIButton alloc] init];
    [shakeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shakeBtn addTarget:self action:@selector(randomClick:) forControlEvents:UIControlEventTouchUpInside];
    [shakeBtn setImage:[UIImage imageNamed:@"cartrandom"] forState:UIControlStateNormal];
    shakeBtn.tag = 1001;
    [top1View addSubview:shakeBtn];
    _shakeBtn = shakeBtn;
    
    [shakeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(top1View);
        make.left.mas_equalTo(top1View.mas_centerX);
    }];
    
    UIView *top2View = [[UIView alloc] init];
    top2View.userInteractionEnabled = YES;
    top2View.backgroundColor = [UIColor clearColor];
    [topView addSubview:top2View];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont boldSystemFontOfSize:14.0];
    textField.textColor = [UIColor redColor];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 11.0) {
        // 针对 9.0 以上的iOS系统进行处理
        textField.placeholder = @"请输入金额";
    } else {
        // 针对 9.0 以下的iOS系统进行处理
        textField.placeholder = @"";
    }
    
    
    textField.text = @"2";
    CGFloat paddingLeftWidth = (viewWidth+midMoreidt) / 2 - (5 / 2) -8;
    [textField setValue:@(paddingLeftWidth) forKey:@"paddingLeft"];
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.layer.cornerRadius = 34/2;
    textField.layer.masksToBounds = YES;
    [top2View addSubview:textField];
    _textField = textField;
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(top2View);
        make.centerY.mas_equalTo(top2View.mas_centerY);
        make.height.mas_equalTo(34);
    }];
    
    UIButton *jjBtn = [[UIButton alloc] init];
    [jjBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jjBtn addTarget:self action:@selector(jjClick:) forControlEvents:UIControlEventTouchUpInside];
    [jjBtn setImage:[UIImage imageNamed:@"buy_jj"] forState:UIControlStateNormal];
    jjBtn.tag = 1002;
    [top2View addSubview:jjBtn];
    _jjBtn = jjBtn;
    
    [jjBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(top2View);
        make.width.mas_equalTo(35);
    }];
    
    
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setImage:[UIImage imageNamed:@"buy_add"] forState:UIControlStateNormal];
    addBtn.tag = 1003;
    [top2View addSubview:addBtn];
    _addBtn = addBtn;
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(top2View);
        make.width.mas_equalTo(35);
    }];
    
    
    UIButton *addCartBtn = [[UIButton alloc] init];
    [addCartBtn setTitle:@"加入购彩" forState:UIControlStateNormal];
    [addCartBtn setTitleColor:[UIColor colorWithHex:@"#333333"] forState:UIControlStateNormal];
    [addCartBtn addTarget:self action:@selector(addCartClick:) forControlEvents:UIControlEventTouchUpInside];
    addCartBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addCartBtn setImage:[UIImage imageNamed:@"cartset"] forState:UIControlStateNormal];
//    addCartBtn.backgroundColor = [UIColor clearColor];
    [addCartBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -6, 0.0, 0.0)];
    addCartBtn.tag = 1004;
    [topView addSubview:addCartBtn];
    _addCartBtn = addCartBtn;
    
    [top1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom);
        make.top.equalTo(topView.mas_top);
        make.left.equalTo(topView.mas_left);
        make.width.mas_equalTo(viewWidth-midMoreidt/2);
    }];
    
    [top2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom);
        make.top.equalTo(topView.mas_top);
        make.left.equalTo(top1View.mas_right);
        make.width.mas_equalTo(viewWidth+midMoreidt);
    }];
    
    [addCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(topView.mas_bottom);
        make.top.equalTo(topView.mas_top);
        make.right.equalTo(topView.mas_right);
        make.width.mas_equalTo(viewWidth-midMoreidt/2);
    }];
    
    
    
    
    
    
    // ****** 底部 ******
    UIView *bm1View = [[UIView alloc] init];
    bm1View.backgroundColor = [UIColor colorWithHex:@"#5DADFF"];
    [bottomView addSubview:bm1View];
    _centerView = bm1View;
    
    
    UILabel *pricelab = [[UILabel alloc] init];
    pricelab.text = @"0注0元";
    pricelab.font = [UIFont systemFontOfSize:13];
    pricelab.textColor = [UIColor whiteColor];
    pricelab.textAlignment = NSTextAlignmentCenter;
    pricelab.adjustsFontSizeToFitWidth = YES;
    [bm1View addSubview:pricelab];
    _pricelab = pricelab;
    
    [pricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bm1View);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *maxpricelab = [[UILabel alloc] init];
    maxpricelab.text = @"最高赢0.00元";
    maxpricelab.font = [UIFont systemFontOfSize:13];
    maxpricelab.textColor = [UIColor whiteColor];
    maxpricelab.textAlignment = NSTextAlignmentCenter;
    maxpricelab.adjustsFontSizeToFitWidth = YES;
    [bm1View addSubview:maxpricelab];
    _maxpricelab = maxpricelab;
    
    [maxpricelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bm1View);
        make.height.mas_equalTo(20);
    }];
    
    
    UIButton *publishBtn = [[UIButton alloc] init];
    [publishBtn setTitle:@"立即投注" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishClick:) forControlEvents:UIControlEventTouchUpInside];
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    publishBtn.backgroundColor = [UIColor colorWithHex:@"#FF8610"];
    publishBtn.tag = 200;
    [bottomView addSubview:publishBtn];
    _publishBtn = publishBtn;
    
    
    UIButton *cartBtn = [[UIButton alloc] init];
    [cartBtn setTitle:@"购彩篮" forState:UIControlStateNormal];
    [cartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cartBtn addTarget:self action:@selector(cartClick:) forControlEvents:UIControlEventTouchUpInside];
    cartBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cartBtn setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
    cartBtn.backgroundColor = [UIColor colorWithHex:@"#5DADFF"];
    cartBtn.tag = 201;
    [cartBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -6, 0.0, 0.0)];
    [bottomView addSubview:cartBtn];
    _cartBtn = cartBtn;
    
    [bm1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_bottom);
        make.top.equalTo(bottomView.mas_top);
        make.left.equalTo(bottomView.mas_left);
        make.width.mas_equalTo(viewWidth);
    }];
    
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_bottom);
        make.top.equalTo(bottomView.mas_top);
        make.left.equalTo(bm1View.mas_right);
        make.width.mas_equalTo(viewWidth);
    }];
    
    [cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_bottom);
        make.top.equalTo(bottomView.mas_top);
        make.right.equalTo(bottomView.mas_right);
        make.width.mas_equalTo(viewWidth);
    }];
    
}

// 清理
- (void)clearClick:(UIButton *)sender {
    
    if (self.bottomClickBlock) {
        
        self.bottomClickBlock(1,sender);
    }
}

// 随机
- (void)randomClick:(UIButton *)sender {
    
    if (self.bottomClickBlock) {
        self.bottomClickBlock(2,sender);
    }
}

- (void)setClick:(UIButton *)sender {
    
    if (self.bottomClickBlock) {
        self.bottomClickBlock(3,sender);
    }
}

// 加入购彩
- (void)addCartClick:(UIButton *)sender {
    
    if (self.bottomClickBlock) {
        self.bottomClickBlock(4,sender);
    }
}

// 投注
- (void)publishClick:(UIButton *)sender {
    
    if (self.bottomClickBlock) {
        
        self.bottomClickBlock(5,sender);
    }
}

// 购物篮
- (void)cartClick:(UIButton *)sender {
    
    if (self.bottomClickBlock) {
        
        self.bottomClickBlock(6,sender);
    }
}


- (void)addClick:(UIButton *)sender {
    NSInteger money = [self.textField.text integerValue];
    money = money +1;
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)money];
    [self refreshUI];
}

- (void)jjClick:(UIButton *)sender {
    NSInteger money = [self.textField.text integerValue];
    money = money -1;
    if(money<=0){
        money = 0;
    }
    self.textField.text = [NSString stringWithFormat:@"%ld",(long)money];
    [self refreshUI];
}

- (void)BuyLotteryButtonClick:(UIButton *)sender {
    
    if (sender.tag == 1000) {//删除
        
        if (self.bottomClickBlock) {
            
            self.bottomClickBlock(1,sender);
        }
        
    } else  if (sender.tag == 1100){     //选择钱数
        
    } else  if (sender.tag == 1002){//减
        
        
        
        
    } else  if (sender.tag == 1003){   //加
        
        
    } else  if (sender.tag == 1001){   //随机
        
        if (self.bottomClickBlock) {
            
            self.bottomClickBlock(2,sender);
        }
        
    } else  if (sender == self.addCartBtn){//加入购彩
        
        if (self.bottomClickBlock) {
            self.bottomClickBlock(4,sender);
        }
    }
}

#pragma mark -  UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CPTSHOWMONEYUI object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    CGFloat viewWidth = kSCREEN_WIDTH/3;
    CGFloat midMoreidt = 10;
    CGFloat textWidth = [textField.text widthWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToHeight:20];
    CGFloat paddingLeftWidth = (viewWidth+midMoreidt) / 2 - (textWidth / 2) -8;
    
    [textField setValue:@(paddingLeftWidth) forKey:@"paddingLeft"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CPTHIDDENMONEYUI object:nil];
}

- (void)textFieldDidChangeValue:(UITextField *)textFeild{
    
    NSInteger num = [self.textField.text integerValue];
    
    if (num <= 1) {
        num = 1;
        self.textField.text = @"1";
    }
}





// 检查是否可以购买
- (NSInteger)checkIsOkToBuy {
    NSInteger totleAvailable = 0;
    NSMutableDictionary * dic = [[CPTBuyDataManager shareManager] checkTmpCartArrayByType:self.superType superPlayKey:self.superPlayKey eachMoney:[self.textField.text integerValue]];
    NSInteger  num = [dic[CPTCART_TOTLEAvailable] integerValue];
    if(num>0){
        return num;
    }
    return totleAvailable;
}

// 检查限额
- (NSInteger)checkLimitCount {
    NSInteger totleAvailable = 0;
    NSMutableDictionary * dic = [[CPTBuyDataManager shareManager] checkTmpCartArrayByType:self.superType superPlayKey:self.superPlayKey eachMoney:[self.textField.text integerValue]];
    NSInteger  num = [dic[CPTCART_LimitCount] integerValue];
    if(num>0){
        return num;
    }
    return totleAvailable;
}

- (void)refreshUI {
    NSInteger money = [self.textField.text integerValue];
    
    if (money <= 0) {
        money = 0;
        self.textField.text = @"";
    }
    if (money >= 99999999) {
        money = 99999999;
        self.textField.text = @"99999999";
    }
    NSMutableDictionary * dic = [[CPTBuyDataManager shareManager] checkTmpCartArrayByType:self.superType superPlayKey:self.superPlayKey eachMoney:[self.textField.text integerValue]];
    UIColor *c = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_ViewC];
    if([[AppDelegate shareapp] sKinThemeType]== SKinType_Theme_White){
        c = [UIColor hexStringToColor:@"FFFF00"];
    }
    //    self.pricelab.text = [NSString stringWithFormat:@"%ld",[dic[CPTCART_TOTLEMONEY] integerValue]];
    NSString * num = [NSString stringWithFormat:@"%ld",(long)[dic[CPTCART_TOTLEAvailable] integerValue]];
    NSString * totle = [NSString stringWithFormat:@"%ld",(long)[dic[CPTCART_TOTLEMONEY] integerValue]];
    NSMutableAttributedString *totlettr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 注 %@ 元",num,totle]];
    [totlettr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(0, num.length)];
    [totlettr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(num.length + 3, totle.length)];
    
    self.pricelab.attributedText = totlettr;
    
    CGFloat max = [dic[CPTCART_MAXWIN] floatValue];
    NSString * maxWin;
    if(max>=100000000.00){
        maxWin = [NSString stringWithFormat:@"%.2f亿",max/100000000.00];
    }
    else if( max >=10000.00 ){
        maxWin = [NSString stringWithFormat:@"%.2f万",max/10000.00];
    }
    
    else{
        maxWin = [NSString stringWithFormat:@"%.2f",[dic[CPTCART_MAXWIN] floatValue]];
    }
    NSMutableAttributedString *maxWinttr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最高中 %@ 元",maxWin]];
    [maxWinttr addAttribute:NSForegroundColorAttributeName value:c range:NSMakeRange(4, maxWin.length)];
    [maxWinttr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(4, maxWin.length)];
    self.maxpricelab.attributedText = maxWinttr;
}

@end
