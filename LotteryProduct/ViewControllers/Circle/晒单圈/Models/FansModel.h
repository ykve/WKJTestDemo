//
//  FansModel.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/17.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FansModel : NSObject

@property (nonatomic , assign) NSInteger              memberId;
@property (nonatomic , copy) NSString              * heads;
@property (nonatomic , assign) NSInteger              isFocus;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * fansNumber;
@property (nonatomic , copy) NSString              * focusNumner;

@end
