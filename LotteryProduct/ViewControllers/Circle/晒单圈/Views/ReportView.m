//
//  ReportView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/16.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ReportView.h"

@implementation ReportView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 44;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self);
        }];
        
        _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = 0.3;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.reprotData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RJCellIdentifier];
        
        UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
        lab.tag = 100;
        [cell addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(cell);
        }];
    }
    
    UILabel *lab = [cell viewWithTag:100];
    
    NSDictionary *dic = [self.reprotData objectAtIndex:indexPath.row];
    
    lab.text = dic[@"type"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectRortBlock) {
        
        self.selectRortBlock([self.reprotData objectAtIndex:indexPath.row]);
    }
    
    [self dismiss];
}

-(void)setReprotData:(NSArray *)reprotData {
    
    _reprotData = reprotData;
    
    [self.tableView reloadData];
}

-(void)dismiss {
    
    CGRect frame = self.frame;
    
    frame.size.height = 0;
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.frame = frame;
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        [_overlayView removeFromSuperview];
    }];
}

-(void)show {
    
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    
    [keywindw addSubview:_overlayView];
    
    [keywindw addSubview:self];
    
    CGRect frame = self.frame;
    
    frame.size.height = 44 * self.reprotData.count > SCREEN_HEIGHT * 0.8 ? SCREEN_HEIGHT * 0.8 : 44 * self.reprotData.count;
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.frame = frame;
        
        self.alpha = 1;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }];
}

@end
