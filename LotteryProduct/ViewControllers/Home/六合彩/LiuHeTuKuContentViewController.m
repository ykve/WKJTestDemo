//
//  LiuHeTuKuContentViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiuHeTuKuContentViewController.h"

@interface LiuHeTuKuContentViewController ()

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation LiuHeTuKuContentViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

}

#pragma mark setupUI
- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    
    self.imageView.image = NOPHOTO;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, self.view.width - 20, 340)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;

    }
    return _imageView;
}


@end
