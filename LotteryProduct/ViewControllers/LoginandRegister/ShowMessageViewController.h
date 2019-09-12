//
//  ShowMessageViewController.h
//  LotteryProduct
//
//  Created by pt c on 2019/6/14.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShowMessageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property (nonatomic,assign) NSInteger code;//1 踢下线  2封号

@end

NS_ASSUME_NONNULL_END
