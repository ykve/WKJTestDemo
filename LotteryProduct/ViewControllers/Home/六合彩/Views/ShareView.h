//
//  ShareView.h
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

@property (weak, nonatomic) IBOutlet UIButton *weichatBtn;
@property (weak, nonatomic) IBOutlet UIButton *friendBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;

@property (strong, nonatomic) UIControl *overlayView;

+(ShareView *)share;

-(void)show;

@end
