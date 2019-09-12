//
//  PushBettingCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/17.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PushBettingCtrl.h"

@interface PushBettingCtrl ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topconst;
@property (weak, nonatomic) IBOutlet UIButton *secret_openBtn;
@property (weak, nonatomic) IBOutlet UIButton *secret_closeBtn;
@property (weak, nonatomic) IBOutlet UIView *safeview;
@property (weak, nonatomic) IBOutlet UIButton *safedelBtn;
@property (weak, nonatomic) IBOutlet UIButton *safeaddBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *safesegment;
@property (weak, nonatomic) IBOutlet UILabel *safelab;
@property (weak, nonatomic) IBOutlet UIView *bonusview;
@property (weak, nonatomic) IBOutlet UIButton *bonusdelBtn;
@property (weak, nonatomic) IBOutlet UIButton *bonusaddBtn;
@property (weak, nonatomic) IBOutlet UILabel *bonuslab;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bonussegment;
@property (weak, nonatomic) IBOutlet UILabel *remarklab;
@property (weak, nonatomic) IBOutlet IQTextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *oddsTextF;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (assign, nonatomic) NSInteger secretStatus;

@property (nonatomic,copy) NSString *imgUrl;//图片url
@property (nonatomic,copy) NSString *maxOdd;//最高赔率
@property (weak, nonatomic) IBOutlet UILabel *palceHolderLabel;

@end

@implementation PushBettingCtrl
//点击选择图片
- (IBAction)choseImgClick:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    @weakify(self)
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[Person person] takePictureWithController:self WithBlock:^(UIImage *image) {
            @strongify(self)
            
            [self updataimage:image];
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[Person person] takePhotoWithController:self WithBlock:^(UIImage *image) {
            @strongify(self)
            
            [self updataimage:image];
        }];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)updataimage:(UIImage *)image {
    
    @weakify(self)
    [WebTools rj_upImage:@[image] code:@"push-image" progress:^(NSProgress *progress) {
        
    } success:^(BaseData *data) {
        @strongify(self)
        self.imgUrl = [data.data firstObject];
        MBLog(@"%@",self.imgUrl);
        [self.upLoadImgBtn sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] forState:UIControlStateNormal];
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)updateUIColor{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[CPTThemeConfig shareManager] RootWhiteC];
    [self updateUIColor];
    self.titlestring = @"推单";
    self.topconst.constant = NAV_HEIGHT;
    [self replacesegment:self.safesegment];
    [self replacesegment:self.bonussegment];
    [self secretopenClick:self.secret_openBtn];
    self.confirmBtn.backgroundColor = [[CPTThemeConfig shareManager] confirmBtnBackgroundColor];
    [self.confirmBtn setTitleColor:[[CPTThemeConfig shareManager] confirmBtnTextColor] forState:UIControlStateNormal];

    
    [self getMaxOdd];
    [self.safesegment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"333333"]} forState:UIControlStateSelected];
    [self.safesegment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"333333"]} forState:UIControlStateNormal];
    [self.bonussegment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"333333"]} forState:UIControlStateSelected];
    [self.bonussegment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"333333"]} forState:UIControlStateNormal];
}
//获取最高赔率
- (void)getMaxOdd{
//    NSString *betId = self.orderBetIds[0];
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/maxWinAmount.json" params:@{@"orderBetId":self.model.ID} success:^(BaseData *data) {
        @strongify(self)
        MBLog(@"%@",data.data);
        NSDictionary *dic = data.data;
        if([dic.allKeys containsObject:@"maxWinAmount"]){
            self.maxOdd = [NSString stringWithFormat:@"%@",[dic objectForKey:@"maxWinAmount"]];
            [self.safesegment setTitle:self.maxOdd forSegmentAtIndex:1];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)replacesegment:(UISegmentedControl *)segment {
    
    segment.selectedSegmentIndex = -1;
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateSelected];
    
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}forState:UIControlStateNormal];
    
    [segment setDividerImage:[Tools createImageWithColor:[UIColor lightGrayColor] Withsize:CGSizeMake(1, 20)] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}


- (IBAction)secretopenClick:(UIButton *)sender {
    
    self.secret_openBtn.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];
    self.secret_closeBtn.backgroundColor = CLEAR;
    [self.secret_openBtn setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [self.secret_closeBtn setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
    
    self.secretStatus = 1;
}

- (IBAction)secretcloseClick:(UIButton *)sender {
    
    self.secret_closeBtn.backgroundColor = [UIColor colorWithHex:@"DDDDDD"];;
    self.secret_openBtn.backgroundColor = CLEAR;
    [self.secret_closeBtn setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
    [self.secret_openBtn setTitleColor:[UIColor colorWithHex:@"999999"] forState:UIControlStateNormal];
    
    self.secretStatus = 2;
}
- (void)textViewDidChange:(UITextView *)textView{
    if(textView.text.length>0){
        _palceHolderLabel.hidden = YES;
    }else{
        _palceHolderLabel.hidden = NO;
    }
}
- (IBAction)safedelClick:(UIButton *)sender {
    
    CGFloat safenum = self.oddsTextF.text.floatValue;
    
    safenum -= 0.1 ;
    
    if (safenum <= 1.8) {
        
        safenum = 1.8;
    }
    
    self.oddsTextF.text = [NSString stringWithFormat:@"%.1f",safenum];
}

- (IBAction)safeaddClick:(UIButton *)sender {
    
    CGFloat safenum = self.oddsTextF.text.floatValue;
    
    safenum += 0.1 ;
    
    if (safenum >= 99.9) {
        
        safenum = 99.9;
    }
    
    self.oddsTextF.text = [NSString stringWithFormat:@"%.1f",safenum];
}

- (IBAction)bonusdelClick:(UIButton *)sender {
    
    NSInteger bonusnum = self.bonusTF.text.integerValue;
    
    bonusnum --;
    if (bonusnum <=1) {
        
        bonusnum = 1;
    }
    self.bonusTF.text = INTTOSTRING(bonusnum);
}
- (BOOL)textField:( UITextField  *)textField shouldChangeCharactersInRange:(NSRange )range replacementString:( NSString  *)string{
    if(textField == _bonusTF){
        NSString *temp = [NSString stringWithFormat:@"%@%@",textField.text,string];
        if(temp.intValue > 15){
            textField.text = @"15";
            return NO;
        }
    }else if(textField == _oddsTextF){
        
    }
    
    return YES;
}
- (IBAction)bonusaddClick:(UIButton *)sender {
    
    NSInteger bonusnum = self.bonusTF.text.integerValue;
    
    bonusnum ++;
    
    if (bonusnum >= 99) {
        
        bonusnum = 99;
    }
    
    self.bonusTF.text = INTTOSTRING(bonusnum);
}

- (IBAction)safesegmentClick:(UISegmentedControl *)sender {
    NSString *title = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
//    if([title isEqualToString:self.maxOdd]){
//        self.oddsTextF.text = @"最大";
//    }else{
        self.oddsTextF.text = title;
//    }
    
}
- (IBAction)bonussegmentClick:(UISegmentedControl *)sender {
    
//    self.bonuslab.text = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    self.bonusTF.text = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
}
- (IBAction)publishClick:(UIButton *)sender {
    
    if ([Tools isEmptyOrNull:self.textView.text]) {
        
        [MBProgressHUD showError:@"请输入大神分析"];
        
        return;
    }
    NSInteger orderOdd = [self.model.odds integerValue];
    NSInteger Odd = [self.oddsTextF.text integerValue];
    if (Odd > orderOdd) {
        [MBProgressHUD showError:@"不可以超过投注赔率"];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    if(self.model){
        [dic setValue:self.model.ID forKey:@"orderBetId"];
    }
    [dic setValue:self.oddsTextF.text forKey:@"ensureOdds"];
    [dic setValue:self.bonusTF.text forKey:@"bonusScale"];
    [dic setValue:@(self.secretStatus) forKey:@"secretStatus"];
    [dic setValue:self.textView.text forKey:@"godAnalyze"];
    if(self.imgUrl){
        [dic setValue:self.imgUrl forKey:@"picture"];
    }
    @weakify(self)
    [WebTools postWithURL:@"/circle/god/pushOrder.json" params:dic success:^(BaseData *data) {

        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)
            [self popback];
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
