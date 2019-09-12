//
//  PropertyModel.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PropertyModel.h"

@implementation PropertyModel

-(NSMutableArray *)listArray {
    
    if (!_listArray) {
        
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

-(NSMutableString *)contentstring {
    
    if (!_contentstring) {
        
        _contentstring = [[NSMutableString alloc]init];
        
        for (NSString*str in self.listArray) {
            
            if (_contentstring.length) {
                
                [_contentstring appendString:@","];
            }
            [_contentstring appendString:str];
        }
    }
    return _contentstring;
}
@end
