//
//  HotCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/1.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "HotCtrl.h"
#import "HotCell.h"
#import "ChongqinHotModel.h"
@interface HotCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIView *headview;

@end

@implementation HotCtrl

-(UIView *)headview {
    
    if(!_headview) {
        
        _headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 23)];
        _headview.backgroundColor = [UIColor colorWithHex:@"cccccc"];
        NSArray *array = @[@"号码",@"30期",@"50期",@"100期",@"遗漏"];
        UIButton *lastBtn = nil;
        for (int i = 0; i< array.count; i++) {
            
            UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:array[i] andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:IMAGE(@"期号排序升") andTarget:self andAction:@selector(typeClick:) andType:UIButtonTypeCustom];
            btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [btn setImage:IMAGE(@"期号排序降") forState:UIControlStateSelected];
            [btn setImagePosition:WPGraphicBtnTypeRight spacing:2];
            btn.tag = 100+i;
            btn.titleLabel.font = FONT(12);
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self hiddenavView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
    [self initData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 23;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headview;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    ChongqinHotModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    int i = 0;
    
    for (UIButton *btn in cell.contentView.subviews) {
        
        if ([btn isKindOfClass:[UIButton class]]) {
            
            btn.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
            
            switch (i) {
                case 0:
                    [btn setTitle:model.num forState:UIControlStateNormal];
                    break;
                case 1:
                    [btn setTitle:INTTOSTRING(model.thirtynum) forState:UIControlStateNormal];
                    break;
                case 2:
                    [btn setTitle:INTTOSTRING(model.fiftynum) forState:UIControlStateNormal];
                    break;
                case 3:
                    [btn setTitle:INTTOSTRING(model.hundrednum) forState:UIControlStateNormal];
                    break;
                case 4:
                    [btn setTitle:INTTOSTRING(model.missnum) forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
            i++;
        }
        
    }
    
    
    
    return cell;
}


-(void)typeClick:(UIButton *)sender {
    
    
}

-(void)initData {
    
    [WebTools postWithURL:@"/cqsscSg/lishiD.json" params:@{@"type":@(104)} success:^(BaseData *data) {
        
        NSArray *array = data.data;
        
        for (NSDictionary *dic in array) {
            
            ChongqinHotModel *model = [[ChongqinHotModel alloc]init];
            model.num = dic[@"type"];
            model.thirtynum = [dic[@"value"][0]integerValue];
            model.fiftynum  = [dic[@"value"][1]integerValue];
            model.hundrednum= [dic[@"value"][2]integerValue];
            model.missnum   = [dic[@"value"][3]integerValue];
            
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
