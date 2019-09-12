//
//  ChongqinFreeModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/8/8.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ChongqinFreeModel.h"

@implementation ChongqinFreeModel

-(NSMutableArray *)list {
    
    if (!_list) {
        
        _list = [[NSMutableArray alloc]init];
    }
    return _list;
}
@end

@implementation ChongqinFreeListModel

-(void)setModel:(ChongqinFreeListInfoModel *)model {
    
    _model = model;
    
    NSMutableDictionary *dic  = [[NSMutableDictionary alloc]init];
    [dic setValue:model.ballOneNumber forKey:@"1"];
    [dic setValue:model.ballOneSingle forKey:@"2"];
    [dic setValue:model.ballOneSize forKey:@"3"];
    [dic setValue:@"第一球" forKey:@"title"];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc]init];
    [dic2 setValue:model.ballTwoNumber forKey:@"1"];
    [dic2 setValue:model.ballTwoSingle forKey:@"2"];
    [dic2 setValue:model.ballTwoSize forKey:@"3"];
    [dic2 setValue:@"第二球" forKey:@"title"];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc]init];
    [dic3 setValue:model.ballThreeNumber forKey:@"1"];
    [dic3 setValue:model.ballThreeSingle forKey:@"2"];
    [dic3 setValue:model.ballThreeSize forKey:@"3"];
    [dic3 setValue:@"第三球" forKey:@"title"];
    
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc]init];
    [dic4 setValue:model.ballFourNumber forKey:@"1"];
    [dic4 setValue:model.ballFourSingle forKey:@"2"];
    [dic4 setValue:model.ballFourSize forKey:@"3"];
    [dic4 setValue:@"第四球" forKey:@"title"];
    
    NSMutableDictionary *dic5 = [[NSMutableDictionary alloc]init];
    [dic5 setValue:model.ballFiveNumber forKey:@"1"];
    [dic5 setValue:model.ballFiveSingle forKey:@"2"];
    [dic5 setValue:model.ballFiveSize forKey:@"3"];
    [dic5 setValue:@"第五球" forKey:@"title"];
    
//    self.array = @[dic,dic2,dic3,dic4,dic5,@{@"dragonTiger":model.dragonTiger,@"title":@"龙虎"}];
    self.array = @[dic,dic2,dic3,dic4,dic5];
}

@end

@implementation ChongqinFreeListInfoModel

@end
