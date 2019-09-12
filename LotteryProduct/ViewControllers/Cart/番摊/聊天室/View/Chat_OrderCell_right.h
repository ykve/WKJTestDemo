//
//  Chat_OrderCell_right.h
//  LotteryProduct
//
//  Created by pt c on 2019/5/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessageModel.h"
#import "PushOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Chat_OrderCell_right : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *levelImgView;
//@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
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

@property (nonatomic,copy) void(^didPushOrder)(PushOrderModel *);

- (void)setDataWithModel:(ChatMessageModel *)model;
@end

NS_ASSUME_NONNULL_END
