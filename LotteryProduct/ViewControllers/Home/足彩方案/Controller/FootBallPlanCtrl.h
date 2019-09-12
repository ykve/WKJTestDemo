//
//  FootBallPlanCtrl.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

NS_ASSUME_NONNULL_BEGIN

@interface FootBallPlanCtrl : RootCtrl
@property (weak, nonatomic) IBOutlet UIButton *btn1;//大厅
@property (weak, nonatomic) IBOutlet UIButton *btn2;//精华
@property (weak, nonatomic) IBOutlet UIButton *btn3;//关注
@property (weak, nonatomic) IBOutlet UIView *moveLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleToTopHeight;
@property (weak, nonatomic) IBOutlet UIView *searchBgView;
@property (nonatomic,assign) BOOL isHistory;
@property (nonatomic,assign) NSInteger hostID;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeight;
@end

NS_ASSUME_NONNULL_END
