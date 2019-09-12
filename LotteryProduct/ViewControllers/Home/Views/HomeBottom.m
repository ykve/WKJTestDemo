//
//  HomeADCollectionViewCell.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/11/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeBottom.h"

@interface HomeBottom ()

@property (weak, nonatomic) IBOutlet UIButton *lxkfBtn;
@property (weak, nonatomic) IBOutlet UIButton *ltsBtn;
@property (weak, nonatomic) IBOutlet UIButton *versionBtn;

@end

@implementation HomeBottom

- (void)awakeFromNib {
    [super awakeFromNib];
    self.footView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_CellContentView];
    [self.lxkfBtn setImage:[[CPTThemeConfig shareManager] IM_Home_BottomBtnOne] forState:UIControlStateNormal];
    [self.ltsBtn setImage:[[CPTThemeConfig shareManager] IM_Home_BottomBtnTwo] forState:UIControlStateNormal];
    [self.versionBtn setImage:[[CPTThemeConfig shareManager] IM_Home_BottomBtnThree] forState:UIControlStateNormal];
    
}

- (IBAction)clickKeFu{
    if([self.delegate respondsToSelector:@selector(clickKeFu)]){
        [self.delegate clickKeFu];
    }
}
- (IBAction)clickChatF{
    if([self.delegate respondsToSelector:@selector(clickChatF)]){
        [self.delegate clickChatF];
    }
}
- (IBAction)clicWebVersion{
    if([self.delegate respondsToSelector:@selector(clicWebVersion)]){
        [self.delegate clicWebVersion];
    }
}


@end
