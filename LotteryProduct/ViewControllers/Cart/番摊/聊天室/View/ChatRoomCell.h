//
//  ChatRoomCell.h
//  LotteryProduct
//
//  Created by pt c on 2019/5/6.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChatRoomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelImgView;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentBgImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *glyWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *levelWidth;

- (void)setDataWithModel:(ChatMessageModel *)model;
@end

NS_ASSUME_NONNULL_END
