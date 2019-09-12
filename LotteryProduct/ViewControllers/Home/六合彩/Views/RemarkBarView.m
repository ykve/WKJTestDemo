//
//  RemarkBarView.m
//  HappyChat
//
//  Created by 研发中心 on 2018/11/24.
//  Copyright © 2018 研发中心. All rights reserved.
//

#import "RemarkBarView.h"
#import "LoginAlertViewController.h"
#import "AppDelegate.h"

@interface RemarkBarView()<UITextFieldDelegate>

@end

@implementation RemarkBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self  = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor blackColor];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, self.frame.size.width - 60, self.frame.size.height - 10)];
    textField.backgroundColor = [UIColor whiteColor];

    textField.placeholder = @"您的评论";
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.layer.borderWidth = 1;
    self.textField = textField;
    textField.delegate = self;
    [textField addTarget:self action:@selector(textVauleDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [textField becomeFirstResponder];

    [self addSubview:textField];


//    UIButton *emtionBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 45, 10, 35, 30)];
//    [emtionBtn setTitle:@"表情" forState: UIControlStateNormal];
//    [emtionBtn addTarget:self action:@selector(didClickEmtionBtn) forControlEvents:UIControlEventTouchUpInside];
//    emtionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//
//    [self addSubview:emtionBtn];

    UIButton *senderBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 45, 10, 35, 30)];
    [senderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [senderBtn setTitle:@"发送" forState: UIControlStateNormal];
    [senderBtn addTarget:self action:@selector(didClickSenderBtn:) forControlEvents:UIControlEventTouchUpInside];
    senderBtn.titleLabel.font = [UIFont systemFontOfSize:13];

    [self addSubview:senderBtn];
        return self;
}

- (void)didClickEmtionBtn{
    

}

- (void)textVauleDidChanged:(UITextField *)textfield{
    
    if ([self.delegate respondsToSelector:@selector(getRemarkText:)]) {
        [self.delegate getRemarkText:textfield.text];
    }
}

- (void)didClickSenderBtn:(UIButton *)sender{

    [self.delegate sendRemarkText:sender];
}


@end
