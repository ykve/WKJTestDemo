//
//  ForgetPsdalertView.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/4/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ForgetPsdalertViewDelegate <NSObject>

- (void)skipToRegisterVc;

@end

@interface ForgetPsdalertView : UIView

@property (weak, nonatomic) IBOutlet UITextField *accountTextfield;

@property (nonatomic, weak)id<ForgetPsdalertViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
