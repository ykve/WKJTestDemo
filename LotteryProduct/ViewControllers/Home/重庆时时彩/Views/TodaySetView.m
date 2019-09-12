//
//  TodaySetView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "TodaySetView.h"

@implementation TodaySetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setType:(NSInteger)type {
    
    _type = type;
    
    if (type == 1) {
        
        UIView *v1 = [self viewWithTag:300];
        UIView *v2 = [self viewWithTag:301];
        UIView *v3 = [self viewWithTag:302];
        
        v1.backgroundColor = [UIColor colorWithHex:@"FFF8D9"];
        v2.backgroundColor = [UIColor colorWithHex:@"F9DDCB"];
        v3.backgroundColor = [UIColor colorWithHex:@"CCD8F9"];
    }
}

- (IBAction)cancelClick:(UIButton *)sender {
    
    self.todaysetBlock(@{@"type":@0});
}
- (IBAction)sureClick:(UIButton *)sender {
    
    if ((self.yellowminfield.text.length>0 && self.yellowminfield.text.integerValue < 2) || self.yellowmaxfield.text.integerValue > 500 || (self.orangeminfield.text.length>0 &&self.orangeminfield.text.integerValue < 2) || self.orangemaxfield.text.integerValue > 500 || (self.blueminfield.text.length>0 && self.blueminfield.text.integerValue < 2) || self.bluemaxfield.text.integerValue > 500) {
        
        [MBProgressHUD showError:@"参考范围2-500"];
        
        return;
    }
    if (self.yellowminfield.text.length > 0 && self.yellowmaxfield.text.length > 0) {
        
        if (self.yellowminfield.text.integerValue > self.yellowmaxfield.text.integerValue) {
            
            [MBProgressHUD showError:@"参考范围2-500"];
            
            return;
        }
    }
    else if ((self.yellowminfield.text.length > 0 && self.yellowmaxfield.text.length == 0) || (self.yellowminfield.text.length == 0 && self.yellowmaxfield.text.length > 0)){
        
        [MBProgressHUD showError:@"参考范围2-500"];
        
        return;
    }
    if (self.orangeminfield.text.length>0 && self.orangemaxfield.text.length > 0) {
        
        if (self.orangeminfield.text.integerValue > self.orangemaxfield.text.integerValue) {
            
            [MBProgressHUD showError:@"参考范围2-500"];
            
            return;
        }
    }
    else if ((self.orangeminfield.text.length > 0 && self.orangemaxfield.text.length == 0) || (self.orangeminfield.text.length == 0 && self.orangemaxfield.text.length > 0)) {
        
        [MBProgressHUD showError:@"参考范围2-500"];
        
        return;
    }
    if (self.blueminfield.text.length > 0 && self.bluemaxfield.text.length > 0) {
        
        if (self.blueminfield.text.integerValue > self.bluemaxfield.text.integerValue) {
            
            [MBProgressHUD showError:@"参考范围2-500"];
            
            return;
        }
    }
    else if ((self.blueminfield.text.length > 0 && self.bluemaxfield.text.length == 0) || (self.blueminfield.text.length == 0 && self.bluemaxfield.text.length > 0)) {
        
        [MBProgressHUD showError:@"参考范围2-500"];
        
        return;
    }

    if ([self checksamplenumber]) {
        
        [MBProgressHUD showError:@"参考范围不能重复或重叠"];
        
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@1 forKey:@"type"];
    
    if (self.yellowminfield.text.length > 0 && self.yellowmaxfield.text.length > 0) {
        
        [dic setValue:self.yellowminfield.text forKey:@"y_min"];
        [dic setValue:self.yellowmaxfield.text forKey:@"y_max"];
        [dic setValue:@"FFF8D9" forKey:@"y_color"];
    }
    if (self.orangeminfield.text.length > 0 && self.orangemaxfield.text.length > 0) {
        
        [dic setValue:self.orangeminfield.text forKey:@"o_min"];
        [dic setValue:self.orangemaxfield.text forKey:@"o_max"];
        [dic setValue:@"F9DDCB" forKey:@"o_color"];
    }
    if (self.blueminfield.text.length > 0 && self.bluemaxfield.text.length > 0) {
        
        [dic setValue:self.blueminfield.text forKey:@"b_min"];
        [dic setValue:self.bluemaxfield.text forKey:@"b_max"];
        [dic setValue:@"CCD8F9" forKey:@"b_color"];
    }
    self.todaysetBlock(dic);
}

#pragma mark - 判断是否有交集 ，YES有 NO无
-(BOOL)checksamplenumber{
    
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
    NSMutableArray *array2 = [[NSMutableArray alloc]init];
    NSMutableArray *array3 = [[NSMutableArray alloc]init];
    
    if (self.yellowminfield.text.length>0 && self.yellowmaxfield.text.length>0) {
        
        for (NSInteger i = self.yellowminfield.text.integerValue ; i<= self.yellowmaxfield.text.integerValue; i++) {
            
            [array1 addObject:@(i)];
        }
    }
    if (self.orangeminfield.text.length>0 && self.orangemaxfield.text.length>0) {
        
        for (NSInteger i = self.orangeminfield.text.integerValue ; i<= self.orangemaxfield.text.integerValue; i++) {
            
            [array2 addObject:@(i)];
        }
    }
    if (self.blueminfield.text.length>0 && self.bluemaxfield.text.length>0) {
        
        for (NSInteger i = self.blueminfield.text.integerValue ; i<= self.bluemaxfield.text.integerValue; i++) {
            
            [array3 addObject:@(i)];
        }
    }
    NSMutableSet *set1 = [NSMutableSet setWithArray:array1];
    NSMutableSet *set2 = [NSMutableSet setWithArray:array2];
    NSMutableSet *set3 = [NSMutableSet setWithArray:array3];
    
    BOOL intersect1 = [set1 intersectsSet:set2];
    BOOL intersect2 = [set1 intersectsSet:set3];
    BOOL intersect3 = [set2 intersectsSet:set3];
    
    if (intersect1 == NO && intersect2 == NO && intersect3 == NO) {
        
        return NO;
    }
    else {
        return YES;
    }
    
}


@end
