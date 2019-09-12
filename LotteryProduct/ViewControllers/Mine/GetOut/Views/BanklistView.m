//
//  BanklistView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/10.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "BanklistView.h"

@implementation BanklistView

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
        
        self.backgroundColor = WHITE;
        
        _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _overlayView.backgroundColor = [UIColor clearColor];
        _overlayView.alpha = 0.3;
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:RJCellIdentifier];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self);
        }];
    }
    
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.banklist.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    BankModel *model = [self.banklist objectAtIndex:indexPath.row];
    
    NSString *title = [NSString stringWithFormat:@"%@%@",model.bank,[model.cardNumber stringByReplacingOccurrencesOfString:[model.cardNumber substringToIndex:model.cardNumber.length-4] withString:@"*** **** ***"]];
    
    cell.textLabel.text = title;
    
    cell.textLabel.font = FONT(14);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectbankBlock) {
        
        self.selectbankBlock([self.banklist objectAtIndex:indexPath.row]);
    }
    
    [self dismiss];
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

-(void)show:(NSArray *)array {
    
    self.banklist = [array copy];
    
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    
    [keywindw addSubview:_overlayView];
    
    [keywindw addSubview:self];
    
    CGRect frame = self.frame;
    
    frame.size.height = 44 * array.count;
    
    [UIView animateWithDuration:0.35 animations:^{
        
        self.frame = frame;
        
        [self.tableView layoutIfNeeded];
        
        
        
    } completion:^(BOOL finished) {
        
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }];
}
@end
