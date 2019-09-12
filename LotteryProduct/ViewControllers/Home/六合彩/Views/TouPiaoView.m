//
//  TouPiaoView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/20.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "TouPiaoView.h"
#import "LiuHeTuKuShareView.h"
#import "TouPiaoModel.h"
#import "TouPiaoCommonView.h"

@interface TouPiaoView ()<TouPiaoCommonViewDelegate>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong)LiuHeTuKuShareView *shareView;

@property (nonatomic, strong)UIButton *touPiaoBtn;



@end

@implementation TouPiaoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];

}

- (void)setModelsArray:(NSArray *)modelsArray{
    _modelsArray = modelsArray;
    
    TouPiaoCommonView *commonView = [[TouPiaoCommonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45 + 25 * (modelsArray.count%2 ? modelsArray.count/2 : modelsArray.count/2 + 1))];
    
    commonView.delegate = self;
    
    commonView.modelsArray = modelsArray;
    
    [self addSubview:commonView];

    
    [self addSubview:self.shareView];
    
   
    self.shareView.frame = CGRectMake(0, CGRectGetMaxY(commonView.frame) + 20, self.width, 140);
    
    UIView *remarkView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shareView.frame), SCREEN_WIDTH, 45)];
    UILabel *remarkLbl = [[UILabel alloc] initWithFrame:remarkView.bounds];
    
    [remarkView addSubview:remarkLbl];
    remarkLbl.text = @"评论区";
    remarkView.backgroundColor = [UIColor colorWithHex:@"EFEEF3"];
    remarkLbl.textColor = [UIColor darkGrayColor];
    remarkLbl.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:remarkView];
}
- (void)commonToupiao{
    if ([self.delegate respondsToSelector:@selector(toupiao)]) {
        [self.delegate toupiao];
    }
}


- (LiuHeTuKuShareView *)shareView{
    if (!_shareView) {
        _shareView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LiuHeTuKuShareView class]) owner:self options:nil]firstObject];
        _shareView.frame = CGRectMake(0, CGRectGetMaxY(self.touPiaoBtn.frame) + 20, self.width, 140);
        //        _shareView.delegate = self;
    }
    
    return _shareView;
}

@end
