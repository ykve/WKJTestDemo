//
//  LiveOpenLotteryViewController.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

NS_ASSUME_NONNULL_BEGIN

// title直播开奖
@interface LiveOpenLotteryViewController : RootCtrl

@property (weak, nonatomic) IBOutlet UITableView *listTabelView;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UIView *chatBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatBgHeight;
@property (weak, nonatomic) IBOutlet UIView *liveBgView;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UITableView *orderListTableView;
@property (nonatomic,assign)NSInteger lotteryId;
@property (nonatomic,assign) BOOL pureChat;//纯聊天
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderListTableViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSafeArea;
@property (weak, nonatomic) IBOutlet UIButton *upDownBtn;

@property (weak, nonatomic) IBOutlet UIView *chatTitleBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatTitleHeight;
@property (weak, nonatomic) IBOutlet UILabel *chatTitleLabel;

@end

NS_ASSUME_NONNULL_END
