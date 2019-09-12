//
//  LiuHeBangDanListViewController.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"
#import "LiuHeDashenModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface LiuHeBangDanListViewController : RootCtrl

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, strong)LiuHeDashenModel *model;

@end

NS_ASSUME_NONNULL_END
