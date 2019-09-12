//
//  CartSixHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CPTBuyCollectionHeadView.h"


@implementation CPTBuyCollectionHeadView

-(void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self.segment addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    self.segment.momentary = YES;
//    self.segment.tintColor = WHITE;
    self.lineView.backgroundColor = [[CPTThemeConfig shareManager] Buy_CollectionViewLine_C];
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        self.backgroundColor = CLEAR;
        self.segment.backgroundColor = CLEAR;
        self.segment.borderColor = self.segment.tintColor = [UIColor colorWithHex:@"999999"];//[UIColor colorWithHex:@"B1CDCB"];
        self.titleLabel.textColor = self.titleLabel2.textColor = [UIColor hexStringToColor:@"#333333"];
    }else{
        self.titleLabel.textColor = self.titleLabel2.textColor = [[CPTThemeConfig shareManager] Buy_CollectionHeadV_TitleC];
        self.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
    }
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(0.3);
    }];
}


- (IBAction)lookallClick:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:CPTSHOWINFO object:nil];
}
-(void)segmentAction:(UISegmentedControl *)seg{
    NSInteger index = seg.selectedSegmentIndex;
    if(self.segmentClick){
        self.segmentClick(index);
    }
}

@end
