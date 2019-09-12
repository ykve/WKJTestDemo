//
//  SixAIPickCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/15.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixAIPickCtrl.h"
#import <AudioToolbox/AudioToolbox.h>

// AI智能选号
@interface SixAIPickCtrl ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *typeBtns;

@property (weak, nonatomic) IBOutlet UIImageView *bgimgv;
@property (weak, nonatomic) IBOutlet UIView *birthdayView;
@property (weak, nonatomic) IBOutlet UIButton *birthdayBtn;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *birthdaylabs;

@property (weak, nonatomic) IBOutlet UIView *shakeView;
@property (weak, nonatomic) IBOutlet UILabel *shakelab;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *shakeactivityView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *shakelabs;

@property (weak, nonatomic) IBOutlet UIView *ZodiacView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *zodiacBtns;
@property (weak, nonatomic) IBOutlet UIButton *selectBirthdayBtn;

@property (weak, nonatomic) IBOutlet UIView *lovehomeView;
@property (weak, nonatomic) IBOutlet UILabel *lovehometitlelab;
@property (weak, nonatomic) IBOutlet UILabel *lovehomesubtitlelab;
@property (weak, nonatomic) IBOutlet UIButton *lovehomedateBtn;
@property (weak, nonatomic) IBOutlet UIButton *lovehomemydateBtn;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *lovehomelabs;
@property (weak, nonatomic) IBOutlet UIButton *loverBtn;
@property (weak, nonatomic) IBOutlet UIButton *shakeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shengXiaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *familyBtn;

@property (assign, nonatomic) NSInteger type;

@property (copy, nonatomic) NSString *birthday1;

@property (copy, nonatomic) NSString *birthday2;
/**
 翻牌生肖的随机数组
 */
@property (strong, nonatomic) NSMutableArray *randomArr;

@property (weak, nonatomic) IBOutlet UIImageView *birthDayImage;
@property (weak, nonatomic) IBOutlet UIImageView *AIShakeImage;

@property (weak, nonatomic) IBOutlet UIImageView *loverBirthdayImage;

@end

@implementation SixAIPickCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlestring = @"AI智能选号";
    
    [self.shengXiaoBtn setBackgroundImage:[[CPTThemeConfig shareManager] IM_AI_ShengXiaoNormalImage] forState:UIControlStateNormal];
    [self.shakeBtn setBackgroundImage:[[CPTThemeConfig shareManager] IM_AI_ShakeNormalImage] forState:UIControlStateNormal];
    [self.loverBtn setBackgroundImage:[[CPTThemeConfig shareManager] IM_AI_LoverNormalImage] forState:UIControlStateNormal];
    [self.familyBtn setBackgroundImage:[[CPTThemeConfig shareManager] IM_AI_FamilyNormalImage] forState:UIControlStateNormal];
    [self.birthdayBtn setBackgroundImage:[[CPTThemeConfig shareManager] IM_AI_BirthdayNormalImage] forState:UIControlStateNormal];
    
    [self.shengXiaoBtn setBackgroundImage:[[CPTThemeConfig shareManager] IM_AI_ShengXiaoSeletImage] forState:UIControlStateSelected];
    [self.shakeBtn setBackgroundImage:[[CPTThemeConfig shareManager] IM_AI_ShakeSeletImage] forState:UIControlStateSelected];
    [self.loverBtn setBackgroundImage:[[CPTThemeConfig shareManager] IM_AI_LoverSeletImage] forState:UIControlStateSelected];
    [self.familyBtn setBackgroundImage:[[CPTThemeConfig shareManager] IM_AI_FamilySeletImage] forState:UIControlStateSelected];
    [self.birthdayBtn setBackgroundImage:[[CPTThemeConfig shareManager] IM_AI_BirthdaySeletImage] forState:UIControlStateSelected];

    self.shakeBtn.frame = CGRectMake(self.shakeBtn.frame.origin.x, self.shakeBtn.frame.origin.y, kSCREEN_WIDTH*0.40, kSCREEN_WIDTH*0.40);
    
    self.birthDayImage.image = [[CPTThemeConfig shareManager] IM_AI_BirthdayImage];
    self.loverBirthdayImage.image = [[CPTThemeConfig shareManager] IM_AI_BirthdayImage];
    self.AIShakeImage.image = IMAGE([[CPTThemeConfig shareManager] AIShakeImageName]);
    for (UIButton * btn in self.zodiacBtns) {
        [btn setImage:[[CPTThemeConfig shareManager] IM_AI_ShengXiaoBackImage] forState:UIControlStateNormal];

        switch (btn.tag) {
            case 200:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_ShuImage] forState:UIControlStateSelected];
                break;
            case 201:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_NiuImage] forState:UIControlStateSelected];
                break;
            case 202:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_HuImage] forState:UIControlStateSelected];
                break;
            case 203:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_TuImage] forState:UIControlStateSelected];
                break;
            case 204:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_LongImage] forState:UIControlStateSelected];
                break;
            case 205:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_SheImage] forState:UIControlStateSelected];
                break;
            case 206:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_MaImage] forState:UIControlStateSelected];
                break;
            case 207:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_YangImage] forState:UIControlStateSelected];
                break;
            case 208:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_HouImage] forState:UIControlStateSelected];
                break;
            case 209:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_JiImage] forState:UIControlStateSelected];
                break;
            case 210:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_GouImage] forState:UIControlStateSelected];
                break;
            case 211:
                [btn setImage:[[CPTThemeConfig shareManager] IM_AI_ZhuImage] forState:UIControlStateSelected];
                break;
                
                
            default:
                break;
        }
    }
    
    
    [self rigBtn:@"" Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        [alert buildAIInfoView];
        [alert show];
    }];
    
    UIButton *btn = [self.view viewWithTag:102];
    
    [self typeClick:btn];
    
    //投注按钮
    [self buildBettingBtn];
    
}

- (IBAction)typeClick:(UIButton *)sender {
    
    for (UIButton *btn in self.typeBtns) {
        
        btn.selected = NO;
    }
    
    sender.selected = YES;
    
    self.type = sender.tag - 100;
    
    self.birthdayView.hidden = YES;
    self.shakeView.hidden = YES;
    self.lovehomeView.hidden = YES;
    self.ZodiacView.hidden = YES;
    self.birthdayView.alpha = 0;
    self.shakeView.alpha = 0;
    self.lovehomeView.alpha = 0;
    self.ZodiacView.alpha = 0;
    self.shakelab.hidden = YES;
    self.shakeactivityView.hidden = YES;
    [self.shakeactivityView stopAnimating];
    
//    [self.birthdayBtn setTitle:@"请选择日期" forState:UIControlStateNormal];
    [self.lovehomedateBtn setTitle:@"请选择日期" forState:UIControlStateNormal];
    [self.lovehomemydateBtn setTitle:@"请选择日期" forState:UIControlStateNormal];
    for (UILabel *lab in self.birthdaylabs) {
        
        lab.text = @"?";
    }
    for (UILabel *lab in self.lovehomelabs) {
        
        lab.text = @"?";
    }
    for (UILabel *lab in self.shakelabs) {
        
        lab.text = @"?";
    }
    for (UIButton *btn in self.zodiacBtns) {
        
        btn.selected = NO;
    }
    self.birthday1 = nil;
    self.birthday2 = nil;
    
    [self resignFirstResponder];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:NO];
    
    if (sender.tag == 100) {
        
        self.ZodiacView.hidden = NO;
        self.ZodiacView.alpha = 1;
    } else if (sender.tag == 101) {
        
        self.shakeView.hidden = NO;
        self.shakeView.alpha = 1;
        [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
        [self becomeFirstResponder];
    } else if (sender.tag == 102) {
        
        self.lovehomeView.hidden = NO;
        self.lovehomeView.alpha = 1;
        self.lovehometitlelab.text = @"送爱人一注幸运号";
        self.lovehomesubtitlelab.text = @"爱人生日:";
    } else if (sender.tag == 103) {
        
        self.lovehomeView.hidden = NO;
        self.lovehomeView.alpha = 1;
        self.lovehometitlelab.text = @"送家人一注幸运号";
        self.lovehomesubtitlelab.text = @"家人生日:";
    } else if (sender.tag == 104) {
        
        self.birthdayView.hidden = NO;
        self.birthdayView.alpha = 1;
    }
    self.bgimgv.image = [[CPTThemeConfig shareManager] IM_AI_BGroundcolorImage];

}


- (IBAction)lovehomedateClick:(UIButton *)sender {
    
    [self showdate:sender];
}

- (IBAction)lovehomemydateClick:(UIButton *)sender {
    
    [self showdate:sender];
}

- (IBAction)birthdayClick:(UIButton *)sender {
    
    [self showdate:sender];
}

- (IBAction)zodiacClick:(UIButton *)sender {
    
//
//    if (sender.selected == NO) {
//
//        if (self.randomArr.count<3) {
//
//            [self rotateViewAnimated:sender withDuration:0.35 byAngle:M_PI];
//
//            [self.randomArr addObject:sender];
//        }
//        else {
//            for (UIButton *btn in self.zodiacBtns) {
//
//                btn.selected = NO;
//            }
//            [self.randomArr removeAllObjects];
//
//            [self rotateViewAnimated:sender withDuration:0.35 byAngle:M_PI];
//
//            [self.randomArr addObject:sender];
//        }
//    }
//    else {
//        [self rotateViewAnimated:sender withDuration:0.35 byAngle:M_PI];
//
//        [self.randomArr removeObject:sender];
//    }
    
    for (UIButton *btn in self.zodiacBtns) {
        
        btn.selected = NO;
    }
    
    self.randomArr = [self getDifferentRandomWithNum:3];
    
    UIButton *btn1 = [self.ZodiacView viewWithTag:200 + [self.randomArr.firstObject integerValue]];
    UIButton *btn2 = [self.ZodiacView viewWithTag:200 + [self.randomArr[1] integerValue]];
    UIButton *btn3 = [self.ZodiacView viewWithTag:200 + [self.randomArr[2] integerValue]];
    
    [self rotateViewAnimated:btn1 withDuration:0.35 byAngle:M_PI];
    [self rotateViewAnimated:btn2 withDuration:0.35 byAngle:M_PI];
    [self rotateViewAnimated:btn3 withDuration:0.35 byAngle:M_PI];
    
}

- (IBAction)lovehomerefreshClick:(UIButton *)sender {
}

- (IBAction)shakerefreshClick:(UIButton *)sender {
}

- (IBAction)birthdayrefreshClick:(UIButton *)sender {
    
}

-(void)showdate:(UIButton *)sender{
    
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    
    @weakify(self)
    [alert builddateView:^(NSString *date) {
        @strongify(self)
        [sender setTitle:date forState:UIControlStateNormal];
        
        if (sender == self.lovehomedateBtn) {
            
            self.birthday1 = date;
            
            if (self.birthday2 != nil) {
                
                [self getnumberWithdate1:self.birthday1 Withdate2:self.birthday2];
            }
        }
        else if (sender == self.lovehomemydateBtn) {
            
            self.birthday2 = date;
            
            if (self.birthday1 != nil) {
                
                [self getnumberWithdate1:self.birthday1 Withdate2:self.birthday2];
            }
        }
        if (sender == self.selectBirthdayBtn) {
            
            [self getnumberWithdate1:date Withdate2:nil];
        }
    }];
    [alert show];
}

#pragma mark - ShakeToEdit 摇动手机之后的回调方法
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ([UIApplication sharedApplication].applicationSupportsShakeToEdit == NO) {
        
        return;
    }
    //检测到摇动开始
    if (motion == UIEventSubtypeMotionShake)
    {
        // your code
        NSLog(@"检测到摇动开始");
        self.shakelab.hidden = NO;
        self.shakeactivityView.hidden = NO;
        [self.shakeactivityView startAnimating];
    }
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ([UIApplication sharedApplication].applicationSupportsShakeToEdit == NO) {
        
        return;
    }
    //摇动取消
    NSLog(@"摇动取消");
    self.shakelab.hidden = YES;
    self.shakeactivityView.hidden = YES;
    [self.shakeactivityView stopAnimating];
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ([UIApplication sharedApplication].applicationSupportsShakeToEdit == NO) {
        
        return;
    }
    //摇动结束
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        // your code
        NSLog(@"摇动结束");
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        self.shakelab.hidden = YES;
        self.shakeactivityView.hidden = YES;
        [self.shakeactivityView stopAnimating];
        
        [self getnumberWithdate1:nil Withdate2:nil];
    }
    
}

-(void)viewDidLayoutSubviews {
    
    for (UILabel *lab in self.birthdaylabs) {
        
        lab.layer.cornerRadius = lab.size.height/2;
        lab.layer.masksToBounds = YES;
        
        if (lab.tag == 10) {
            lab.backgroundColor = [[CPTThemeConfig shareManager] IM_AI_AutoSelectLblSelectColor];
        }else{
            lab.backgroundColor = [[CPTThemeConfig shareManager] IM_AI_AutoSelectLblNormalColor];
        }
        
    }
    for (UILabel *lab in self.shakelabs) {
        
        lab.layer.cornerRadius = lab.size.height/2;
        lab.layer.masksToBounds = YES;
        if (lab.tag == 10) {
            lab.backgroundColor = [[CPTThemeConfig shareManager] IM_AI_AutoSelectLblSelectColor];
        }else{
            lab.backgroundColor = [[CPTThemeConfig shareManager] IM_AI_AutoSelectLblNormalColor];
        }
    }
    for (UILabel *lab in self.lovehomelabs) {
        
        lab.layer.cornerRadius = lab.size.height/2;
        lab.layer.masksToBounds = YES;
        if (lab.tag == 10) {
            lab.backgroundColor = [[CPTThemeConfig shareManager] IM_AI_AutoSelectLblSelectColor];
        }else{
            lab.backgroundColor = [[CPTThemeConfig shareManager] IM_AI_AutoSelectLblNormalColor];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getnumberWithdate1:(NSString *)date1 Withdate2:(NSString *)date2 {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:date1 forKey:@"date"];
    [dic setValue:date2 forKey:@"dateb"];
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getAiNum.json" params:dic success:^(BaseData *data) {
        
        @strongify(self)
        NSArray *number = data.data;
        
        
        if (self.type == 0) {
            
            
        }
        else if (self.type == 1) {
            
            for (int i = 0; i< number.count; i++) {
                
                UILabel *lab = [self.shakelabs objectAtIndex:i];
                
                [self rotateLabelAnimated:lab withDuration:0.5 byAngle:M_PI Withtext:STRING(number[i])];
                
            }
        }
        else if (self.type == 2) {
            
            for (int i = 0; i< number.count; i++) {
                
                UILabel *lab = [self.lovehomelabs objectAtIndex:i];
                
                [self rotateLabelAnimated:lab withDuration:0.5 byAngle:M_PI Withtext:STRING(number[i])];
            }
        }
        else if (self.type == 3) {
            
            for (int i = 0; i< number.count; i++) {
                
                UILabel *lab = [self.lovehomelabs objectAtIndex:i];
                
                [self rotateLabelAnimated:lab withDuration:0.5 byAngle:M_PI Withtext:STRING(number[i])];
            }
        }
        else if (self.type == 4) {
            
            for (int i = 0; i< number.count; i++) {
                
                UILabel *lab = [self.birthdaylabs objectAtIndex:i];
                
                [self rotateLabelAnimated:lab withDuration:0.5 byAngle:M_PI Withtext:STRING(number[i])];
            }
        }
        
    } failure:^(NSError *error) {
        
        
    } showHUD:NO];
}

- (void) rotateViewAnimated:(UIButton*)view
               withDuration:(CFTimeInterval)duration
                    byAngle:(CGFloat)angle
{
    [CATransaction begin];
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.byValue = [NSNumber numberWithFloat:angle];
    rotationAnimation.duration = duration;
    rotationAnimation.removedOnCompletion = YES;
    
    [CATransaction setCompletionBlock:^{
        
        view.selected = !view.selected;
    }];
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [CATransaction commit];
}

- (void) rotateLabelAnimated:(UILabel*)lab
               withDuration:(CFTimeInterval)duration
                     byAngle:(CGFloat)angle
                    Withtext:(NSString *)text {
    
    [CATransaction begin];
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.byValue = [NSNumber numberWithFloat:angle];
    rotationAnimation.duration = duration;
    rotationAnimation.removedOnCompletion = YES;
    
    [CATransaction setCompletionBlock:^{
        
        lab.text = text;
    }];
    
    [lab.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [CATransaction commit];
}

//获取到num个不同的随机数就返回随机数数组
-(NSMutableArray *)getDifferentRandomWithNum:(NSInteger )num{
    
    if(self.randomArr &&self.randomArr.count>0){
        
        [self.randomArr removeAllObjects];
        
    }
    NSInteger random;
    
    for (;;) {
    
        random=arc4random_uniform(12);//随机数0-10
        
        NSLog(@"random--%tu",random);
        
        if(self.randomArr.count==0){
            
            [self.randomArr addObject:[NSNumber numberWithInteger:random]];
            
            continue;//进行下一次循环
        }
        BOOL isHave=[self.randomArr containsObject:[NSNumber numberWithInteger:random]];//判断数组中有没有
        
        if(isHave){
            continue;
        }
        [self.randomArr addObject:[NSNumber numberWithInteger:random]];
        
        if(self.randomArr.count==num){
            
            return self.randomArr;
            
        }
    }//self.randomArr是存储随机数的数组，如果是在按钮点击是获取随机数，在按钮点击的开始就要把数组清空，防止连续数组内容叠加
    
}

-(NSMutableArray *)randomArr {
    
    if (!_randomArr) {
        
        _randomArr = [[NSMutableArray alloc]init];
    }
    return _randomArr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
