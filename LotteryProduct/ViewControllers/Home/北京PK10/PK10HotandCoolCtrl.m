//
//  PK10HotandCoolCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/22.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10HotandCoolCtrl.h"
#import "PK10HotCoolCell.h"
#import "PK10HotCoolModel.h"
@interface PK10HotandCoolCtrl ()

@property (nonatomic, strong)UIButton *numberBtn;

@property (nonatomic, strong)UIButton *showcountBtn;

@property (nonatomic, assign)NSInteger versions;

@end

@implementation PK10HotandCoolCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titlestring = @"冷热分析";
    
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        [alert buildPK10HotandCoolInfoView];
        [alert show];
    }];
    @weakify(self)
    [self buildTimeViewWithType:self.lottery_type With:nil With:^{
        @strongify(self)
        [self initData];
    }];
 
    [self.tableView registerClass:[PK10HotCoolCell class] forCellReuseIdentifier:RJCellIdentifier];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT+34, 0, SAFE_HEIGHT, 0));
    }];
    
    [self initData];
    
    //投注按钮
    [self buildBettingBtn];
    
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
    }
    else{
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 65;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
    head.backgroundColor = WHITE;
    [head addSubview:self.numberBtn];
    [head addSubview:self.showcountBtn];
    
    [self.numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(head).offset(12);
        make.top.equalTo(head).offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    @weakify(self)
    [self.showcountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(head).offset(-12);
        make.centerY.equalTo(self.numberBtn);
    }];
    
    NSArray *arr = @[@"名次",@"热",@"温",@"冷"];
    UILabel *lastlab = nil;
    for (int i = 0; i<4; i++) {
        
        UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:arr[i] andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:[UIColor groupTableViewBackgroundColor] andTextAlignment:1];
        [head addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.top.equalTo(self.numberBtn.mas_bottom).offset(5);
            make.bottom.equalTo(head);
            if (lastlab == nil) {
                make.left.equalTo(head);
                make.width.equalTo(@(SCREEN_WIDTH * 0.16));
            }
            else {
                
                make.left.equalTo(lastlab.mas_right).offset(1);
                if (i == 1 || i == 3) {
                    
                    make.width.equalTo(@(SCREEN_WIDTH * 0.24));
                }
                else if (i == 2) {
                    
                    make.width.equalTo(@(SCREEN_WIDTH * (1-0.16-0.24*2)));
                }
            }
        }];
        
        lastlab = lab;
    }
    
    return head;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PK10HotCoolCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    PK10HotCoolModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.title = model.number;
    
    cell.showcount = self.showcountBtn.selected;
    
    cell.hotArray = model.hotArray;
    
    cell.warmthArray = model.warmthArray;
    
    cell.coolArray = model.coolArray;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PK10HotCoolModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    if (model.hotArray.count < 5 && model.warmthArray.count < 5 && model.coolArray.count < 5) {
        
        return SCREEN_WIDTH / 15 + 15;
    }
    else if (model.hotArray.count > 8 || model.warmthArray.count > 8 || model.coolArray.count > 8) {
        
        return (SCREEN_WIDTH / 15 + 15) * 3;
    }
    else {
        return (SCREEN_WIDTH / 15 + 15) * 2;
    }
}

-(UIButton *)numberBtn {
    
    if (!_numberBtn) {
        
        _numberBtn = [Tools createButtonWithFrame:CGRectMake(0, 0, 80, 40) andTitle:@"近20期" andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:IMAGE(@"xialacaidang1") andTarget:self andAction:@selector(sortClick:) andType:UIButtonTypeCustom];
        _numberBtn.layer.cornerRadius = 5;
        _numberBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _numberBtn.layer.borderWidth = 1;
        [_numberBtn setImagePosition:WPGraphicBtnTypeRight spacing:2];
        _numberBtn.titleLabel.font = FONT(13);
    }
    return _numberBtn;
}

-(UIButton *)showcountBtn {
    
    if (!_showcountBtn) {
        
        _showcountBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"显示热/温/冷码出现次数" andTitleColor:YAHEI andBackgroundImage:nil andImage:IMAGE(@"hiddencount") andTarget:self andAction:@selector(showcountClick:) andType:UIButtonTypeCustom];
        [_showcountBtn setImage:IMAGE(@"showcount") forState:UIControlStateSelected];
        [_showcountBtn setImagePosition:WPGraphicBtnTypeLeft spacing:3];
    }
    return _showcountBtn;
}

-(void)sortClick:(UIButton *)sender {
    
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    [alert buildPK10HotandCoolDateViewWith:self.versions];
    @weakify(self)
    alert.selectindexBlock = ^(NSInteger index) {
        @strongify(self)
        self.versions = index;
        
        NSString *string = index == 0 ? @"近20期" : index == 1 ? @"近30期" : @"近50期";
        
        [sender setTitle:string forState:UIControlStateNormal];
        
        [self initData];
    };
    [alert show];
}

-(void)showcountClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    [self.tableView reloadData];
}

-(void)initData {
    
    NSArray *titles = @[@"冠",@"亚",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十"];
    
    NSString *issue = self.versions == 0 ? @"20" : self.versions == 1 ? @"30" : @"50";
    
    NSString *url = nil;
    if (self.lottery_type == 6) {
        
        url = @"/bjpksSg/lengRe.json";
    }
    else if (self.lottery_type == 7) {
        url = @"/xyftSg/lengRe.json";
    }
    else if (self.lottery_type == 11) {
        url = @"/azPrixSg/lengRe.json";
    }
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(351),@"issue":issue} success:^(BaseData *data) {
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *array = data.data;
        
        for (NSDictionary *dic in array) {
            
            PK10HotCoolModel *model = [[PK10HotCoolModel alloc]init];
            
            model.number = titles[[dic[@"type"]integerValue]-1];
            
            for (NSDictionary *values in dic[@"value"]) {
                
                if ([values[@"num"]integerValue] >= 4) {
                    
                    [model.hotArray addObject:values];
                }
                else if ([values[@"num"]integerValue] == 0) {
                    
                    [model.coolArray addObject:values];
                }
                else {
                    [model.warmthArray addObject:values];
                }
            }
            
            [self.dataSource addObject:model];
        }
        
        [self.tableView reloadData];
        
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
