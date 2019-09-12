//
//  CartPCdandanView1.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartPCdandanView1.h"

@implementation CartPCdandanView1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)numberClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (self.type == 10) {

        CartPCModel *model = [self.faceDataArray objectAtIndex:sender.tag - 100];
        
        model.select = sender.selected;
    }
    else if (self.type == 11) {
        
        CartPCModel *model = [self.colorDataArray objectAtIndex:sender.tag - 100];
        
        model.select = sender.selected;
    }
    else {
        CartPCModel *model = self.sameDataArray.firstObject;
        model.select = sender.selected;
    }
    
    if(self.selectBlock) {
        
        self.selectBlock();
    }
}

-(void)setType:(NSInteger)type {
    
    _type = type;

    [self initDataWithtype:type];
}

-(void)random {
    
    if (self.type == 10) {
        
        for (CartPCModel *model in self.faceDataArray) {
            
            model.select = NO;
        }
        
        CartPCModel *model = [self.faceDataArray objectAtIndex:arc4random()%self.faceDataArray.count];
        
        model.select = YES;
        
        for (UIButton *btn in self.numbrBtns) {
          
            CartPCModel *model = [self.faceDataArray objectAtIndex:btn.tag - 100];
            
            btn.selected = model.select;
        }
    }
    else if (self.type == 11) {
        
        for (CartPCModel *model in self.colorDataArray) {
            
            model.select = NO;
        }
        CartPCModel *model = [self.colorDataArray objectAtIndex:arc4random()%self.colorDataArray.count];
        
        model.select = YES;
        
        for (int i = 0; i<self.colorDataArray.count; i++) {
            
            CartPCModel *model = [self.colorDataArray objectAtIndex:i];
            
            UIButton *btn = [self.numbrBtns objectAtIndex:i];
            
            btn.selected = model.select;
        }
    }
    else{
        
        CartPCModel *model = self.sameDataArray.firstObject;
        model.select = YES;
        UIButton *btn = self.numbrBtns.firstObject;
        btn.selected = model.select;
    }
}

-(void)clear {
    
    if (self.type == 10) {
    
        for (UIButton *btn in self.numbrBtns) {
            
            CartPCModel *model = [self.faceDataArray objectAtIndex:btn.tag - 100];
            
            model.select = NO;
            
            btn.selected = model.select;
            
        }
    }
    else if (self.type == 11) {
        
        for (int i = 0; i<self.colorDataArray.count; i++) {
            
            CartPCModel *model = [self.colorDataArray objectAtIndex:i];
            
            model.select = NO;
            
            UIButton *btn = [self.numbrBtns objectAtIndex:i];
            
            btn.selected = model.select;
        }
    }
    else{
        
        CartPCModel *model = self.sameDataArray.firstObject;
        model.select = NO;
        UIButton *btn = self.numbrBtns.firstObject;
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
        
        if (type == 10) {
            
            self.faceDataArray = [CartPCModel mj_objectArrayWithKeyValuesArray:data.data[@"oddsList"]];
            
            for (UIButton *btn in self.numbrBtns) {
                
                btn.hidden = NO;
                
                [btn setTitleColor:YAHEI forState:UIControlStateNormal];
                
                CartPCModel *model = [self.faceDataArray objectAtIndex:btn.tag - 100];
                
                model.select = NO;
                
                btn.selected = model.select;
                
                [btn setTitle:model.name forState:UIControlStateNormal];
            }
        }
        else if (type == 11) {
            
            self.colorDataArray = [CartPCModel mj_objectArrayWithKeyValuesArray:data.data[@"oddsList"]];
            
            for (UIButton *btn in self.numbrBtns) {
                
                btn.hidden = YES;
            }
            for (int i = 0; i<self.colorDataArray.count; i++) {
                
                CartPCModel *model = [self.colorDataArray objectAtIndex:i];
                
                UIButton *btn = [self.numbrBtns objectAtIndex:i];
                
                btn.hidden = NO;
                
                model.select = NO;
                
                btn.selected = model.select;
                
                [btn setTitle:model.name forState:UIControlStateNormal];
                
                [btn setTitleColor:i == 0 ? [UIColor colorWithHex:@"f15347"] : i == 1 ? [UIColor colorWithHex:@"0587c5"] : [UIColor colorWithHex:@"46be64"] forState:UIControlStateNormal];
            }
        }
        else if (type == 12) {
            
            self.sameDataArray = [CartPCModel mj_objectArrayWithKeyValuesArray:data.data[@"oddsList"]];
            
            for (UIButton *btn in self.numbrBtns) {
                
                btn.hidden = YES;
            }
            for (CartPCModel *model in self.sameDataArray) {
                
                UIButton *btn = self.numbrBtns.firstObject;
                
                btn.hidden = NO;
                
                model.select = NO;
                
                btn.selected = model.select;
                
                [btn setTitleColor:YAHEI forState:UIControlStateNormal];
                
                [btn setTitle:model.name forState:UIControlStateNormal];
            }
        }
        
    } failure:^(NSError *error) {
       
        self.hidden = YES;
        
    } showHUD:NO];
}


@end
