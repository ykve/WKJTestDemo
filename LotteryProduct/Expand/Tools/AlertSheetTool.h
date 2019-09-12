//
//  AlertSheetTool.h
//  AlertActiionDemo
//
//  Created by Max on 16/8/30.
//  Copyright © 2016年 maxzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//typedef void (^ActionBlockAtIndex)(NSInteger index);


@interface AlertSheetTool : NSObject


//@property (copy, nonatomic) ActionBlockAtIndex actionBlockAtIndex;

/**
 *  获取alertSheetController实例
 *
 *  @param cancelTitle      cancelTitle
 *  @param otherItemArrays  其它item的字符串数组
 *  @param controller       传入的controller
 *
 *  @return alertSheetController实例
 */
+ (void)AlertSheetToolWithCancelTitle:(NSString *)cancelTitle otherItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(void(^)(NSInteger index))action;



/**
 *  获取alertSheetController实例
 *
 *  @param ItemArrays  其它item的字符串数组
 *  @param controller  传入的controller
 *
 *  @return alertSheetController实例
 */
+ (void)AlertSheetToolWithItemArrays:(NSArray *)array viewController:(UIViewController *)controller handler:(void(^)(NSInteger index))action;





@end
