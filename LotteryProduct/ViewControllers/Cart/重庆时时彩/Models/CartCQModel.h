//
//  CartCQModel.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/30.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartCQModel : NSObject

@property (nonatomic,copy) NSString *ID;

@property (nonatomic, strong) NSArray *numbers;

@property (nonatomic, strong) NSMutableArray *selectnumbers;

@property (nonatomic, copy) NSString *peiLv;

@property (nonatomic, copy) NSString *title;

@property (nonatomic,assign) BOOL selected;


//@property (nonatomic, assign) NSInteger segmenttype;

//@property (nonatomic, strong) NSDictionary *missdata;

@end

NS_ASSUME_NONNULL_END
