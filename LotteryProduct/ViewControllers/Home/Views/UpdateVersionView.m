//
//  UpdateVersionView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "UpdateVersionView.h"

@implementation UpdateVersionView

-(void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = CLEAR;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor = [UIColor blackColor];
    _overlayView.alpha = 0.3;
    
//    if (SCREEN_WIDTH < 375) {
//        
//        self.title_height.constant = 45;
//    }
//    else {
//        self.title_height.constant = 67;
//    }
}


+(UpdateVersionView *)update{
    
    UpdateVersionView *version = [[[NSBundle mainBundle]loadNibNamed:@"UpdateVersionView" owner:self options:nil]firstObject];
    
    
    version.frame = CGRectMake(30, -(SCREEN_WIDTH - 60) * 1.714, (SCREEN_WIDTH - 60), (SCREEN_WIDTH - 60)*1.714);
    
    return version;
}

-(void)show{
    
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    
    [keywindw addSubview:self.overlayView];
    [keywindw addSubview:self];
    
    CGRect frame = self.frame;
    
    frame.origin.y = keywindw.center.y - frame.size.height/2;
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.frame = frame;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)dismiss{

    CGRect frame = self.frame;
    
    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.frame = frame;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        [self.overlayView removeFromSuperview];
    }];
}


- (IBAction)cancel:(UIButton *)sender {
    
    [self dismiss];
}

- (IBAction)updateView:(id)sender {
    
    if (self.updateBlock) {

        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:@"请回到桌面查看安装进度"];
        });

        self.updateBlock();
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
