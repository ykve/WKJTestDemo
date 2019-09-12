//
//  XinShuiRecommentTopResultVeiw.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "XinShuiRecommentTopResultVeiw.h"

@interface XinShuiRecommentTopResultVeiw()


@end

@implementation XinShuiRecommentTopResultVeiw

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//    self.backView.backgroundColor = CLEAR;
//    self.backgroundColor = CLEAR;
    [self addGestureRecognizer:tap];
//    self.dateLbl.textColor = [UIColor hexStringToColor:@"dddddd"];
}

- (void)tapAction{
    if ([self.delegate respondsToSelector:@selector(skipToHistoryVc)]) {
        [self.delegate skipToHistoryVc];
    }
}


- (IBAction)controlResultView:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(IsShowResultView:)]) {
        [self.delegate IsShowResultView:sender];
    }
    
}


@end
