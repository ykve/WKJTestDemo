//
//  SixArticleDetailHeaderView.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/30.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendDetailModel.h"
#import "TouPiaoView.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol SixArticleDetailHeaderViewDelegate <NSObject>

- (void)attentionSomeone:(UIButton *)sender;
- (void)skipToEditVc;
- (void)replyArticle;

@end

@interface SixArticleDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *touPiaoViewHeight;

@property (weak, nonatomic) IBOutlet TouPiaoView *xinshuiTouPiaoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dashenImgWidth;

@property (weak, nonatomic) IBOutlet UIView *WKWebViewBackView;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWebviewHeight;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWebviewHeight;

@property (nonatomic, strong) WKWebView *contentWebVeiw;
@property (nonatomic, strong) UIWebView *contentWebVeiw10;

//@property (weak, nonatomic) IBOutlet UIWebView *contentWebVeiw;

//@property (weak, nonatomic) IBOutlet UIView *topSeperatorLine;
//二维码图片高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *qrCodeImgViewHeight;
/*  头像  */
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
/*  昵称  */
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;
/*  关注  */
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;
/*  标题  */
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@property (weak, nonatomic) IBOutlet UIImageView *qrImgView;
@property (weak, nonatomic) IBOutlet UIView *remarkBackView;
@property (weak, nonatomic) IBOutlet UIImageView *touxianImgView;
@property (weak, nonatomic) IBOutlet UILabel *remarkLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLblHeight;

@property (nonatomic, strong) RecommendDetailModel *model;

@property (nonatomic,weak) id<SixArticleDetailHeaderViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
