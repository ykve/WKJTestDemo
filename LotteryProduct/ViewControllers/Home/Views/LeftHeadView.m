//
//  LeftHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "LeftHeadView.h"

@interface LeftHeadView()

@property (weak, nonatomic) IBOutlet UIView *topview;

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *numberLins;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIButton *chargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *getMoneyBtn;

@property (weak, nonatomic) IBOutlet UIButton *kfBtn;

@end

@implementation LeftHeadView


-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.topview.backgroundColor = CLEAR;
    self.backView.backgroundColor = [[CPTThemeConfig shareManager] leftBackViewImageColor];
    
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        self.topImageView.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_ThemeColorTwe];
    } else {
        self.topImageView.image = [[CPTThemeConfig shareManager] Left_VC_TopImage];
    }
    
    
    self.pricelab.hidden = [Person person].Information;
    self.pricelab.textColor = [[CPTThemeConfig shareManager] Mine_priceTextColor];
    
    for (UIView *line in self.numberLins) {
        [self.chargeBtn setImage:[[CPTThemeConfig shareManager] Left_VC_ChargeBtnImage] forState:UIControlStateNormal];
        [self.getMoneyBtn setImage:[[CPTThemeConfig shareManager] Left_VC_GetMoneyBtnImage] forState:UIControlStateNormal];
        [self.kfBtn setImage:[[CPTThemeConfig shareManager] Left_VC_KFBtnImage] forState:UIControlStateNormal];
        line.backgroundColor = [[CPTThemeConfig shareManager] LeftControllerLineColor];
    }
    

    for (UIButton *btn in self.numberBtns) {

        [btn setTitleColor:[[CPTThemeConfig shareManager] Left_VC_BtnTitleColor] forState:UIControlStateNormal];
        btn.backgroundColor = [[CPTThemeConfig shareManager] Left_VC_BtnBackgroundColor];
        
        [btn setImagePosition:WPGraphicBtnTypeTop spacing:10];
        
        if (btn.tag > 99 && btn.tag < 103) {
            
            [btn setImagePosition:WPGraphicBtnTypeTop spacing:10];

        }

    }
    
}

- (IBAction)addpriceClick:(UIButton *)sender {
    
    if (self.leftheadBlock) {
        
        self.leftheadBlock(sender.tag-100);
    }
}

- (IBAction)checkoutClick:(UIButton *)sender {
    
    if (self.leftheadBlock) {
        
        self.leftheadBlock(sender.tag-100);
    }
}

- (IBAction)kefuClick:(UIButton *)sender {
    
    if (self.leftheadBlock) {
        
        self.leftheadBlock(sender.tag-100);
    }
}



@end
