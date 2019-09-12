//
//  MineRootVC.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/20.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "MineRootVC.h"

@interface MineRootVC ()
{
    UIImageView *_noDataImageView;
}

@end

@implementation MineRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showNoDataImageView{
    if(!_noDataImageView){
        _noDataImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 152)];
        _noDataImageView.image = IMAGE(@"noDataImageView");
        _noDataImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_noDataImageView];
        _noDataImageView.center = self.view.center;
    }
}
- (void)hiddenNoDataImageView{
    if(_noDataImageView){
        [_noDataImageView removeFromSuperview];
    }
}

@end
