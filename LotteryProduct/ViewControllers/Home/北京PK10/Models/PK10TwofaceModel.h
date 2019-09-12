//
//  PK10TwofaceModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PK10TwofaceModel : NSObject

@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSString              * sortname;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , assign) NSInteger              value;

@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              noOpen;
@property (nonatomic , assign) NSInteger              open;

@end
