//
//  PK10guanyahelistCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/23.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10guanyahelistCtrl.h"
#import "PK10TwofaceModel.h"
@interface PK10guanyahelistCtrl ()

@property (nonatomic, strong)UIView *headview;

@property (nonatomic, strong)NSMutableArray *btnArray;

@end

@implementation PK10guanyahelistCtrl

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
        NSArray *array = self.type == 3 ? @[@"类型",@"两面类型",@"已开期数"] : @[@"冠亚和",@"今日出现",@"当前遗漏"];
        UIButton *lastBtn = nil;
        for (int i = 0; i< array.count; i++) {
            
            UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:array[i] andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:IMAGE(@"期号不排序") andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [btn setTitleColor:BUTTONCOLOR forState:UIControlStateSelected];
            [btn setImagePosition:WPGraphicBtnTypeRight spacing:2];
            btn.tag = 100+i;
            btn.titleLabel.font = FONT(12);
            [self.btnArray addObject:btn];
            [_headview addSubview:btn];
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

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: self.tableView];
    
    if (self.type == 3) {
        
        self.titlestring = @"两面长龙";
        
        @weakify(self)
        [self buildTimeViewWithType:self.lottery_type With:nil With:^{
            @strongify(self)
            [self initData];
        }];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT + 34, 0, SAFE_HEIGHT, 0));
        }];
        
        [self initData];
    } else {
        
        [self hiddenavView];
        @weakify(self)
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.edges.equalTo(self.view);
        }];
        [self initData];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self addnotification];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self removenotification];
}
-(void)addnotification {
    
    if (self.lottery_type == 6) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_bjpks" object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_xyft" object:nil];
    }
    
}

-(void)removenotification {
    
    if (self.lottery_type == 6) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_bjpks" object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xyft" object:nil];
    }
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
    //这里先使用假数据
    UIView *view = [cell.contentView viewWithTag:100];
    
    PK10TwofaceModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    for (UILabel *label in view.subviews) {
        label.text = nil;
        if (label.tag == 200) {
            
            if (self.type == 3) {
                
                label.text = [model.key isEqualToString:@"@00"] ? @"冠亚和" : [model.key isEqualToString:@"@01"] ? @"冠军" : [model.key isEqualToString:@"@02"] ? @"亚军" : [model.key isEqualToString:@"@03"] ? @"第三名" : [model.key isEqualToString:@"@04"] ? @"第四名" : [model.key isEqualToString:@"@05"] ? @"第五名" : [model.key isEqualToString:@"@06"] ? @"第六名" : [model.key isEqualToString:@"@07"] ? @"第七名" : [model.key isEqualToString:@"@08"] ? @"第八名" : [model.key isEqualToString:@"@09"] ? @"第九名" : @"第十名";
            }
            else {
                if (self.type == 1) {
                    
                    label.text = model.num == 1 ? @"大" : model.num == 2 ? @"小" : model.num == 3 ? @"单" : @"双";
                }
                else{
                    label.text = INTTOSTRING(model.num);
                }
                
            }
        }
        else if (label.tag == 201) {
            
            label.text = self.type == 3 ? model.type : INTTOSTRING(model.open);
        }
        else {
            label.text = self.type == 3 ? INTTOSTRING(model.value) : INTTOSTRING(model.noOpen);
        }
        label.font = FONT(15);
        label.textColor = [UIColor darkGrayColor];
        label.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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

-(void)sortWithsender:(UIButton *)sender {
    
    if (sender.tag == 100) {
        
        if (self.type == 3) {
            
            NSSortDescriptor *numberSD = [NSSortDescriptor sortDescriptorWithKey:@"key" ascending:sender.selecttype == 1 ? YES : NO];
            
            self.dataArray = [self.dataArray sortedArrayUsingDescriptors:@[numberSD]];
        }
        else{
            NSSortDescriptor *numberSD = [NSSortDescriptor sortDescriptorWithKey:@"num" ascending:sender.selecttype == 1 ? YES : NO];
            
            self.dataArray = [self.dataArray sortedArrayUsingDescriptors:@[numberSD]];
        }
        
    }
    else if (sender.tag == 101) {
        
        if (self.type == 3) {
            
            NSSortDescriptor *numberSD = [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:sender.selecttype == 1 ? YES : NO];
            
            self.dataArray = [self.dataArray sortedArrayUsingDescriptors:@[numberSD]];
        }
        else{
            NSSortDescriptor *numberSD = [NSSortDescriptor sortDescriptorWithKey:@"open" ascending:sender.selecttype == 1 ? YES : NO];
            
            self.dataArray = [self.dataArray sortedArrayUsingDescriptors:@[numberSD]];
        }
    }
    else {
        
        if (self.type == 3) {
            
            NSSortDescriptor *numberSD = [NSSortDescriptor sortDescriptorWithKey:@"value" ascending:sender.selecttype == 1 ? YES : NO];
            
            self.dataArray = [self.dataArray sortedArrayUsingDescriptors:@[numberSD]];
        }
        else{
            NSSortDescriptor *numberSD = [NSSortDescriptor sortDescriptorWithKey:@"noOpen" ascending:sender.selecttype == 1 ? YES : NO];
            
            self.dataArray = [self.dataArray sortedArrayUsingDescriptors:@[numberSD]];
        }
    }
    
    [self.tableView reloadData];
}

-(void)initData {
    
    if (self.type == 3) {
        
        [self initliangmainchanglongData];
    }
    else{
        [self initguanyaheData];
    }
}

#pragma mark - 两面长龙数据
-(void)initliangmainchanglongData {
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/liangMianC.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/liangMianC.json";
    }
    else if (self.lottery_type == 11) {
        url = @"/azPrixSg/liangMianC.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(381)} success:^(BaseData *data) {
        @strongify(self)
        self.dataArray = [PK10TwofaceModel mj_objectArrayWithKeyValuesArray:data.data];
        
        for (PK10TwofaceModel *model in self.dataArray) {
            
            model.key = [NSString stringWithFormat:@"@%02ld",(long)model.key.integerValue];
        }
        
        [self typeClick:self.btnArray.firstObject];
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 冠亚和数据
-(void)initguanyaheData {
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/guanYaCount.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/guanYaCount.json";
    }    else if (self.lottery_type == 11) {
        url = @"/azPrixSg/guanYaCount.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:nil success:^(BaseData *data) {
        @strongify(self)
        NSDictionary *dic = data.data;
        
        NSArray *he = [dic valueForKey:@"he"];
        
        NSArray *lm = [dic valueForKey:@"lm"];
        
        if (self.type == 0) {
            
            self.dataArray = [PK10TwofaceModel mj_objectArrayWithKeyValuesArray:he];
        }
        else{
            self.dataArray = [PK10TwofaceModel mj_objectArrayWithKeyValuesArray:lm];
        }
        
        [self typeClick:self.btnArray.firstObject];
        
    } failure:^(NSError *error) {
        
    }];
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
