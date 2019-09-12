//
//  ZJDetailCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/7/2.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpertModel.h"
#import "TuidanDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZJDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
//累计中奖（专家详情）
@property (weak, nonatomic) IBOutlet UILabel *ljzjNameLabel;
//中奖金额(专家详情)
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel1;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel2;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel3;
@property (weak, nonatomic) IBOutlet UIButton *btn1;//推荐中
@property (weak, nonatomic) IBOutlet UIButton *btn2;//已结束
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (nonatomic,copy) void(^didUpdateModel)(ExpertModel *);
@property (nonatomic,copy) void(^didClickBtn)(NSInteger);
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UILabel *slNameLabel;
@property (nonatomic,assign) BOOL isGendan;//跟单详情还是专家详情
@property (weak, nonatomic) IBOutlet UIImageView *fourItemsBgImgView;
/*以下跟单详情才有*/
@property (weak, nonatomic) IBOutlet UIView *genDanView;
//跟单详情（跟单）
@property (weak, nonatomic) IBOutlet UILabel *gdZJNameLab;
//中奖金额（跟单）
@property (weak, nonatomic) IBOutlet UILabel *gdZJValueLab;
//彩种名
@property (weak, nonatomic) IBOutlet UILabel *lotteryNameLabel;
//期数
@property (weak, nonatomic) IBOutlet UILabel *issueLabel;
//跟单截止
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//分析内容
@property (weak, nonatomic) IBOutlet UILabel *zjAnalyseLabel;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *pictureImgView;
//图片高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picHeight;
//跟单人数
@property (weak, nonatomic) IBOutlet UILabel *followNumLabel;

//选号金额
@property (weak, nonatomic) IBOutlet UILabel *boxLab1;
@property (weak, nonatomic) IBOutlet UILabel *boxLab2;
@property (weak, nonatomic) IBOutlet UILabel *boxLab3;
@property (weak, nonatomic) IBOutlet UILabel *boxLab4;
//投注内容详情
@property (weak, nonatomic) IBOutlet UILabel *contentLab1;
@property (weak, nonatomic) IBOutlet UILabel *contentLab2;
@property (weak, nonatomic) IBOutlet UILabel *contentLab3;
@property (weak, nonatomic) IBOutlet UILabel *contentLab4;
@property (weak, nonatomic) IBOutlet UILabel *contentLab5;
@property (weak, nonatomic) IBOutlet UILabel *contentLab6;
@property (weak, nonatomic) IBOutlet UILabel *contentLab7;
//保密view
//@property (weak, nonatomic) IBOutlet UIView *secretView;
//@property (weak, nonatomic) IBOutlet UILabel *secretLabel;
//中奖状态邮戳bgView
@property (weak, nonatomic) IBOutlet UIView *winStateView;


- (void)setDataWithModel:(ExpertModel *)model;
/// 
@property (nonatomic, strong) TuidanDetailModel *model;

@end

NS_ASSUME_NONNULL_END
