//
//  PK10HotCoolModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10HotCoolModel.h"

@implementation PK10HotCoolModel

-(NSMutableArray *)hotArray {
    
    if (!_hotArray) {
        
        _hotArray = [[NSMutableArray alloc]init];
    }
    return _hotArray;
}

-(NSMutableArray *)warmthArray {
    
    if (!_warmthArray) {
        
        _warmthArray = [[NSMutableArray alloc]init];
    }
    return _warmthArray;
}

-(NSMutableArray *)coolArray {
    
    if (!_coolArray) {
        
        _coolArray = [[NSMutableArray alloc]init];
    }
    return _coolArray;
}
@end
