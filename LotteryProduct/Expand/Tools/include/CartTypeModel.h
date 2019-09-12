//
//  CartTypeModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartTypeModel : NSObject
//吃，w
@property (nonatomic, copy) NSString *title;

@property (nonatomic , assign) NSInteger              ID;
@property (nonatomic , copy) NSString              * parentId;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              categoryId;
@property (nonatomic , assign) BOOL                  selected;
/**
 YES:组选玩法
 NO:直选
 */
@property (nonatomic , assign) BOOL                  isgroup;
@property (nonatomic, strong)NSMutableArray *type1Array;

@property (nonatomic, strong)NSMutableArray *type2Array;

@end
