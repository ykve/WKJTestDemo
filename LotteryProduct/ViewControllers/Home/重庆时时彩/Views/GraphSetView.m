//
//  GraphSetView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "GraphSetView.h"

@interface GraphSetView()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *versionBtns;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *lineBtns;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *missBtns;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *sortBtns;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *statisticBtns;

@property (strong, nonatomic) UIControl *overlayView;

@property (strong, nonatomic) NSMutableDictionary *setDic;
@end

@implementation GraphSetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = WHITE;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor = [UIColor blackColor];
    _overlayView.alpha = 0.3;
    
    self.topView.backgroundColor = [[CPTThemeConfig shareManager] GraphSetViewBckgroundColor];
    
    self.frame = CGRectMake(20, -285, SCREEN_WIDTH - 40, 285);
}

- (IBAction)versionClick:(UIButton *)sender {
    
    for (UIButton *btn in _versionBtns) {
        
        btn.selected = NO;
    }
    
    sender.selected = YES;
    
    [self.setDic setValue:@(sender.tag-100) forKey:@"version"];
}

- (IBAction)showlineClick:(UIButton *)sender {
    
    for (UIButton *btn in _lineBtns) {
        
        btn.selected = NO;
    }
    
    sender.selected = YES;
    
    [self.setDic setValue:@(sender.tag-200) forKey:@"line"];
}

- (IBAction)showmissClick:(UIButton *)sender {
    
    for (UIButton *btn in _missBtns) {
        
        btn.selected = NO;
    }
    sender.selected = YES;
    
    [self.setDic setValue:@(sender.tag-300) forKey:@"miss"];
}

- (IBAction)sortClick:(UIButton *)sender {
    
    for (UIButton *btn in _sortBtns) {
        
        btn.selected = NO;
    }
    sender.selected = YES;
    
    [self.setDic setValue:@(sender.tag-400) forKey:@"sort"];
}

- (IBAction)showstatisticClick:(UIButton *)sender {
    
    for (UIButton *btn in _statisticBtns) {
        
        btn.selected = NO;
    }
    sender.selected = YES;
    
    [self.setDic setValue:@(sender.tag-500) forKey:@"statistic"];
}

- (IBAction)dismissClick:(id)sender {
    
    if (self.setBlock) {
        
        self.setBlock(self.setDic);
    }
    
    [self dismiss];
}

+(GraphSetView *)share {
    
    return [[NSBundle mainBundle]loadNibNamed:@"GraphSetView" owner:self options:nil].firstObject;
}

-(void)showWithInfo:(NSDictionary *)dic {
    
    NSNumber *num1 = [dic valueForKey:@"version"];
    NSNumber *num2 = [dic valueForKey:@"line"];
    NSNumber *num3 = [dic valueForKey:@"miss"];
    NSNumber *num4 = [dic valueForKey:@"sort"];
    NSNumber *num5 = [dic valueForKey:@"statistic"];
    
    self.setDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    UIButton *btn1 = [self.versionBtns objectAtIndex:num1.integerValue];
    btn1.selected = YES;
    UIButton *btn2 = [self.lineBtns objectAtIndex:num2.integerValue];
    btn2.selected = YES;
    UIButton *btn3 = [self.missBtns objectAtIndex:num3.integerValue];
    btn3.selected = YES;
    UIButton *btn4 = [self.sortBtns objectAtIndex:num4.integerValue];
    btn4.selected = YES;
    UIButton *btn5 = [self.statisticBtns objectAtIndex:num5.integerValue];
    btn5.selected = YES;
    
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    [keywindw addSubview:_overlayView];
    [keywindw addSubview:self];
    
    CGRect frame = self.frame;
    
    frame.origin.y = keywindw.center.y - frame.size.height/2;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = frame;
        
        [self layoutIfNeeded];
        
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)dismiss {
    
    CGRect frame = self.frame;
    
    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [_overlayView removeFromSuperview];
        
        [self removeFromSuperview];
    }];
}


@end
