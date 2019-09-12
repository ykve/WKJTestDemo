//
//  TouPiaoCommonView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/3/2.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "TouPiaoCommonView.h"
#import "TouPiaoModel.h"
#import "LiuHeTuKuProgressView.h"
#import "LoginAlertViewController.h"
#import "AppDelegate.h"

@interface TouPiaoCommonView()

@property (nonatomic, strong)UIButton *touPiaoBtn;
@property (nonatomic, strong)NSMutableArray *progressViewArray;


@end

@implementation TouPiaoCommonView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTouPiaoBtn)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setModelsArray:(NSArray *)modelsArray{
    _modelsArray = modelsArray;
    if (!self.topView) {
        UIView *topView = [[UIView alloc] init];
        self.topView = topView;
        [self addSubview:topView];
    }
    self.topView.frame = CGRectMake(0, 0, self.width, 25 * (modelsArray.count%2 ? modelsArray.count/2 : modelsArray.count/2 + 1));
    for (LiuHeTuKuProgressView *view in self.progressViewArray) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < self.modelsArray.count; i ++) {
        CGFloat h = 25;
        CGFloat margin = 5;
        CGFloat w = (self.width - margin)/2;
        CGFloat x = margin + (i % 2)*w;
        CGFloat y = h *( i/2);

        
        LiuHeTuKuProgressView *progressBackView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([LiuHeTuKuProgressView class]) owner:self options:nil]firstObject];

        
        [self.progressViewArray addObject:progressBackView];
        
        progressBackView.frame = CGRectMake(x, y , w, h);
        
        progressBackView.tag = i;
        
        [self.progressViewArray addObject:progressBackView];
        
        TouPiaoModel *model = self.modelsArray[i];
        
        if ([model.voteCount isEqualToString:@"0"]) {
            progressBackView.progressView.progress = 0;
        }else{
            progressBackView.progressView.progress = model.voteNum.floatValue/model.voteCount.floatValue;
        }
        progressBackView.titleLbl.text = model.name;
        progressBackView.piaoNumLbl.text = [NSString stringWithFormat:@"%@", model.voteNum];
        
        [self addSubview:progressBackView];
        
    }
    
    if (!self.touPiaoBtn) {
        UIButton *touPiaoBtn = [[UIButton alloc] init];
        self.touPiaoBtn = touPiaoBtn;
    }
    self.touPiaoBtn.frame = CGRectMake((self.width - 84)/2, CGRectGetMaxY(self.topView.frame), 90, 35);
    
    
    [self.touPiaoBtn setBackgroundImage:IMAGE(@"红色按钮") forState:UIControlStateNormal];
    [self.touPiaoBtn setTitle:@"投票" forState:UIControlStateNormal];
    self.touPiaoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.touPiaoBtn addTarget:self action:@selector(clickTouPiaoBtn) forControlEvents:UIControlEventTouchUpInside];
    
    if (modelsArray.count != 0) {
        [self addSubview:self.touPiaoBtn];
    }
  
    
    
}


- (void)clickTouPiaoBtn{
    
    if ([Person person].uid == nil) {

        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [[AppDelegate currentViewController] presentViewController:login animated:YES completion:nil];
        login.loginBlock = ^(BOOL result) {
            
        };
        return;
    }
    if ([self.delegate respondsToSelector:@selector(commonToupiao)]) {
        [self.delegate commonToupiao];
    }
}


- (NSMutableArray *)progressViewArray{
    if (!_progressViewArray) {
        _progressViewArray = [NSMutableArray arrayWithCapacity:6];
    }
    return _progressViewArray;
}
@end
