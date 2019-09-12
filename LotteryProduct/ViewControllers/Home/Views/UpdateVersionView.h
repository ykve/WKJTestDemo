//
//  UpdateVersionView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateVersionView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *updateBtn;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_const;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *title_height;


@property (copy, nonatomic) void (^updateBlock)(void);

@property (strong, nonatomic) UIControl *overlayView;

+(UpdateVersionView *)update ;

-(void)show;

-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
