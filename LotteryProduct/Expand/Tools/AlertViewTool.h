//
//  AlertViewTool.h
//  AlertActiionDemo
//
//  Created by Max on 16/8/30.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^ActionBlock)(void);
typedef void (^ActionBlockAtIndex)(NSInteger index);

@interface AlertViewTool : NSObject<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIAlertController *alertVC;
@property (nonatomic, copy) ActionBlock actionBlock;
@property (nonatomic, copy) ActionBlockAtIndex actionBlockAtIndex;


/**
 *  alertController初始化
 *
 *  @param message     message
 *  @param controller  当前的controller
 *  
 *
 *  @return alertController实例
 */
+ (id)alertViewToolShowMessage:(NSString *)message fromController:(UIViewController *)controller handler:(ActionBlock)block;




/**
 *  alertController初始化
 *
 *  @param title       title
 *  @param message     message
 *  @param controller  当前的controller
 *
 *
 *  @return alertController实例化
 */
+ (id)alertViewToolShowTitle:(NSString *)title message:(NSString *)message fromController:(UIViewController *)controller handler:(ActionBlock)block;




/**
 *  alertController初始化
 *
 *  @param title          title
 *  @param message        message
 *  @param cancelTitle    cancelTitle, index为0
 *  @param confirmTitle   confirmTitle, index为1
 *  @param controller     当前的controller
 *
 *
 *  @return alertController实例化
 */
+ (id)alertViewToolShowTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confiormTitle:(NSString *)confirmTitle fromController:(UIViewController *)controller handler:(ActionBlockAtIndex)block;


/**
 无标题弹窗
 */
+(id)showalertWithArray:(NSArray *)titles fromController:(UIViewController *)controller handler:(ActionBlockAtIndex)block;

/**
 *展示调试信息
 */
+ (void)alertShowTestInfo:(UIViewController *)vc;


@end
