//
//  SelectShowView.m
//  LotteryProduct
//
//  Created by pt c on 2019/7/6.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "SelectShowView.h"

@implementation SelectShowView
{
    NSArray *ids;
    NSMutableArray *names;
    NSInteger _currentIndex;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        names = [NSMutableArray array];
        [names addObject:@"全部"];
         ids = @[@"0",@(CPTBuyTicketType_SSC),@(CPTBuyTicketType_XJSSC),@(CPTBuyTicketType_TJSSC),@(CPTBuyTicketType_LiuHeCai),@(CPTBuyTicketType_PK10),@(CPTBuyTicketType_DaLetou),@(CPTBuyTicketType_PaiLie35),@(CPTBuyTicketType_HaiNanQiXingCai),@(CPTBuyTicketType_Shuangseqiu),@(CPTBuyTicketType_3D),@(CPTBuyTicketType_QiLecai)];
        for(int i=1;i<ids.count;i++){
            NSString *name = [[CPTBuyDataManager shareManager] changeTypeToString:[ids[i] integerValue]];
            [names addObject:name];
        }
        [self.tableView reloadData];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return names.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 300, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"999999"];
        [cell.contentView addSubview:line];
        
    }
    UIView *temp = [cell.contentView viewWithTag:123];
    if(temp){
        [temp removeFromSuperview];
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 44)];
    lab.textColor = [UIColor colorWithHex:@"999999"];
    lab.tag = 123;
    lab.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:lab];
    if(names.count>indexPath.row){
        lab.text = names[indexPath.row];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.index = indexPath.row;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}
- (IBAction)bgClick:(UIButton *)sender {
    if(self.clickClose){
        self.clickClose();
    }
}

- (IBAction)closeClick:(UIButton *)sender {
    if(self.clickClose){
        self.clickClose();
    }
}
- (IBAction)okClick:(UIButton *)sender {
    NSString *lotteryId = ids[_index];
    NSString *name = names[_index];
    if(self.clickOK){
        self.clickOK(lotteryId,name);
    }
}

@end
