//
//  AdvertModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *targetType;
@property (nonatomic, strong) NSNumber *targetId;

@end
