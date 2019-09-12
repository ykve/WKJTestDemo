//
//  CPTBuyFantanCtrl.h
//  LotteryProduct
//
//  Created by pt c on 2019/3/6.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPTBuyFantanCtrl : RootCtrl <UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *niuWinLabel;

@property (weak, nonatomic) IBOutlet UIView *stopView;//封盘view
@property (nonatomic, assign) NSInteger endTime;
@property (assign,nonatomic) CPTBuyTicketType type;
@property (copy,nonatomic)   NSString *lotteryName;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, assign) NSInteger lotteryId;
@property (weak, nonatomic) IBOutlet UITableView *centerTableView;//核心tableView tag:0
@property (weak, nonatomic) IBOutlet UIView *bottomView;//购彩底部view
@property (weak, nonatomic) IBOutlet UIView *headNewView;//双色球，大乐透，七乐彩 才有
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;//开奖历史
@property (weak, nonatomic) IBOutlet UICollectionView *latestOpenResultCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *nextImgView;
@property (weak, nonatomic) IBOutlet UIButton *addBalanceBtn;


@property (weak, nonatomic) IBOutlet UIView *floatView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *floatViewTopSpace;
@property (weak, nonatomic) IBOutlet UIImageView *floatImgView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;//浮动view的余额
@property (weak, nonatomic) IBOutlet UILabel *playNameLabel;//浮动窗口的玩法名称
@property (weak, nonatomic) IBOutlet UITextField *textField;//每注金额
@property (weak, nonatomic) IBOutlet UILabel *totalCountAndCostLabel;//2注2元
@property (weak, nonatomic) IBOutlet UILabel *winTotalLabel;//最高赢取金额

@property (weak, nonatomic) IBOutlet UIButton *basketBtn;//购彩篮
@property (weak, nonatomic) IBOutlet UILabel *openIssueLabel;//当期期号
@property (weak, nonatomic) IBOutlet UILabel *nextOpenLabel;//下期期号

//底部三个view
@property (weak, nonatomic) IBOutlet UIView *bootomCenterView;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeftView;
@property (weak, nonatomic) IBOutlet UIView *bottomTopView;

@property (weak, nonatomic) IBOutlet UIButton *jianBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *speakImgView;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *shakeBtn;
@property (weak, nonatomic) IBOutlet UIButton *addToBasketBtn;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@property (weak, nonatomic) IBOutlet UIView *headerInsideView;
//head背景
@property (weak, nonatomic) IBOutlet UIView *niuWinBgView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *niuniuRetViewWidth;






//倒计时
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;//立即购买按钮

@property (weak, nonatomic) IBOutlet UIButton *goToHistoryBtn;



@end

NS_ASSUME_NONNULL_END
