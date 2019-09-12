//
//  AlertViewTool.m
//  AlertActiionDemo
//
//  Created by Max on 16/8/30.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#import "AlertViewTool.h"
#import <sys/utsname.h>


@implementation AlertViewTool


+ (id)alertViewToolShowMessage:(NSString *)message fromController:(UIViewController *)controller handler:(ActionBlock)block
{
    return [[self alloc] initWithTitle:nil message:message cancelTitle:@"确定" confiormTitle:nil fromController:controller handler:block showIndex:NO];
}




+ (id)alertViewToolShowTitle:(NSString *)title message:(NSString *)message fromController:(UIViewController *)controller handler:(ActionBlock)block
{
    return [[self alloc] initWithTitle:title message:message cancelTitle:@"确定" confiormTitle:nil fromController:controller handler:block showIndex:NO];
}


+ (void)alertShowTestInfo:(UIViewController *)vc{

    struct utsname systemInfo;uname(&systemInfo);

    NSString *iphoneName = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    [AlertViewTool alertViewToolShowTitle:@"提示" message:[NSString stringWithFormat:@"版本号:%@\n build号:%@\n 机型:%@\n 当前系统:%@", [Tools getnowVersion],[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],iphoneName,[UIDevice currentDevice].systemVersion] fromController:vc handler:nil];

}

+ (id)alertViewToolShowTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confiormTitle:(NSString *)confirmTitle fromController:(UIViewController *)controller handler:(ActionBlockAtIndex)block
{
    return [[self alloc] initWithTitle:title message:message cancelTitle:cancelTitle confiormTitle:confirmTitle fromController:controller handler:block showIndex:YES];
}





- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confiormTitle:(NSString *)confirmTitle fromController:(UIViewController *)controller handler:(id)sender showIndex:(BOOL)showIndex
{
    if ([self init]) {
        
        if (showIndex) {
            self.actionBlockAtIndex = sender;
        } else {
            self.actionBlock = sender;
        }
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        //取消按钮
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (showIndex == NO && self.actionBlock) {
                self.actionBlock();
            }
            
            if (showIndex && self.actionBlockAtIndex) {
                self.actionBlockAtIndex(0);
            }
            
            [alertC dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertC addAction:cancleAction];
        
        
        //确定按钮
        if (showIndex) {
            
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if (self.actionBlockAtIndex) {
                    self.actionBlockAtIndex(1);
                }
                
                [alertC dismissViewControllerAnimated:YES completion:nil];
            }];
//            [confirmAction setValue:BASECOLOR forKey:@"_titleTextColor"];
            [alertC addAction:confirmAction];
        }
        
        
        
        [controller presentViewController:alertC animated:YES completion:nil];
    }
    return self;
}


+(id)showalertWithArray:(NSArray *)titles fromController:(UIViewController *)controller handler:(ActionBlockAtIndex)block{
    
    return [[self alloc]showalertWithArray:titles fromController:controller handler:block];
}

-(instancetype)showalertWithArray:(NSArray *)titles fromController:(UIViewController *)controller handler:(ActionBlockAtIndex)block {
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    self.alertVC = alertC;
    
    for (int i = 0; i<titles.count; i++) {
        
        NSString *title = [titles objectAtIndex:i];
        
        UIAlertAction *alert = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            block(i);
            
            [alertC dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
        [alertC addAction:alert];
    }
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [controller presentViewController:alertC animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:alertC];
        [popup presentPopoverFromRect:CGRectMake(controller.view.frame.size.width/2, controller.view.frame.size.height/2, 0, 0)inView:controller.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [tap setNumberOfTapsRequired:1];
    tap.delegate = self;
    tap.cancelsTouchesInView = NO;
    UIView *v =  [UIApplication sharedApplication].keyWindow.subviews.lastObject;
    
    [v addGestureRecognizer:tap];
    
    return self;
}

-(void)tap:(UITapGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint location = [sender locationInView:nil];
        if (![self.alertVC.view pointInside:[self.alertVC.view convertPoint:location fromView:self.alertVC.view.window] withEvent:nil]){
            [self.alertVC.view.window removeGestureRecognizer:sender];
            [self.alertVC dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}



@end
