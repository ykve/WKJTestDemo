//
//  FormulaHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "FormulaHeadView.h"

@implementation FormulaHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.versionsBtn setImagePosition:WPGraphicBtnTypeRight spacing:3];
    
    NSArray *arr = @[@"sin\n公式",@"sec\n公式",@"cos\n公式",@"cot\n公式",@"tan\n公式"];
    
    int i = 0;
    for (UILabel *lab in self.titlelabs) {
        
        lab.text = arr[i];
        
        i ++;
    }
}

- (IBAction)versionClick:(UIButton *)sender {
    
    if (self.versionBlock) {
        
        self.versionBlock(sender);
    }
}


@end
