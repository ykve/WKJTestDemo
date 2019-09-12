//
//  ApplyExpertCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/19.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ApplyExpertCtrl.h"

@interface ApplyExpertCtrl ()

@property (nonatomic, strong)UIImageView *headimgv;

@property (nonatomic, strong)IQTextView *textView;

@property (nonatomic, strong)UITextField *qqfield;

@end

@implementation ApplyExpertCtrl

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [[CPTThemeConfig shareManager] applyExpertBackgroundColor];
    self.titlestring = @"申请专家";
    
    [self buildUI];
}

-(void)buildUI {
    UIView *qqBackView = [[UIView alloc] init];
    qqBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:qqBackView];
    
    
    UIView *ddBackView = [[UIView alloc] init];
    ddBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ddBackView];
    
    
    
    
    
    UILabel *qqTitLabel = [Tools createLableWithFrame:CGRectZero andTitle:@"QQ号码：" andfont:BOLDFONT(14) andTitleColor:[[CPTThemeConfig shareManager] CO_Circle_TitleText] andBackgroundColor:CLEAR andTextAlignment:0];
    [self.view addSubview:qqTitLabel];
    
    self.qqfield = [Tools creatFieldWithFrame:CGRectZero andPlaceholder:nil andFont:[UIFont systemFontOfSize:15] andTextAlignment:1 andTextColor:YAHEI];

    self.qqfield.backgroundColor = WHITE;
    self.qqfield.keyboardType = UIKeyboardTypeNumberPad;
    [qqBackView addSubview:self.qqfield];
    self.qqfield.layer.cornerRadius = 5;
    self.qqfield.layer.masksToBounds = YES;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:@" 请留下您的QQ号"];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] ApplyExpertPlaceholdColor] range:NSMakeRange(0, 9)];
    
    self.qqfield.attributedPlaceholder = attrStr;
    
    self.qqfield.backgroundColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:1];
    self.qqfield.textAlignment = NSTextAlignmentLeft;
    
    
    
    UILabel *dashenTitLabel = [Tools createLableWithFrame:CGRectZero andTitle:@"封神理由：" andfont:[UIFont systemFontOfSize:15] andTitleColor:[[CPTThemeConfig shareManager] CO_Circle_TitleText] andBackgroundColor:CLEAR andTextAlignment:0];
    [self.view addSubview:dashenTitLabel];
    
    self.textView = [[IQTextView alloc]init];
//    self.textView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [ddBackView addSubview:self.textView];
    self.textView.backgroundColor = [UIColor colorWithHex:@"FFFFFF" Withalpha:1];
    self.textView.placeholder = @"请写下您宝贵的意见";
    self.textView.placeholderTextColor = [[CPTThemeConfig shareManager] ApplyExpertPlaceholdColor];

    
    UIButton *applyBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"提交申请" andTitleColor:[[CPTThemeConfig shareManager] ApplyExpertConfirmBtnTextColor] andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(applyClick) andType:UIButtonTypeCustom];
    applyBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_Account_Info_BtnBack];
    applyBtn.layer.cornerRadius = 20;
    applyBtn.layer.masksToBounds = YES;
    applyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:applyBtn];

    
    [qqBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@40);
        make.top.equalTo(qqTitLabel.mas_bottom).offset(10);
    }];
    [ddBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(dashenTitLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(@160);
    }];
    
    [qqTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.navView.mas_bottom).offset(15);
    }];
    
    [self.qqfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qqBackView.mas_left).offset(10);
        make.right.equalTo(qqBackView.mas_right).offset(-10);
        make.top.bottom.equalTo(qqBackView);
    }];
    
    [dashenTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qqfield.mas_bottom).offset(15);
        make.left.equalTo(qqTitLabel.mas_left);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ddBackView.mas_left).offset(10);
        make.right.equalTo(ddBackView.mas_right).offset(-10);
        make.top.bottom.equalTo(ddBackView);
    }];
    
    
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35);
        make.right.equalTo(self.view).offset(-35);
        make.top.equalTo(self.textView.mas_bottom).offset(30);
        make.height.mas_equalTo(@40);
    }];
}

// 控制文本的位置，左右缩 8px
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds , 100 , -100);
}

#pragma mark -  申请大神
-(void)applyClick {
    
    if ([Tools isEmptyOrNull:self.qqfield.text]) {
        [MBProgressHUD showError:@"请输入QQ号码"];
        return;
    }
    
    if ([Tools isEmptyOrNull:self.textView.text]) {
        [MBProgressHUD showError:@"请输入封神理由"];
        return;
    }
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/applyGod.json" params:@{@"content":self.textView.text,@"qq":self.qqfield.text ? self.qqfield.text : @""} success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)
            [self popback];
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"1");
    } showHUD:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
