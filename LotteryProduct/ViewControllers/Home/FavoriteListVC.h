//
//  FavoriteListVC.h
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,EditState)
{
    EditState_ing                       =   0,
    EditState_ok                       =   1,
    
};
@interface FavoriteListVC : RootCtrl
@property (strong, nonatomic) NSMutableArray *favData;
@property (nonatomic, assign)EditState state;

@end

NS_ASSUME_NONNULL_END
