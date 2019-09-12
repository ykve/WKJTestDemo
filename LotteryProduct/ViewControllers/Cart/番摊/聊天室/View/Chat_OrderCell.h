//
//  Chat_OrderCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/5/7.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessageModel.h"
#import "PushOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Chat_OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelImgView;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIImageView *contentBgImgView;
@property (weak, nonatomic) IBOutlet UIView *tagsBgView;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UILabel *playNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *winPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (nonatomic,copy) void(^didReceiveRet)(BaseData *);
@property (nonatomic,copy) void(^showErrorMessage)(NSString *);
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *glyWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *levelWidth;
@property (nonatomic,copy) void(^didPushOrder)(PushOrderModel *);

- (void)setDataWithModel:(ChatMessageModel *)model;

@end

NS_ASSUME_NONNULL_END
