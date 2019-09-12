//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+WD.h"

@implementation MBProgressHUD (WD)
+(void)ShowWDMessage:(NSString*)message{
    UIWindow* view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    hud.margin = 20.f;
    hud.detailsLabelColor = [UIColor whiteColor];
//    hud.backgroundColor = BLACK;
//    hud.color = WHITE;
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1.5秒之后再消失
    [hud hide:YES afterDelay:1.5];
   
}

+(void)ShowLongMessage:(NSString *)message{
    
    UIView* view = [UIApplication sharedApplication].keyWindow;;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    hud.margin = 20.f;
    hud.detailsLabelText = message;
    hud.detailsLabelColor = [UIColor whiteColor];
//    hud.backgroundColor = BLACK;
//    hud.color = WHITE;
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 4秒之后再消失
    [hud hide:YES afterDelay:4];
}

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view duration:(CGFloat)duration
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.backgroundColor = BLACK;
    hud.labelText = text;
    hud.labelColor = [UIColor whiteColor];
//    hud.color = WHITE;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:duration];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    
    if (view == nil) {
        
          view = [UIApplication sharedApplication].keyWindow;
    }
    [self show:error icon:@"error.png" view:view duration:1.5];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    if (view == nil) {
        
        view = [UIApplication sharedApplication].keyWindow;
    }
    [self show:success icon:@"success.png" view:view duration:1.5];
}
+ (void)showSuccess:(NSString *)success toView:(UIView *)view duration:(CGFloat)duration
{
    [self show:success icon:@"success.png" view:view duration:duration];
}
+ (void)showError:(NSString *)error toView:(UIView *)view duration:(CGFloat)duration{
    [self show:error icon:@"error.png" view:view duration:duration];
}
#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.backgroundColor = BLACK;
    hud.labelText = message;
    hud.labelColor = [UIColor whiteColor];
//    hud.color = WHITE;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.5];
    
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    if ([NSThread currentThread] == [NSThread mainThread]) {
        
        [self showSuccess:success toView:nil];
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self showSuccess:success toView:nil];
        });
        
    }
    
}

+ (void)showError:(NSString *)error
{
    if ([NSThread currentThread] == [NSThread mainThread]) {
        
        [self showError:error toView:nil];
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self showError:error toView:nil];
        });
        
    }
}

+(void)showSuccess:(NSString *)success finish:(void (^)(void))finish {
    
    if ([NSThread currentThread] == [NSThread mainThread]) {
        
        [self showstring:success Withicon:@"success.png" finish:finish];
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self showstring:success Withicon:@"success.png" finish:finish];
        });
        
    }
    
    
}

+(void)showError:(NSString *)error finish:(void (^)(void))finish {
    
    if ([NSThread currentThread] == [NSThread mainThread]) {
        
        [self showstring:error Withicon:@"error.png" finish:finish];
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self showstring:error Withicon:@"error.png" finish:finish];
        });
        
    }
    
    
}

+(void)showstring:(NSString *)text Withicon:(NSString *)icon finish:(void(^)(void))finish {
    
    UIView *view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.backgroundColor = BLACK;
    hud.detailsLabelText = text;
    hud.detailsLabelColor = [UIColor whiteColor];
//    hud.color = WHITE;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.5];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        finish();
    });
}

+ (void)showSuccess:(NSString *)success duration:(CGFloat)duration
{
    [self showSuccess:success toView:nil duration:duration];
    
}

+ (void)showError:(NSString *)error duration:(CGFloat)duration
{
    [self showError:error toView:nil duration:duration];
}
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    
    
    [self hideHUDForView:nil];
}
@end
