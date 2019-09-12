//
//  LotteryTypeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "LotteryTypeView.h"
#import "CartHomeModel.h"
#import "AppDelegate.h"
@interface LotteryTypeView(){
    NSMutableArray *_subModels;
}
@end

static LotteryTypeView *lotterytype = nil;
static dispatch_once_t onceToken;

@implementation LotteryTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    if(!_subModels){
        _subModels = [NSMutableArray array];
    }
    if (!_lottery_ids) {
        
        _lottery_ids = [[NSMutableArray alloc]init];
    }
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor = [UIColor clearColor];
    [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self initData];

}

-(void)initData {
    for (NSNumber *lotteryID in [[CPTBuyDataManager shareManager] allLotteryIds]) {
        [_lottery_ids addObject:[NSString stringWithFormat:@"%ld",(long)lotteryID.integerValue]];
    }
    [self configUIByData:_lottery_ids];
}

- (void)configUIByData:(NSMutableArray *)a{
    NSMutableArray * newIDs = [NSMutableArray arrayWithArray:a];
    if(newIDs.count>0)
    {
        [newIDs insertObject:@"全部彩种" atIndex:0];
    }
    UIButton * tmpBtn;
    CGFloat tmpW = (SCREEN_WIDTH - 30)/3;
    for(NSInteger i = 0;i<newIDs.count;i++){
        NSString *lotteryIdString = newIDs[i];

        UIButton * bu = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.headScroll addSubview:bu];
        bu.layer.cornerRadius = 5.0;
        [bu setSelected:YES];
        bu.titleLabel.font = FONT(12.0);
        [bu setBackgroundColor:[UIColor colorWithHex:@"f5f5f5"]];
        if(i ==0){
            bu.tag = 999;
            bu.selected = YES;
            [bu setTitle:lotteryIdString forState:UIControlStateNormal];
            bu.layer.borderColor = [UIColor colorWithHex:@"e3a4a8"].CGColor;
            bu.layer.borderWidth = .5;
            [bu setTitleColor:[UIColor colorWithHex:@"ac232d"] forState:UIControlStateNormal];
            [bu addTarget:self action:@selector(clickAllBtn:) forControlEvents:UIControlEventTouchUpInside];

        }else{
            [bu addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [bu setTitleColor:[UIColor colorWithHex:@"000000"] forState:UIControlStateNormal];
            bu.selected = NO;
            bu.tag = 200+i;
            bu.layer.borderWidth = 0.0;
            [bu setTitle:[[CPTBuyDataManager shareManager] changeTypeToString:[lotteryIdString integerValue]] forState:UIControlStateNormal];
        }
        [bu mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i%3==0){
                if(i==0){
                    make.left.equalTo(self.headView).offset(10.);
                    make.top.offset(10.);
                }else{
                    make.left.equalTo(self.headView).offset(10.);
                    make.top.equalTo(tmpBtn.mas_bottom).offset(5.0);
                }

            }else if (i%3==1){
                if(i==1){
                    make.left.equalTo(tmpBtn.mas_right).offset(5.);
                    make.top.offset(10.);
                }else{
                    make.left.equalTo(tmpBtn.mas_right).offset(5.);
                    make.top.equalTo(tmpBtn);
                }
            }else if (i%3==2){
                if(i==2){
                    make.left.equalTo(tmpBtn.mas_right).offset(5.);
                    make.top.offset(10.);
                }else{
                    make.left.equalTo(tmpBtn.mas_right).offset(5.);
                    make.top.equalTo(tmpBtn);
                }
            }
            if(i==a.count-1){
                make.left.equalTo(tmpBtn.mas_right).offset(5.);
                make.top.equalTo(tmpBtn);
            }
            make.width.offset(tmpW);
            make.height.offset(33.);
        }];
        tmpBtn = bu;
    }
    self.headScroll.contentSize = CGSizeMake(SCREEN_WIDTH, 10*2+(a.count/3+1)*33+(a.count/2)*5);

//    [self.okButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(tmpBtn.mas_bottom).offset(10);
//    }];
//    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.offset(self.okButton.y+self.okButton.height);
//    }];
 [self layoutIfNeeded];
}

- (void)clickAllBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSInteger count  = [[CPTBuyDataManager shareManager] allLotteryIds].count;
    for(NSInteger i = 0;i<count;i++){
        NSNumber * idNumber = [[CPTBuyDataManager shareManager] allLotteryIds][i];
        NSString * idddd = INTTOSTRING(idNumber.integerValue);
        UIButton * btn = [self.headScroll viewWithTag:201+i];
        if(sender.selected){
            btn.layer.borderWidth = 0.0;
            btn.selected = NO;
            [btn setTitleColor:[UIColor colorWithHex:@"000000"] forState:UIControlStateNormal];
            if([_lottery_ids containsObject:idddd]){
                [_lottery_ids removeObject:idddd];
            }
        }else{
            [btn setTitleColor:[UIColor colorWithHex:@"ac232d"] forState:UIControlStateNormal];
            btn.selected = YES;
            btn.layer.borderColor = [UIColor colorWithHex:@"e3a4a8"].CGColor;
            btn.layer.borderWidth = .5;
            if(![_lottery_ids containsObject:idddd]){
                [_lottery_ids addObject:idddd];
            }
        }
    }
    if(sender.selected){
        sender.layer.borderWidth = 0.0;
        [sender setTitleColor:[UIColor colorWithHex:@"000000"] forState:UIControlStateNormal];
    }else{
        sender.layer.borderColor = [UIColor colorWithHex:@"e3a4a8"].CGColor;
        [sender setTitleColor:[UIColor colorWithHex:@"ac232d"] forState:UIControlStateNormal];
        sender.layer.borderWidth = .5;
    }
}

- (void)clickBtn:(UIButton *)sender {
    UIButton * bu = [self.headScroll viewWithTag:999];
    if(bu.selected){
        sender.layer.borderWidth = 0.0;
        bu.selected = NO;
        [sender setTitleColor:[UIColor colorWithHex:@"000000"] forState:UIControlStateNormal];
        [_lottery_ids removeAllObjects];
        NSInteger count  = [[CPTBuyDataManager shareManager] allLotteryIds].count;
        for(NSInteger i = 0;i<count;i++){
            UIButton * btn = [self.headScroll viewWithTag:201+i];
            btn.layer.borderWidth = 0.0;
            btn.selected = NO;
            [btn setTitleColor:[UIColor colorWithHex:@"000000"] forState:UIControlStateNormal];
        }
    }
    sender.selected = !sender.selected;
    NSInteger index = (NSInteger)sender.tag-201;
    NSNumber * idNumber = [[CPTBuyDataManager shareManager] allLotteryIds][index];
    NSString * idddd = INTTOSTRING(idNumber.integerValue);
    if(sender.selected){
        sender.layer.borderColor = [UIColor colorWithHex:@"e3a4a8"].CGColor;
        [sender setTitleColor:[UIColor colorWithHex:@"ac232d"] forState:UIControlStateNormal];
        sender.layer.borderWidth = .5;
        if(![_lottery_ids containsObject:idddd]){
            [_lottery_ids addObject:idddd];
        }
    }else{
        sender.layer.borderWidth = 0.0;
        [_lottery_ids removeObject:idddd];
        [sender setTitleColor:[UIColor colorWithHex:@"000000"] forState:UIControlStateNormal];
    }
    [self checkIsOK];
}

- (void)checkIsOK{
    NSInteger count = [[CPTBuyDataManager shareManager] allLotteryIds].count;
    UIButton * bu = [self.headScroll viewWithTag:999];
    if(count == _lottery_ids.count){
        bu.layer.borderColor = [UIColor colorWithHex:@"e3a4a8"].CGColor;
        bu.layer.borderWidth = .5;
        [bu setTitleColor:[UIColor colorWithHex:@"ac232d"] forState:UIControlStateNormal];
    }else{
        bu.layer.borderWidth = 0.0;
        [bu setTitleColor:[UIColor colorWithHex:@"000000"] forState:UIControlStateNormal];
    }
}

- (IBAction)typeClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)hiddenClick:(UIButton *)sender {
    
    [self dismiss];
}

+(LotteryTypeView *)share {
    
    dispatch_once(&onceToken, ^{
        
        lotterytype = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LotteryTypeView class]) owner:self options:nil]lastObject];
        
        lotterytype.frame = CGRectMake(0, NAV_HEIGHT + 30 + 95, SCREEN_WIDTH, 0);
    });
    return lotterytype;
}

+(void)tearDown {
    
    lotterytype = nil;
    
    onceToken = 0l;
}



- (void)dismiss{
    
//    [_lottery_ids removeAllObjects];
//
//    for (UIButton *btn in self.typeBtns) {
//        
//        if (btn.selected) {
//            [_lottery_ids addObject:INTTOSTRING(btn.tag - 100)];
//        }
//    }
    
    if (_lottery_ids.count == 0) {
        
        [MBProgressHUD showError:@"还未选择彩种"];
        
        return;
    }
    
    CGRect frame = self.frame;
    
    frame.size.height = 0;
    
    self.alpha = 1;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = frame;
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        if (self.dismissBlock) {
            
            self.dismissBlock(_lottery_ids);
        }
        
        [_overlayView removeFromSuperview];
        
        [self removeFromSuperview];
    }];
}

- (void)show{
    if(!self.isN){
        [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(-30);
        }];
    }else{
        [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
        }];
    }
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
//    [[AppDelegate shareapp].tab.view addSubview:_overlayView];

    [keywindw addSubview:_overlayView];

    [keywindw addSubview:self];
    CGRect frame = self.frame;



    frame.size.height = SCREEN_HEIGHT ;

    self.alpha = 0;

    [UIView animateWithDuration:0.5 animations:^{

        self.frame = frame;

        self.alpha = 1;

        [self layoutIfNeeded];

    } completion:^(BOOL finished) {

    }];
}

@end
