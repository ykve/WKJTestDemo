//
//  RightTableViewCell.m
//  doubleTableView
//
//  Created by tarena13 on 15/10/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "RightTableViewCell.h"

@implementation RightTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number Withsize:(CGSize)size
{
    static NSString *identifier = @"cell";
    // 1.缓存中取
    RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
         cell = [[RightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        UIView *view = [UIView viewWithLabelNumber:number Withlabelwidth:size];
        view.tag = 100;
        [cell.contentView addSubview:view];

    }
    return cell;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfDrawlabs:(NSInteger)num Withsize:(CGSize)size {
    
    static NSString *identifier = @"cell";
    // 1.缓存中取
    RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 2.创建
    if (cell == nil) {
        cell = [[RightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        
        UIView *view = [UIView viewWithDrawlabNumber:num WithDrawlabwidth:size];
        view.tag = 100;
        [cell.contentView addSubview:view];
        
    }
    return cell;
}

-(void)updateViewWithNumberOfDrawlabs:(NSInteger)num Withsize:(CGSize)size {
    
    UIView *view = [self.contentView viewWithTag:100];
    
    [view removeFromSuperview];
    
    UIView *newview = [UIView viewWithDrawlabNumber:num WithDrawlabwidth:size];
    newview.tag = 100;
    [self.contentView addSubview:newview];

}
@end
