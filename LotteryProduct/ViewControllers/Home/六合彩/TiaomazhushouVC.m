//
//  TiaomazhushouVC.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/6/12.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "TiaomazhushouVC.h"
#import "LoginAlertViewController.h"
#import "HKShareViewViewController.h"
#import "ShareViewController.h"
@interface TiaomazhushouVC (){
    NSArray *_dataArray;
    NSString *_choseString;
    NSDictionary *_keyDic;
    NSMutableSet *_keySet;
}
@property(nonatomic,weak)IBOutlet UIView * headV;
@property(nonatomic,weak)IBOutlet UIScrollView * myScrollView;
@property(nonatomic,weak)IBOutlet UIView * ballBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property(nonatomic,weak)IBOutlet UIButton * clearBu;
@property(nonatomic,weak)IBOutlet UIButton * cBu;
@property(nonatomic,weak)IBOutlet UIButton * shareBu;

@end

@implementation TiaomazhushouVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        _dataArray = @[
                       @[@"单",@"双",@"1",@"大",@"小",@"1"],
                       @[@"大单",@"大双",@"小单",@"金",@"木",@"水"],
                       @[@"小双",@"1",@"1",@"火",@"土",@"1"],
                       @[@"红波",@"蓝波",@"绿波",@"家禽",@"野兽",@"1"],
                       @[@"红单",@"红双",@"蓝单",@"蓝双",@"绿单",@"绿双"],
                       @[@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇"],
                       @[@"马",@"羊",@"猴",@"鸡",@"狗",@"猪"],
                       @[@"0尾",@"1尾",@"2尾",@"3尾",@"4尾",@"5尾"],
                       @[@"6尾",@"7尾",@"8尾",@"9尾",@"尾大",@"尾小"],
                       @[@"0头",@"1头",@"2头",@"3头",@"4头",@"1"],
                       ];
        _keyDic = @{
                    @"单":@"01.03.05.07.09.11.13.15.17.19.21.23.25.27.29.31.33.35.37.39.41.43.45.47.49",
                     @"双":@"02.04.06.08.10.12.14.16.18.20.22.24.26.28.30.32.34.36.38.40.42.44.46.48",
                     @"大单":@"25.27.29.31.33.35.37.39.41.43.45.47.49",
                     @"大双":@"26.28.30.32.34.36.38.40.42.44.46.48",
                     @"小单":@"01.03.05.07.09.11.13.15.17.19.21.23",
                     @"小双":@"02.04.06.08.10.12.14.16.18.20.22.24",
                     @"大":@"25.26.27.28.29.30.31.32.33.34.35.36.37.38.39.40.41.42.43.44.45.46.47.48.49",
                     @"小":@"01.02.03.04.05.06.07.08.09.10.11.12.13.14.15.16.17.18.19.20.21.22.23.24",
                     @"金":@"05.06.19.20.27.28.35.36.49",
                     @"木":@"01.02.09.10.17.18.31.32.39.40.47.48",
                     @"水":@"07.08.15.16.23.24.37.38.45.46",
                     @"火":@"03.04.11.12.25.26.33.34.41.42",
                     @"土":@"13.14.21.22.29.30.43.44",
                     @"红波":@"01.02.07.08.12.13.18.19.23.24.29.30.34.35.40.45.46",
                     @"蓝波":@"03.04.09.10.14.15.20.25.26.31.36.37.41.42.47.48",
                     @"绿波":@"05.06.11.16.17.21.22.27.28.32.33.38.39.43.44.49",
                     @"家禽":@"01.02.03.05.06.11.13.14.15.17.18.23.25.26.27.29.30.35.37.38.39.41.42.47.49",
                     @"野兽":@"04.07.08.09.10.12.16.19.20.21.22.24.28.31.32.33.34.36.40.43.44.45.46.48",
                     @"红单":@"01.07.13.19.23.29.35.45",
                     @"红双":@"02.08.12.18.24.30.34.40.46",
                     @"蓝单":@"03.09.15.25.31.37.41.47",
                     @"蓝双":@"04.10.14.20.26.36.42.48",
                     @"绿单":@"05.11.17.21.27.33.39.43.49",
                     @"绿双":@"06.16.22.28.32.38.44",
                     @"鼠":@"12.24.36.48",
                     @"牛":@"11.23.35.47",
                     @"虎":@"10.22.34.46",
                     @"兔":@"09.21.33.45",
                     @"龙":@"08.20.32.44",
                     @"蛇":@"07.19.31.43",
                     @"马":@"06.18.30.42",
                     @"羊":@"05.17.29.41",
                     @"猴":@"04.16.28.40",
                     @"鸡":@"03.15.27.39",
                     @"狗":@"02.14.26.38",
                     @"猪":@"01.13.25.37.49",
                     @"0尾":@"10.20.30.40",
                     @"1尾":@"01.11.21.31.41",
                     @"2尾":@"02.12.22.32.42",
                     @"3尾":@"03.13.23.33.43",
                     @"4尾":@"04.14.24.34.44",
                     @"5尾":@"05.15.25.35.45",
                     @"6尾":@"06.16.26.36.46",
                     @"7尾":@"07.17.27.37.47",
                     @"8尾":@"08.18.28.38.48",
                     @"9尾":@"09.19.29.39.49",
                     @"尾大":@"05.06.07.08.09.15.16.17.18.19.25.26.27.28.29.35.36.37.38.39.45.46.47.48.49",
                     @"尾小":@"01.02.03.04.10.11.12.13.14.20.21.22.23.24.30.31.32.33.34.40.41.42.43.44",
                     @"0头":@"01.02.03.04.05.06.07.08.09",
                     @"1头":@"10.11.12.13.14.15.16.17.18.19",
                     @"2头":@"20.21.22.23.24.25.26.27.28.29",
                     @"3头":@"30.31.32.33.34.35.36.37.38.39",
                     @"4头":@"40.41.42.43.44.45.46.47.48.49"
                    };
        _keySet = [NSMutableSet set];
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.top.constant = NAV_HEIGHT;

  
    self.titlestring = @"挑码助手";
     
    self.ballBgView.backgroundColor = [[CPTThemeConfig shareManager] CO_TM_HeadContentView];
    self.headV.backgroundColor = [[CPTThemeConfig shareManager] CO_TM_HeadView];
    self.myScrollView.backgroundColor = [[CPTThemeConfig shareManager] CO_TM_BackView];
    self.ballBgView.borderWidth = 0.5;
    self.ballBgView.borderColor = [[CPTThemeConfig shareManager] CO_TM_Btn3borderColor];
    
    self.clearBu.backgroundColor = self.cBu.backgroundColor = self.shareBu.backgroundColor = [[CPTThemeConfig shareManager] CO_TM_Btn3Back];
    
    self.clearBu.layer.borderColor = [[CPTThemeConfig shareManager] CO_TM_Btn3borderColor].CGColor;
    self.cBu.layer.borderColor = [[CPTThemeConfig shareManager] CO_TM_Btn3borderColor].CGColor;
    self.shareBu.layer.borderColor = [[CPTThemeConfig shareManager] CO_TM_Btn3borderColor].CGColor;
    
    [self.clearBu setTitleColor:[[CPTThemeConfig shareManager] CO_TM_Btn3TitleText]  forState:UIControlStateNormal];
    [self.cBu setTitleColor:[[CPTThemeConfig shareManager] CO_TM_Btn3TitleText]  forState:UIControlStateNormal];
    [self.shareBu setTitleColor:[[CPTThemeConfig shareManager] CO_TM_Btn3TitleText] forState:UIControlStateNormal];

    self.myScrollView.userInteractionEnabled = YES;
    [self loadSc];
}

- (void)touchDownBtn:(UIButton *)btn {
    
    btn.backgroundColor = [[CPTThemeConfig shareManager] CO_TM_Btn3BackSelected];
    [btn setTitleColor:WHITE forState:UIControlStateNormal];
    [self performSelector:@selector(touchUpBtn:) withObject:btn afterDelay:0.2];
}

- (void)touchUpBtn:(UIButton *)btn{
    btn.backgroundColor = [[CPTThemeConfig shareManager] CO_TM_Btn3Back];
    [btn setTitleColor:[[CPTThemeConfig shareManager] CO_TM_Btn3TitleText] forState:UIControlStateNormal];
}

- (void)loadSc{
    CGFloat tmpW = (SCREEN_WIDTH - 14*2-10*5 )/6;

    for(NSInteger i =0 ;i<_dataArray.count;i++){
        NSArray * subArr = _dataArray[i];
        UIButton *tmpB;
        for(NSInteger n =0 ;n<subArr.count;n++){
            NSString *title = subArr[n];
            UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
            [bu setTitle:title forState:UIControlStateNormal];
            bu.layer.cornerRadius = 2;
            [bu.titleLabel setFont:FONT(12)];
            bu.borderWidth = 0.5;
            
            bu.borderColor = [[CPTThemeConfig shareManager] CO_TM_smallBtnborderColor];
            [bu setTitleColor:[[CPTThemeConfig shareManager] CO_TM_smallBtnText] forState:UIControlStateNormal];
            [bu setTitleColor:[[CPTThemeConfig shareManager] CO_TM_smallBtnTextSelected] forState:UIControlStateSelected];
            bu.backgroundColor = [[CPTThemeConfig shareManager] CO_TM_smallBtnBackColor];
            
            [bu addTarget:self action:@selector(clickBu:) forControlEvents:UIControlEventTouchUpInside];
            [self.myScrollView addSubview:bu];
            [bu mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.offset(tmpW);
                make.height.offset(23);
                make.top.offset(5+i*(10+23));
                if(n==0){
                    make.left.offset(14);
                }else{
                    make.left.equalTo(tmpB.mas_right).offset(10);
                }
            }];
            if([title isEqualToString:@"1"]){
                bu.hidden = YES;
            }
            tmpB = bu;
        }
    }
}

- (void)clickBu:(UIButton *)bu{
    bu.selected = !bu.selected;
    NSString *title = bu.titleLabel.text;
    bu.borderWidth = 0.5;

    if(bu.selected){
        bu.borderColor = [[CPTThemeConfig shareManager] CO_TM_smallBtnborderColor];
        bu.backgroundColor = [[CPTThemeConfig shareManager] CO_TM_smallBtnBackColorSelected];
        [_keySet addObject:title];
    }else{
        bu.borderColor = [[CPTThemeConfig shareManager] CO_TM_smallBtnborderColor];
        bu.backgroundColor = [[CPTThemeConfig shareManager] CO_TM_smallBtnBackColor];
        [_keySet removeObject:title];
    }
    [self loadBallByKeys:_keySet];
}

- (void)loadBallByKeys:(NSMutableSet *)keys{
    NSMutableArray * tmpA = [NSMutableArray array];
    for(NSString * t in keys){
        [tmpA addObject:t];
    }
    NSMutableArray * tmpB = [NSMutableArray array];
    for(NSInteger i =0 ;i<tmpA.count;i++){
        NSString * key = tmpA[i];
        NSString *numberS = _keyDic[key];
        NSArray * vA = [numberS componentsSeparatedByString:@"."];
        [tmpB addObject:vA];
    }

    NSArray * filter_no;
    if(tmpB.count>1){
        for(NSInteger n =0 ;n<tmpB.count;n++){
            if(n==1){
                NSArray *arr2 = tmpB[0];
                NSArray *arr1 = tmpB[1];
                NSPredicate * filterPredicate_same = [NSPredicate predicateWithFormat:@"SELF IN %@",arr1];
                filter_no = [arr2 filteredArrayUsingPredicate:filterPredicate_same];
            }else{
                NSArray *arr2 = tmpB[n];
                NSPredicate * filterPredicate_same = [NSPredicate predicateWithFormat:@"SELF IN %@",filter_no];
                filter_no = [arr2 filteredArrayUsingPredicate:filterPredicate_same];
            }
        }
        [self loadBallByFilter:filter_no];
    }else{
        [self loadBallByFilter:tmpB];
    }
}

- (void)loadBallByFilter:(NSArray<NSArray *> *)filter{
    MBLog(@"cc: %@",filter);
    for(UIView * v in self.ballBgView.subviews){
        [v removeFromSuperview];
    }
    if(filter.count>0){
        id tm = filter[0];
        NSArray * fff ;
        if([tm isKindOfClass:[NSArray class]]){
            fff = filter[0];
        }else{
            fff = filter;
        }
        UIButton *tmpB;
        CGFloat tmpW = (SCREEN_WIDTH - 14*2 - 13*2-8*7 )/8;
         _choseString = [fff componentsJoinedByString:@","];//#为分隔符
        for(NSInteger n =0 ;n<fff.count;n++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setUserInteractionEnabled:NO];
            [btn setTitle:fff[n] forState:UIControlStateNormal];
            [btn setTitleColor:BLACK forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(-4, 0, 0, 0)];
            [btn setBackgroundImage:[Tools numbertoimage:fff[n] Withselect:NO] forState:UIControlStateNormal];
            [self.ballBgView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.offset(tmpW);
                make.height.offset(tmpW);
                CGFloat j = 10+n%8*(10+tmpW);
                MBLog(@"%f",j);
                if(n%8==0){
                    make.left.offset(14);
                }else{
                    make.left.equalTo(tmpB.mas_right).offset(8);
                }
                if(n<8){
                    make.top.offset(10);
                }
                else if (n>=8 && n<16){
                    make.top.offset(10+tmpW+10);
                }
                else if (n>=16&& n<24){
                    make.top.offset(10+tmpW+10+tmpW+10);
                }
                else if (n>=24 && n<32){
                    make.top.offset(10+tmpW+10+tmpW+10+tmpW+10);
                }
                else if (n>=32 && n<40){
                    make.top.offset(10+tmpW+10+tmpW+10+tmpW+10+tmpW+10);
                }
            }];
            tmpB = btn;
        }
    }
}

- (IBAction)clear{
    [_keySet removeAllObjects];
    [self loadBallByKeys:_keySet];
    for(UIView *v in self.myScrollView.subviews){
        if([v isKindOfClass:[UIButton class]]){
            UIButton *bu = (UIButton *)v;
            bu.selected = NO;
            bu.borderWidth = 0.5;
            
            bu.borderColor = [[CPTThemeConfig shareManager] CO_TM_smallBtnborderColor];
            [bu setTitleColor:[[CPTThemeConfig shareManager] CO_TM_smallBtnText] forState:UIControlStateNormal];
            bu.backgroundColor = [[CPTThemeConfig shareManager] CO_TM_smallBtnBackColor];

        }
    }
    [self touchDownBtn:self.clearBu];
}

- (IBAction)clickC{
    if(_keySet.count<1){
        [MBProgressHUD showError:@"请先挑选你想要的结果"];
    }else{
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = _choseString;
        [MBProgressHUD showSuccess:@"该结果已拷贝"];
    }
    [self touchDownBtn:self.cBu];

}

- (IBAction)shareB{
    [self touchDownBtn:self.shareBu];

    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:login animated:YES completion:^{
        }];
        return ;
    }
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"HKShareViewViewController" bundle:nil];
    HKShareViewViewController *shareVc = [storyBoard instantiateInitialViewController];
    [self.navigationController pushViewController:shareVc animated:YES];
}


@end
