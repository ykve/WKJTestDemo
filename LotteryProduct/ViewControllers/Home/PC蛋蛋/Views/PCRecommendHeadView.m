//
//  PCRecommendHeadView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCRecommendHeadView.h"

@implementation PCRecommendHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setModel:(PCFreeRecommendModel *)model {
    
    _model = model;
    
    self.nexttime2lab.text = [model.lastRecommend.createTime componentsSeparatedByString:@" "].firstObject;
    self.nextversion2lab.text = model.lastRecommend.issue;
    
    self.fristrecommendlab.text = [NSString stringWithFormat:@"%@ %@ %@",model.lastRecommend.regionOneNumber,model.lastRecommend.regionOneSingle,model.lastRecommend.regionOneSize];
    self.secondrecommendlab.text = [NSString stringWithFormat:@"%@ %@ %@",model.lastRecommend.regionTwoNumber,model.lastRecommend.regionTwoSingle,model.lastRecommend.regionTwoSize];
    self.thirdrecommendlab.text = [NSString stringWithFormat:@"%@ %@ %@",model.lastRecommend.regionThreeNumber,model.lastRecommend.regionThreeSingle,model.lastRecommend.regionThreeSize];
    
}

@end
