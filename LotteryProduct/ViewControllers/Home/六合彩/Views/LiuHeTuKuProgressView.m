//
//  LiuHeTuKuProgressView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/22.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeTuKuProgressView.h"

@interface LiuHeTuKuProgressView ()

@property (nonatomic, strong) NSMutableArray *progressArray;
@property (nonatomic, strong) NSMutableArray *leftLblArray;
@property (nonatomic, strong) NSMutableArray *rightLblArray;

@end

@implementation LiuHeTuKuProgressView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.progressView.tintColor = [[CPTThemeConfig shareManager] LiuheTuKuProgressValueColor];
}


- (NSMutableArray *)progressArray{
    if (!_progressArray) {
        _progressArray = [NSMutableArray arrayWithCapacity:12];
    }
    return _progressArray;
}

- (NSMutableArray *)leftLblArray{
    if (!_leftLblArray) {
        _leftLblArray = [NSMutableArray arrayWithCapacity:12];
    }
    return _leftLblArray;
}

- (NSMutableArray *)rightLblArray{
    if (!_rightLblArray) {
        _rightLblArray = [NSMutableArray arrayWithCapacity:12];
    }
    return _rightLblArray;
}

@end
