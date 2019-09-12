//
//  ChangeNicknameView.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/4/24.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginTextFeilds.h"
@protocol ChangeNicknameViewDelegate <NSObject>

-(void)changeNicknameSuccess;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ChangeNicknameView : UIView

@property (weak, nonatomic) IBOutlet LoginTextFeilds *nickTextfield;

@property (nonatomic, weak)id<ChangeNicknameViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
