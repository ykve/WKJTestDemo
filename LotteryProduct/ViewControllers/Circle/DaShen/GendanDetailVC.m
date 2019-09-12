//
//  GendanDetailVC.m
//  LotteryProduct
//
//  Created by pt c on 2019/7/3.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "GendanDetailVC.h"
#import "ZJDetailCell.h"
#import "TuidanDetailModel.h"
#import "BallTool.h"
@interface GendanDetailVC ()<UITextViewDelegate>

@property (strong, nonatomic) UIButton *gendanBtn;
//单住金额
@property (strong, nonatomic) UILabel *moneyFor1Label;
//倍数
@property (strong, nonatomic) UITextField *mutiTF;
//总金额
@property (strong, nonatomic) UILabel *totalLabel;

@property (strong, nonatomic) UIView *bottomView;

@end

@implementation GendanDetailVC
{
    ZJDetailCell *headerCell;
    TuidanDetailModel *_infoModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"跟单详情";
    
    self.navView.hidden = YES;
    
    
    [self getData];
    
    self.tableView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-Height_NavBar -50);
    [self.view addSubview:self.tableView];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChangeValue:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

#pragma mark -  输入字符判断
- (void)textFieldDidChangeValue:(NSNotification *)text{
    
    UITextField *textFieldObj = (UITextField *)text.object;
    
    if (textFieldObj.text.integerValue >= 0) {
        self.totalLabel.text = [NSString stringWithFormat:@"%.2f", _infoModel.numberAmount *textFieldObj.text.integerValue];
    } else {
        self.moneyFor1Label.text = @"0";
        self.totalLabel.text = @"0";
    }
}

- (void)setupUI {
    
    UIColor *titleColor = [UIColor colorWithHex:@"#DDDDDD"];
    UIColor *textColor = [UIColor colorWithHex:@"#FF5B10"];
    NSInteger fontSize = 13;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHex:@"#1E1F24"];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];

    UIButton *gendanBtn = [[UIButton alloc] init];
    [gendanBtn setTitle:@"立即跟单" forState:UIControlStateNormal];
    [gendanBtn addTarget:self action:@selector(onGendanBtn:) forControlEvents:UIControlEventTouchUpInside];
    gendanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    gendanBtn.backgroundColor = [UIColor colorWithHex:@"#AC1E2D"];
    [bottomView addSubview:gendanBtn];
    _gendanBtn = gendanBtn;
    
    [gendanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(bottomView);
        make.width.mas_equalTo(100);
    }];
    
    UILabel *y1Label = [[UILabel alloc] init];
    y1Label.text = @"元";
    y1Label.font = [UIFont systemFontOfSize:fontSize];
    y1Label.textColor = titleColor;
    y1Label.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:y1Label];
    
    [y1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.right.mas_equalTo(gendanBtn.mas_left).offset(-5);
    }];
    
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.text = @"-";
    totalLabel.font = [UIFont systemFontOfSize:fontSize];
    totalLabel.textColor = textColor;
    totalLabel.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:totalLabel];
    _totalLabel = totalLabel;
    
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.right.mas_equalTo(y1Label.mas_left).offset(-1);
    }];
    
    UILabel *y2Label = [[UILabel alloc] init];
    y2Label.text = @"总金额";
    y2Label.font = [UIFont systemFontOfSize:fontSize];
    y2Label.textColor = titleColor;
    y2Label.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:y2Label];
    
    [y2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.right.mas_equalTo(totalLabel.mas_left);
    }];
    
    
    
    
    UILabel *u1Label = [[UILabel alloc] init];
    u1Label.text = @"每注";
    u1Label.font = [UIFont systemFontOfSize:fontSize];
    u1Label.textColor = titleColor;
    u1Label.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:u1Label];
    
    [u1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.mas_equalTo(bottomView.mas_left).offset(5);
    }];
    
    UILabel *moneyFor1Label = [[UILabel alloc] init];
    moneyFor1Label.text = @"-";
    moneyFor1Label.font = [UIFont systemFontOfSize:fontSize];
    moneyFor1Label.textColor = textColor;
    moneyFor1Label.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:moneyFor1Label];
    _moneyFor1Label = moneyFor1Label;
    
    [moneyFor1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.mas_equalTo(u1Label.mas_right);
    }];
    
    UILabel *u2Label = [[UILabel alloc] init];
    u2Label.text = @"元";
    u2Label.font = [UIFont systemFontOfSize:fontSize];
    u2Label.textColor = titleColor;
    u2Label.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:u2Label];
    
    [u2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.mas_equalTo(moneyFor1Label.mas_right);
    }];
    
    
    UITextField *textField = [[UITextField alloc] init];
     textField.backgroundColor = [UIColor clearColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:fontSize];
    textField.textColor = textColor;
    textField.text = @"100";
//    textField.placeholder = @"-";
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.returnKeyType = UIReturnKeyGo;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor colorWithHex:@"#6C6C6C"].CGColor;
    [self.view addSubview:textField];
    _mutiTF = textField;
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.mas_equalTo(u2Label.mas_right).offset(2);
        make.size.mas_equalTo(CGSizeMake(40, 22));
    }];
    
    
    
    UILabel *u3Label = [[UILabel alloc] init];
    u3Label.text = @"倍";
    u3Label.font = [UIFont systemFontOfSize:fontSize];
    u3Label.textColor = titleColor;
    u3Label.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:u3Label];
    
    [u3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.mas_centerY);
        make.left.mas_equalTo(textField.mas_right).offset(1);
    }];
}

#pragma mark -  推单详情
- (void)getData {
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/pushRecordDetail.json" params:@{@"trackId":@(self.trackId)} success:^(BaseData *data) {
        @strongify(self);
        self->_infoModel = [TuidanDetailModel mj_objectWithKeyValues:data.data];
        [self updateBottom];
        [self setUIValue];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        MBLog(@"1");
    }];
}


#pragma mark -  跟单
/**
 跟单
 
 @param sender sender
 */
- (void)onGendanBtn:(UIButton *)sender {
    sender.enabled = NO;
    
    if (self.totalLabel.text.integerValue <= 0) {
        [MBProgressHUD showError:@"跟单总额错误"];
        return;
    }
    
    NSMutableDictionary *dictPar = [[NSMutableDictionary alloc]init];
    [dictPar setValue:@(self.trackId) forKey:@"godPushId"];  // 推单id
    [dictPar setValue:self.totalLabel.text forKey:@"orderAmount"]; // 跟单总额
    
    @weakify(self)
    [WebTools  postWithURL:@"/order/orderFollow.json" params:dictPar success:^(BaseData *data) {
        sender.enabled = YES;
        @strongify(self);
        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return ;
        }
        [MBProgressHUD showError:@"跟单成功"];
    } failure:^(NSError *error) {
        sender.enabled = YES;
//        [MBProgressHUD showError:@"跟单失败,请重试"];
    } showHUD:YES];
    
    
}

- (void)setUIValue {
    self.moneyFor1Label.text = [NSString stringWithFormat:@"%1.f", _infoModel.numberAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%.2f", _infoModel.numberAmount *100];
}


- (void)updateBottom{
//    if([_infoModel.btStatus isEqualToString:@"WAIT"]){
//        _bottomView.hidden = NO;
//    }else{
//        _bottomView.hidden = YES;
//    }
}


#pragma mark -  UITableViewDataSource, UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (!_infoModel) {
        return 0;
    }
    
    CGFloat h1 = [BallTool heightWithFont:12 limitWidth:SCREEN_WIDTH-10 string:_infoModel.personalContent];
    CGFloat h2 = [BallTool heightWithFont:12 limitWidth:SCREEN_WIDTH-10 string:_infoModel.godAnalyze];
    CGFloat h3 = _infoModel.picture&&_infoModel.picture.length>0?180:0;
    if(_infoModel.isShow == 1){
        return 530+h1+h2+h3;
    } else {
        return 410+h1+h2+h3;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    headerCell = [[[NSBundle mainBundle] loadNibNamed:@"ZJDetailCell" owner:nil options:nil]lastObject];
    headerCell.isGendan = YES;
    if(_infoModel){
        headerCell.model = self->_infoModel;
    }
    return headerCell.contentView;
}



@end
