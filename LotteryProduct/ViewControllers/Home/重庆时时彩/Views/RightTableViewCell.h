//
//  RightTableViewCell.h
//  doubleTableView
//
//  Created by tarena13 on 15/10/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfLabels:(NSInteger)number Withsize:(CGSize)size;

+ (instancetype)cellWithTableView:(UITableView *)tableView WithNumberOfDrawlabs:(NSInteger)num Withsize:(CGSize)size;

-(void)updateViewWithNumberOfDrawlabs:(NSInteger)num Withsize:(CGSize)size;

@end
