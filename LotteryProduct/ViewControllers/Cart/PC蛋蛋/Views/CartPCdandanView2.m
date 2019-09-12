//
//  CartPCdandanView2.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartPCdandanView2.h"

@interface CartPCdandanView2()

@property (nonatomic, strong) NSMutableArray *randomArr;

@end
@implementation CartPCdandanView2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.segment.selectedSegmentIndex = -1;
    [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateSelected];
    
    [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}forState:UIControlStateNormal];
    
    [self.segment setDividerImage:[Tools createImageWithColor:[UIColor lightGrayColor] Withsize:CGSizeMake(1, 20)] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (IBAction)segmentClick:(UISegmentedControl *)sender {
    
    for (CartPCModel *model in self.numberDataArray) {
        
        model.select = NO;
    }
    
    if (sender.selectedSegmentIndex == 0) {
        
        for (CartPCModel *model in self.numberDataArray) {
            
            model.select = YES;
        }
    }
    else if (sender.selectedSegmentIndex == 1) {
        
        for (CartPCModel *model in self.numberDataArray) {
            
            model.select = model.name.integerValue > 13 ? YES : NO;
        }
    }
    else if (sender.selectedSegmentIndex == 2) {
        
        for (CartPCModel *model in self.numberDataArray) {
            
            model.select = model.name.integerValue < 14 ? YES : NO;
        }
    }
    else if (sender.selectedSegmentIndex == 3) {
        
        for (CartPCModel *model in self.numberDataArray) {
            
            model.select = model.name.integerValue & 1;
        }
    }
    else if (sender.selectedSegmentIndex == 4) {
        
        for (CartPCModel *model in self.numberDataArray) {
            
            model.select = !(model.name.integerValue & 1);
        }
    }
    else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            sender.selectedSegmentIndex = -1;
        });
    }
    
    for (UIButton *btn in self.numberBtns) {
        
        CartPCModel *model = [self.numberDataArray objectAtIndex:btn.tag - 100];
        
        btn.selected = model.select;
    }
    
    if(self.selectBlock) {
        
        self.selectBlock();
    }
}

- (IBAction)numberClick:(UIButton *)sender {
    
    self.segment.selectedSegmentIndex = -1;
    
    if (self.type == 13) {
        
        UIButton *curentBtn = nil;
        int i = 0;
        for (UIButton *btn in self.numberBtns) {
            
            if (btn.selected) {
                
                curentBtn = btn;
                
                i++;
            }
        }
        if (i == 3 && sender.selected == NO){
            
            curentBtn.selected = NO;
            
            CartPCModel *curentmodel = [self.numberDataArray objectAtIndex:curentBtn.tag-100];
            
            curentmodel.select = NO;
        }
    }
    sender.selected = !sender.selected;
    
    CartPCModel *model = [self.numberDataArray objectAtIndex:sender.tag - 100];
    
    model.select = sender.selected;
    
    if(self.selectBlock) {
        
        self.selectBlock();
    }
}

-(void)setType:(NSInteger)type {
    
    _type = type;
    
    if (type == 14) {
        
        self.segment.hidden = NO;
        self.segment.selectedSegmentIndex = -1;
    }
    else{
        self.segment.hidden = YES;
    }
    
    [self initDataWithtype:type];
}

-(void)random {
    
    for (CartPCModel *model in self.numberDataArray) {
        
        model.select = NO;
        
    }
    if (self.type == 13) {
        
        self.randomArr = [self getDifferentRandomWithNum:3];
        
        CartPCModel *model1 = [self.numberDataArray objectAtIndex:[self.randomArr[0] integerValue]];
        CartPCModel *model2 = [self.numberDataArray objectAtIndex:[self.randomArr[1] integerValue]];
        CartPCModel *model3 = [self.numberDataArray objectAtIndex:[self.randomArr[2] integerValue]];
        
        model1.select = YES;
        model2.select = YES;
        model3.select = YES;
    }
    else {
        CartPCModel *model = [self.numberDataArray objectAtIndex:arc4random()%self.numberDataArray.count];
        
        model.select = YES;
    }
    
    
    for (int i = 0; i< self.numberDataArray.count; i++) {
        
        CartPCModel *model = [self.numberDataArray objectAtIndex:i];
        
        UIButton *btn = [self.numberBtns objectAtIndex:i];
        
        btn.selected = model.select;
    }
}

-(void)clear {
    
    self.segment.selectedSegmentIndex = -1;
    
    for (int i = 0; i< self.numberDataArray.count; i++) {
        
        CartPCModel *model = [self.numberDataArray objectAtIndex:i];
        
        model.select = NO;
        
        UIButton *btn = [self.numberBtns objectAtIndex:i];
        
        btn.selected = model.select;
    }
}

- (IBAction)cartinfoClick:(id)sender {
    
    if (self.cartInfoBlock) {
        
        self.cartInfoBlock();
    }
}

-(void)initDataWithtype:(NSInteger)type {
    
    [WebTools postWithURL:@"/lottery/queryPcddBuy.json" params:@{@"playId":@(type),@"lotteryId":@(self.lotteryId)} success:^(BaseData *data) {
        
        self.hidden = NO;
        
        self.titlelab.text = data.data[@"name"];
        
        if (self.type == 14) {
            
            self.numberDataArray = [CartPCModel mj_objectArrayWithKeyValuesArray:data.data[@"oddsList"]];
            
            for (int i = 0; i< self.numberDataArray.count; i++) {
                
                CartPCModel *model = [self.numberDataArray objectAtIndex:i];
                
                if ([model.name containsString:@"特码"]) {
                    
                    model.name = [model.name stringByReplacingOccurrencesOfString:@"特码" withString:@""];
                }
                
                UIButton *btn = [self.numberBtns objectAtIndex:i];
                
                [btn setTitle:model.name forState:UIControlStateNormal];
            }
        }
        else {
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            
            for (UIButton *btn in self.numberBtns) {
                
                CartPCModel *model = [[CartPCModel alloc]init];
                model.name = btn.titleLabel.text;
                model.select = NO;
                [array addObject:model];
            }
            
            self.numberDataArray = [array mutableCopy];
            
            [array removeAllObjects];
        }
        
    } failure:^(NSError *error) {
        
        self.hidden = YES;
        
    } showHUD:NO];
}

//获取到num个不同的随机数就返回随机数数组

-(NSMutableArray *)getDifferentRandomWithNum:(NSInteger )num{
    
    if(self.randomArr &&self.randomArr.count>0){
        
        [self.randomArr removeAllObjects];
        
    }
    NSInteger random;
    
    for (;;) {
        
        random=arc4random_uniform(28);//随机数0-27
        
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

@end
