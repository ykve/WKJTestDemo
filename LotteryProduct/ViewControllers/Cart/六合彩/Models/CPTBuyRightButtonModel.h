//
//  CPTBuyRightButtonModel.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CPTBuyLeftButtonUIType)//球的ui布局风格
{
    CPTBuyLeftButtonUIType_Four,//4个球
    CPTBuyLeftButtonUIType_One,
    CPTBuyLeftButtonUIType_Two,
    CPTBuyLeftButtonUIType_Three
};
@interface CPTBuyRightButtonModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *superKey;
@property (nonatomic, assign) CPTBuyLeftButtonUIType uiType;

@property (nonatomic, assign) BOOL selected;
@end

NS_ASSUME_NONNULL_END
