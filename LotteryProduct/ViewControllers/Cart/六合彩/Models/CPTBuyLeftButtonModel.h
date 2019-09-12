//
//  CPTBuyLeftButtonModel.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPTSixModel.h"
#import "CPTBuyDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPTBuyLeftButtonModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *superKey;

@property (nonatomic, assign) CPTBuyTicketType ticketType;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) NSInteger numberOfSections;

@end

NS_ASSUME_NONNULL_END
