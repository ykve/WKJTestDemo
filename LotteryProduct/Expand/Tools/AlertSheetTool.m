//
//  AlertSheetTool.m
//  AlertActiionDemo
//
//  Created by Max on 16/8/30.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#import "AlertSheetTool.h"

@implementation AlertSheetTool



+ (void)AlertSheetToolWithCancelTitle:(NSString *)cancelTitle otherItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(void(^)(NSInteger index))action;
{
     [AlertSheetTool initWithCancelTitle:cancelTitle otherItemArrays:array viewController:controller handler:action isShowCancel:NO];
}




+ (void)AlertSheetToolWithItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(void(^)(NSInteger index))action;
{
     [AlertSheetTool initWithCancelTitle:nil otherItemArrays:array viewController:controller handler:action isShowCancel:YES];
}



+ (void)initWithCancelTitle:(NSString *)cancelTitle otherItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(void(^)(NSInteger index))actionindex isShowCancel:(BOOL)isShowCancel
{
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        if (isShowCancel == NO) {
            
            UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (actionindex) {
                    actionindex(0);
                }
                [alertC dismissViewControllerAnimated:YES completion:nil];
            }];
            [cancelAction setValue:CC forKey:@"titleTextColor"];
            [alertC addAction:cancelAction];
            
        }
        
        
        if (![array isKindOfClass:[NSNull class]] && array != nil && array.count) {
            for (int i = 0; i < array.count; i++) {
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    if (isShowCancel) {
                        if (actionindex) {
                            actionindex(i);
                        }
                    }
                    else {
                        if (actionindex) {
                            actionindex(i+1);
                        }
                    }
                    

                    [alertC dismissViewControllerAnimated:YES completion:nil];
                }];
                
//                [otherAction setValue:CC forKey:@"titleTextColor"];
                [alertC addAction:otherAction];
            }
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
    

}



@end
