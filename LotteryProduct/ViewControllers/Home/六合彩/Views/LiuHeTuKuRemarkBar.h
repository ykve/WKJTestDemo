//
//  LiuHeTuKuRemarkBar.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/21.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LiuHeTuKuRemarkBarDelegate <NSObject>

@optional
//获取评论内容
- (void)getRemarkText:(NSString *)msg;
//发送评论
- (void)sendRemarkText:(UIButton *)sender;


@end

@interface LiuHeTuKuRemarkBar : UIView

@property (nonatomic,weak) id<LiuHeTuKuRemarkBarDelegate> delegate;

@property (nonatomic, weak)UITextField *textField;


@end

NS_ASSUME_NONNULL_END
