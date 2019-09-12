//
//  ChatRoomCtrl.h
//  LotteryProduct
//
//  Created by pt c on 2019/5/2.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatRoomCtrl : RootCtrl <UITextFieldDelegate>

@property (nonatomic,assign) NSInteger lotteryId;
@property (nonatomic,copy) NSString *roomName;

@property (nonatomic,assign) BOOL isLive;//直播
@property (nonatomic,assign) BOOL isFormHome;
@property (nonatomic,assign) NSInteger selectedSegmentIndex;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderListTableViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewToBottomSpace;

- (void)setFrameWithView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
