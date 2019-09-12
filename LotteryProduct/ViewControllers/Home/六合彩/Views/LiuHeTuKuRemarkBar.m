//
//  LiuHeTuKuRemarkBar.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/21.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeTuKuRemarkBar.h"

@interface LiuHeTuKuRemarkBar()<UITextFieldDelegate>

@end

@implementation LiuHeTuKuRemarkBar

- (instancetype)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    
    self.backgroundColor = [[CPTThemeConfig shareManager] LiuheTuKuRemarkBarBackgroundColor];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 9, self.frame.size.width - 90, self.frame.size.height - 20)];
//    textField.backgroundColor = [UIColor whiteColor];
    textField.backgroundColor = [[CPTThemeConfig shareManager] LHTKTextfieldBackgroundColor];
    textField.placeholder = @" 请输入评论内容,25字以内";
    textField.layer.cornerRadius = 6;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [[CPTThemeConfig shareManager] LHTKRemarkTextFeildBorderColor].CGColor;
    textField.layer.borderWidth = 1;
    self.textField = textField;
    textField.font = [UIFont systemFontOfSize:14];
    textField.delegate = self;
    [textField addTarget:self action:@selector(textVauleDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:textField];
    
    
    UIButton *senderBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, 14, 60, 30)];
    [senderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [senderBtn setTitle:@"评论" forState: UIControlStateNormal];
    senderBtn.layer.cornerRadius = 6;
    senderBtn.layer.masksToBounds = YES;
    senderBtn.backgroundColor = [[CPTThemeConfig shareManager] LiuheTuKuRemarkSendBackgroundColor];
    [senderBtn setTitleColor:WHITE forState:UIControlStateNormal];
    [senderBtn addTarget:self action:@selector(didClickSenderBtn:) forControlEvents:UIControlEventTouchUpInside];
    senderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:senderBtn];
    return self;
}


- (void)textVauleDidChanged:(UITextField *)textfield{
    
    
    if ([self.delegate respondsToSelector:@selector(getRemarkText:)]) {
        
        if (textfield.text.length > 25) {
            textfield.text = [textfield.text substringToIndex:25];
        }
        [self.delegate getRemarkText:textfield.text];
        
    }
}

- (void)didClickSenderBtn : (UIButton *)sender{
    [self.delegate sendRemarkText:sender];
}

@end
