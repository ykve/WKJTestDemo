//
//  CartCQBpanHeaderVeiw.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/1/13.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CartCQBpanHeaderVeiw.h"

@interface CartCQBpanHeaderVeiw ()
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet UIView *contentBackView;
@property (weak, nonatomic) IBOutlet UIButton *showMoreBtn;

@end

@implementation CartCQBpanHeaderVeiw

- (void)awakeFromNib{
    [super awakeFromNib];
    self.topBackView.backgroundColor = [UIColor colorWithHex:@"f6d79e"];

    self.contentBackView.backgroundColor = [UIColor colorWithHex:@"f6eBce"];
    self.showMoreBtn.backgroundColor = [UIColor colorWithHex:@"f6eBce"];
}

- (IBAction)clickLookMoreBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(lookHistoryData:)]) {
        [self.delegate lookHistoryData:sender];
    }
   
}

- (IBAction)skipToChargeVc:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(ChargeController)]) {
        [self.delegate ChargeController];
    }
}


- (IBAction)lookAllAction:(UIButton *)sender {
    if (self.lookallBlock) {
        
        self.lookallBlock();
    }
}


@end
