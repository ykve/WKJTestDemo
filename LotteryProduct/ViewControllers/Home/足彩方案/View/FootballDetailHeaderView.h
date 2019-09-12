//
//  FootballDetailHeaderView.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/27.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FootballDetailModel.h"
#import <WebKit/WKWebView.h>
NS_ASSUME_NONNULL_BEGIN

@interface FootballDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *webBgView;
@property (nonatomic, strong) WKWebView *contentWebVeiw;
- (void)setDataWithModel:(FootballDetailModel *)model;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWebviewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webBgViewHeight;

@end

NS_ASSUME_NONNULL_END
