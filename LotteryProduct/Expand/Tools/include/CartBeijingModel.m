//
//  CartBeijingModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/10.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartBeijingModel.h"

@implementation CartBeijingModel

-(id)init {
    
    self = [super init];
    
    if (self) {
        
        self.segmenttype = -1;
    }
    return self;
}

-(NSMutableArray *)selectnumbers {
    
    if (!_selectnumbers) {
        
        _selectnumbers = [[NSMutableArray alloc]init];
    }
    return _selectnumbers;
}

-(NSMutableArray *)odds {
    
    if (!_odds) {
        
        _odds = [[NSMutableArray alloc]init];
    }
    return _odds;
}

@end


