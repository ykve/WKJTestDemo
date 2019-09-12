//
//  BigorSmallHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BigorSmallHeadView.h"

@interface BigorSmallHeadView ()
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

@end

@implementation BigorSmallHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    self.firstBtn.backgroundColor =[[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor];
}

- (IBAction)numberClick:(UIButton *)sender {
    
    for (UIButton *btn in self.numberBtns) {
        
        btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [btn setTitleColor:YAHEI forState:UIControlStateNormal];
    }
    sender.backgroundColor = [[CPTThemeConfig shareManager] pushDanSubBarSelectTextColor];
    [sender setTitleColor:WHITE forState:UIControlStateNormal];
    
    if (self.selectnumberBlock) {
        
        self.selectnumberBlock(sender.tag-100);
    }
}


@end
