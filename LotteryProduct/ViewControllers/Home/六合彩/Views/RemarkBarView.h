//
//  RemarkBarView.h
//  HappyChat
//
//  Created by 研发中心 on 2018/11/24.
//  Copyright © 2018 研发中心. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RemarkBarViewDelegate <NSObject>

@optional
//获取评论内容
- (void)getRemarkText:(NSString *)msg;
//发送评论
- (void)sendRemarkText:(UIButton *)sender;
//添加表情
- (void)addEmotions;

@end

@interface RemarkBarView : UIView

@property (nonatomic,weak) id<RemarkBarViewDelegate> delegate;

@property (nonatomic, weak)UITextField *textField;


@end

NS_ASSUME_NONNULL_END
