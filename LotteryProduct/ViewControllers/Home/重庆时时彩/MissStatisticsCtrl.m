//
//  MissStatisticsCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/4.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "MissStatisticsCtrl.h"
#import "ChongqinMissModel.h"
@interface MissStatisticsCtrl ()

@property (nonatomic, strong)UIView *headview;

@property (nonatomic, strong)NSMutableArray *btnArray;

@end

@implementation MissStatisticsCtrl

-(NSMutableArray *)btnArray {
    
    if (!_btnArray) {
        
        _btnArray = [[NSMutableArray alloc]init];
    }
    return _btnArray;
}

-(UIView *)headview {
    
    if(!_headview) {
        
        _headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 23)];
        _headview.backgroundColor = [UIColor colorWithHex:@"cccccc"];
        NSArray *array = @[@"号码",@"出现次数",@"当前遗漏"];
        UIButton *lastBtn = nil;
        for (int i = 0; i< array.count; i++) {
            
            UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:array[i] andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:IMAGE(@"期号不排序") andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [btn setTitleColor:BUTTONCOLOR forState:UIControlStateSelected];
            [btn setImagePosition:WPGraphicBtnTypeRight spacing:2];
            btn.tag = 100+i;
            btn.titleLabel.font = FONT(12);
            [_headview addSubview:btn];
            [self.btnArray addObject:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.bottom.equalTo(_headview);
                if (lastBtn) {
                    
                    make.left.equalTo(lastBtn.mas_right).offset(1);
                    make.width.equalTo(lastBtn);
                }else {
                    make.left.equalTo(_headview);
                }
                if (i == array.count-1) {
                    
                    make.right.equalTo(_headview);
                }
            }];
            
            lastBtn = btn;
        }
    }
    return _headview;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hiddenavView];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view);
    }];
    
    [self initData:[Tools getlocaletime]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headview;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RJCellIdentifier];
        
        UIView *v = [UIView viewWithLabelNumber:3 Withlabelwidth:CGSizeMake(SCREEN_WIDTH/3, 30)];
        v.tag = 100;
        [cell.contentView addSubview:v];
    }
    cell.backgroundColor = [UIColor colorWithHex:@"cccccc"];
    UIView *view = [cell.contentView viewWithTag:100];
    ChongqinMissModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    for (UILabel *label in view.subviews) {
        label.text = nil;
        label.text = label.tag == 200 ? INTTOSTRING(model.number) : label.tag == 201 ? INTTOSTRING(model.allCount) : INTTOSTRING(model.currCount);
        label.font = FONT(15);
        label.textColor = [UIColor darkGrayColor];
        label.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)initData:(NSString *)time {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getCqsscMissCount.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getXjsscMissCount.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getTxffcMissCount.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"date":time} success:^(BaseData *data) {
        @strongify(self)
        self.dataArray = [ChongqinMissModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)sortWithsender:(UIButton *)sender {
    
    if (sender.tag == 100) {
        
        NSSortDescriptor *numberSD = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:sender.selecttype == 1 ? YES : NO];
        
        self.dataArray = [self.dataArray sortedArrayUsingDescriptors:@[numberSD]];
    }
    else if (sender.tag == 101) {
        
        NSSortDescriptor *allSD = [NSSortDescriptor sortDescriptorWithKey:@"allCount" ascending:sender.selecttype == 1 ? YES : NO];
        
        self.dataArray = [self.dataArray sortedArrayUsingDescriptors:@[allSD]];
    }
    else {
        
        NSSortDescriptor *currSD = [NSSortDescriptor sortDescriptorWithKey:@"currCount" ascending:sender.selecttype == 1 ? YES : NO];
        
        self.dataArray = [self.dataArray sortedArrayUsingDescriptors:@[currSD]];
    }
    
    [self.tableView reloadData];
}


-(void)typeClick:(UIButton *)sender {
    
    for (UIButton *btn in self.btnArray) {
        
        if (btn != sender) {
            btn.selecttype = 0;
            [btn setImage:IMAGE(@"期号不排序") forState:UIControlStateNormal];
            btn.selected = NO;
        }
    }
    if (sender.selecttype == 0) {
        
        sender.selecttype = 1;
        [sender setImage:IMAGE(@"期号排序升") forState:UIControlStateNormal];
    }
    else if (sender.selecttype == 1) {
        
        sender.selecttype = 2;
        [sender setImage:IMAGE(@"期号排序降") forState:UIControlStateNormal];
    }
    else if (sender.selecttype == 2) {
        
        sender.selecttype = 1;
        [sender setImage:IMAGE(@"期号排序升") forState:UIControlStateNormal];
    }
    
    sender.selected = YES;
    [self sortWithsender:sender];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
