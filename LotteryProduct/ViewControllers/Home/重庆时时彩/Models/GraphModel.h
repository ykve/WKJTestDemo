//
//  GraphModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphModel : NSObject

@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *selectnumber;
@property (nonatomic, strong) NSMutableArray *array1,*array2, *array3, *array4,*array5, *array6;
@property (nonatomic, assign) NSInteger showbigandsinger;

@end
