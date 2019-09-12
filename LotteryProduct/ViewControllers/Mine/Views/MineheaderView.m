//
//  MineheaderView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "MineheaderView.h"

@implementation MineheaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = [UIColor colorWithHex:@"303136"];
   
//    if ([Person person].Information) {
//        
//        self.namelab.hidden = YES;
//        self.invitelab.hidden = YES;
//        self.pricelab.hidden = YES;
//    }
}

+ (CGFloat)headerViewHeight {
    
    CGFloat imageH = [UIScreen mainScreen].bounds.size.width * (367 / 750.0);
    
    return imageH + 64;
}
@end
