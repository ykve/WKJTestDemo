//
//  CLGifLoadView.m
//  CLMJRefresh
//
//  Created by Charles on 15/12/18.
//  Copyright © 2015年 Charles. All rights reserved.
//


#import "CLGifLoadView.h"
#import "UIView+MJExtension.h"

@interface CLGifLoadView()
@property (weak, nonatomic) UIImageView *gifView;
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;

@property (strong, nonatomic) UILabel * stateLabel;

@property (strong, nonatomic) UIButton * btnRetry;

@property (nonatomic, strong) UIView *backView;


@end

@implementation CLGifLoadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self makeView];
    }
    return self;
}

-(void)layoutSubviews {
    
    self.gifView.center = self.center;
    self.stateLabel.frame = CGRectMake(0, CGRectGetMaxY(self.gifView.frame) + 10, self.bounds.size.width, 20);
}

- (void)makeView{
    // 设置普通状态的动画图片
    self.gifView = [self gifView];
    self.gifView.frame = CGRectMake(0,0, 214/2, 133/2);
    self.gifView.backgroundColor = [UIColor clearColor];
    self.gifView.center = self.center;
    
    self.stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.gifView.frame) + 10, self.bounds.size.width, 20)];
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.font = [UIFont systemFontOfSize:12.0f];
    self.stateLabel.textColor = [UIColor lightGrayColor];
    self.stateLabel.text = @"努力加载中...";
    [self addSubview:self.stateLabel];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_hud_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:CLLoadStateLoading];

    [self setState:CLLoadStateLoading];
}
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] init];
        gifView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_gifView = gifView];
    }
    return _gifView;
}

- (UIView *)backView{
    
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake((self.width - 150)/2, (self.height - 80)/2, 150, 80)];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((_backView.width - 20)/2, 5, 20, 20)];
        _backView.layer.cornerRadius = 9;
        _backView.layer.masksToBounds = YES;
        icon.image = IMAGE(@"icon_ljsb");
        [_backView addSubview:icon];
        
        _backView.backgroundColor = [UIColor colorWithHex:@"000000" Withalpha:0.8];
        
        UILabel *statleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame) + 5, self.backView.width, 12)];

        statleLbl.textAlignment = NSTextAlignmentCenter;
        statleLbl.text = @"咦?!网络连接失败了!";
        statleLbl.textColor = [UIColor lightGrayColor];
        statleLbl.font = [UIFont systemFontOfSize:12];
        [self.backView addSubview:statleLbl];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(statleLbl.frame) + 10, _backView.width, 1)];
        line.backgroundColor = [UIColor colorWithHex:@"494c53"];
        [_backView addSubview:line];
        
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        refreshBtn.frame = CGRectMake(0, CGRectGetMaxY(line.frame) + 5, _backView.width, _backView.height - line.y - 11);
        
        [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
        [refreshBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        refreshBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        refreshBtn.backgroundColor = [UIColor whiteColor];
        refreshBtn.layer.cornerRadius = 2.0f;
        refreshBtn.clipsToBounds = YES;
        refreshBtn.backgroundColor = CLEAR;
        [refreshBtn setTitleColor:[UIColor colorWithHex:@"eacd91"] forState:UIControlStateNormal];
        [refreshBtn addTarget:self action:@selector(btnRetry:) forControlEvents:UIControlEventTouchUpInside];

        
        [_backView addSubview:refreshBtn];
    }
    return _backView;
}

- (NSMutableDictionary *)stateImages
{
    if (!_stateImages) {
        self.stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateDurations
{
    if (!_stateDurations) {
        self.stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}

#pragma mark - 公共方法
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(CLLoadState)state
{
    if (images == nil) return;
    
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
    
    /* 根据图片设置控件的高度 */
    UIImage *image = [images firstObject];
    if (image.size.height > self.mj_h) {
        self.mj_h = image.size.height;
    }
}

- (void)setImages:(NSArray *)images forState:(CLLoadState)state
{
    [self setImages:images duration:0.5 forState:state];
}

#pragma mark - 实现父类的方法

- (void)placeSubviews
{
    
    self.gifView.frame = self.bounds;
    if (self.stateLabel.hidden) {
        self.gifView.contentMode = UIViewContentModeScaleAspectFit;
    } else {
        self.gifView.contentMode = UIViewContentModeScaleAspectFit;
        self.gifView.mj_w = self.mj_w * 0.5 - 90;
    }
}

- (void)setState:(CLLoadState)state
{
    // 根据状态做事情
    if (state == CLLoadStateLoading) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        [self.gifView stopAnimating];
        self.gifView.frame = CGRectMake(0,0, 214/2, 133/2);
        self.gifView.center = self.center;
        
        self.stateLabel.frame = CGRectMake(0, CGRectGetMaxY(self.gifView.frame) + 10, self.bounds.size.width, 20);
        if (self.loadstring){
            self.stateLabel.text = self.loadstring;
        }
        else{
            self.stateLabel.text = @"努力加载中...";
        }

        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
//        static BOOL isFirst = YES;
//        if (isFirst) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self setState:CLLoadStateFailed];
//            });
//            isFirst = NO;
//        }
//        else{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self setState:CLLoadStateFinish];
//            });
//        }
    }else if (state == CLLoadStateFinish){
        [self hide];
    }
    else if(state == CLLoadStateFailed){
        [self.gifView stopAnimating];
        
        [self.backView addSubview:self.gifView];
        
//        self.backView.backgroundColor = [UIColor redColor];
        [self addSubview:self.backView];
        
        self.gifView.image = [UIImage imageNamed:@"icon_ljsb"];
        self.gifView.frame = CGRectMake((self.backView.width - 20)/2, 9, 20, 20);
        self.gifView.backgroundColor = [UIColor redColor];
        self.gifView.center = self.center;
        self.stateLabel.frame = CGRectMake(0, CGRectGetMaxY(self.gifView.frame) + 5, self.backView.width, 20);
        self.stateLabel.textAlignment = NSTextAlignmentCenter;
        self.stateLabel.text = @"咦!网络连接失败了!";
        [self.backView addSubview:self.stateLabel];
        if (!self.btnRetry) {
            self.btnRetry = [UIButton buttonWithType:UIButtonTypeCustom];
            self.btnRetry.frame = CGRectMake(0, CGRectGetMaxY(self.stateLabel.frame) + 10, self.backView.frame.size.width, 30);
            [self.btnRetry setTitle:@"刷新" forState:UIControlStateNormal];
            [self.btnRetry setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            self.btnRetry.titleLabel.font = [UIFont systemFontOfSize:12.0f];
            self.btnRetry.backgroundColor = [UIColor whiteColor];
            self.btnRetry.layer.cornerRadius = 2.0f;
            self.btnRetry.clipsToBounds = YES;
            [self.btnRetry addTarget:self action:@selector(btnRetry:) forControlEvents:UIControlEventTouchUpInside];
            self.btnRetry.layer.borderWidth = .5f;
            self.btnRetry.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [self.backView addSubview:self.btnRetry];
        }
        else{
            self.btnRetry.frame = CGRectMake(0, CGRectGetMaxY(self.stateLabel.frame) + 10, self.backView.frame.size.width, 30);
            self.btnRetry.hidden = NO;
        }
    }
}
- (void)btnRetry:(UIButton *)sender{
    self.btnRetry.hidden = YES;
    
    @weakify(self)

    if ([NSThread currentThread] == [NSThread mainThread]) {
        
        if (self.retryBlcok){
            
            self.retryBlcok();
            
            [self hide];
        }
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            @strongify(self)

            if (self.retryBlcok){
                
                self.retryBlcok();
                
                [self hide];
            }
        });
        
    }

}


- (void)hide{
    
    if ([NSThread currentThread] == [NSThread mainThread]) {
        
        [self remove];
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self remove];
        });
        
    }
    
}

-(void)remove {
    
    @weakify(self)
    [UIView animateWithDuration:0.15 animations:^{
        @strongify(self)
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        @strongify(self)
        [self removeFromSuperview];
    }];
}
- (void)hide:(UIView *)view After:(NSTimeInterval)duration{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];

    });
}

-(void)setLoadstring:(NSString *)loadstring {
    
    _loadstring = loadstring;
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^(){
        @strongify(self)
        self.stateLabel.text = loadstring;
    });
    
}
@end
