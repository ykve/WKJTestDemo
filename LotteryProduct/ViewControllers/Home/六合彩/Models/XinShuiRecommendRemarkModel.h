//
//  XinShuiRecommendRemarkModel.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/11/27.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "XinShuiRecommendRemarkModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XinShuiRecommendRemarkModel : NSObject

@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic, strong) NSString *heads;
@property (nonatomic, copy) NSString *createTime;

@property (nonatomic , copy) NSString              *ID;

+(CGFloat)heightForRowWithReMarkContent:(XinShuiRecommendRemarkModel *)model;

@end

NS_ASSUME_NONNULL_END
