//
//  HomeCollectionviewFooter.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/11/7.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HomeCollectionviewFooter.h"

@interface HomeCollectionviewFooter()

@property (weak, nonatomic) IBOutlet UIImageView *adImageView;


@end
@implementation HomeCollectionviewFooter

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor =  kColor(49, 50, 55);
    self.adImageView.layer.cornerRadius = 3;
    self.adImageView.layer.masksToBounds = YES;
}

@end
