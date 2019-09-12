//
//  HomeADCollectionViewCell.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/11/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeADCollectionViewCell.h"
#import "TYCyclePagerView.h"

@interface HomeADCollectionViewCell ()

@end

@implementation HomeADCollectionViewCell

- (TYCyclePagerView *)pagerView{
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc]init];
        _pagerView.isInfiniteLoop = YES;
        _pagerView.autoScrollInterval = 5.0;
        _pagerView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_ADCollectionViewCell_Back];
    }
    
    return _pagerView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    //    self.contentView.backgroundColor = [[CPTThemeConfig shareManager] CO_Home_VC_ADCollectionViewCell_Back];

    [self.pagerView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.contentView addSubview:self.pagerView];
    _pagerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentView.height - 0);
    
    CGSize size = CGSizeMake(CGRectGetWidth(self.pagerView.frame)*0.88, CGRectGetHeight(self.pagerView.frame)*0.8);
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - size.width/2, _pagerView.height/2 - size.height/2, size.width, size.height)];
    icon.layer.cornerRadius = 5;
    icon.layer.masksToBounds = YES;
    icon.tag = 100;
    icon.image = IMAGE(@"adHoldplace");
    [self.pagerView addSubview:icon];
    
}

@end
