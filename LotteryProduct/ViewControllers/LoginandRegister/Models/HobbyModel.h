//
//  HobbyModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/9/29.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HobbyModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSNumber *ID;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) BOOL select;

@end
