//
//  ListNoticeView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListNoticeView : UIView
@property(strong,nonatomic) UILabel* titleLabel;
@property(strong,nonatomic) UITextView* textView;
@property(strong,nonatomic) NSMutableArray * models;

-(void)show;
-(void)uiSet;
-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
