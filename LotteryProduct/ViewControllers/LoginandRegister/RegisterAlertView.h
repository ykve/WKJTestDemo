//
//  RegisterAlertView.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/4/23.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RegisterAlertViewdelegate <NSObject>

- (void)registersuccess;
- (void)registerToLogin;

@end

@interface RegisterAlertView : UIView

@property (weak, nonatomic) IBOutlet UITextField *nickTextField;

@property (nonatomic, copy) void (^loginBlock)(BOOL result);

@property (nonatomic, assign)NSInteger type;

@property (nonatomic, copy) NSString *openid;



@property (nonatomic, weak)id<RegisterAlertViewdelegate> delegate;


@end

NS_ASSUME_NONNULL_END
