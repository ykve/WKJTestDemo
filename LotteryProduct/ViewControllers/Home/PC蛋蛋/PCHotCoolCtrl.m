//
//  PCHotCoolCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PCHotCoolCtrl.h"
#import "HotCell.h"
#import "PCResultModel.h"
@interface PCHotCoolCtrl ()

@property (nonatomic, strong)UIView *headview;

@property (nonatomic, strong)UIButton *currentBlockBtn, *currentTypeBtn;

@property (nonatomic, strong)NSArray *curentArray;

@end

@implementation PCHotCoolCtrl
- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hiddenavView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.rowHeight = 30;
    [self.view addSubview:self.tableView];
    
    [self initData];
}

-(UIView *)headview {
    
    if(!_headview) {
        
        _headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        _headview.backgroundColor = [UIColor colorWithHex:@"cccccc"];
        
        UIView *blockview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        blockview.backgroundColor = WHITE;
        [_headview addSubview:blockview];
        NSArray *blockarr = @[@"第一区",@"第二区",@"第三区"];
        
        for (int i = 0; i< blockarr.count; i++) {
            
            CGFloat w = (SCREEN_WIDTH - 12 * 4)/3;
            CGFloat h = 25;
            
            UIButton *btn = [Tools createButtonWithFrame:CGRectMake(12+(12+w)*i, 7.5, w, h) andTitle:blockarr[i] andTitleColor:LINECOLOR andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(blockClick:) andType:UIButtonTypeCustom];
            [blockview addSubview:btn];
            btn.layer.cornerRadius = 5;
            btn.tag = 100+i;
            btn.layer.borderColor = LINECOLOR.CGColor;
            btn.layer.borderWidth = 1;
            if (i == 0) {
                
                self.currentBlockBtn = btn;
            }
        }
        
        NSArray *array = @[@"号码",@"近10期",@"近30期",@"50期",@"100期"];
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
                make.top.equalTo(blockview.mas_bottom);
                make.bottom.equalTo(_headview);
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
            if (i == 0) {
                
                self.currentTypeBtn = btn;
            }
            lastBtn = btn;
        }
        
        [self blockClick:self.currentBlockBtn];
        [self typeClick:self.currentTypeBtn];
    }
    return _headview;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.curentArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 65;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headview;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HotCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    int i = 0;
    
    PCResultModel *model = [self.curentArray objectAtIndex:indexPath.row];
    
    for (UIButton *btn in cell.contentView.subviews) {
        
        if ([btn isKindOfClass:[UIButton class]]) {
            
            btn.backgroundColor = indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor groupTableViewBackgroundColor];
            
            if (btn.tag == 100) {
            
                [btn setImage:nil forState:UIControlStateNormal];
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
            
            switch (i) {
                case 0:
                    [btn setTitle:model.number forState:UIControlStateNormal];
                    break;
                case 1:
                    [btn setTitle:INTTOSTRING(model.before10) forState:UIControlStateNormal];
                    break;
                case 2:
                    [btn setTitle:INTTOSTRING(model.before30) forState:UIControlStateNormal];
                    break;
                case 3:
                    [btn setTitle:INTTOSTRING(model.before50) forState:UIControlStateNormal];
                    break;
                case 4:
                    [btn setTitle:INTTOSTRING(model.before100) forState:UIControlStateNormal];
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
    
    self.currentTypeBtn.selected = NO;
    
    sender.selected = YES;
    
    self.currentTypeBtn = sender;
}

-(void)blockClick:(UIButton *)sender {
    
    self.currentBlockBtn.backgroundColor = CLEAR;
    [self.currentBlockBtn setTitleColor:LINECOLOR forState:UIControlStateNormal];
    
    sender.backgroundColor = LINECOLOR;
    [sender setTitleColor:WHITE forState:UIControlStateNormal];
    self.currentBlockBtn = sender;
    
    if (_curentArray) {
        
        self.curentArray = [self.dataSource objectAtIndex:sender.tag - 100];
    }
    
    
    [self.tableView reloadData];
}

-(void)initData {
    
    @weakify(self)
    
    [WebTools postWithURL:@"/pceggSg/getColdHot.json" params:nil success:^(BaseData *data) {
        
        @strongify(self)
        
        NSDictionary *dic = data.data;
        
        [self.dataSource removeAllObjects];
        
        NSArray *array1 = [PCResultModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:@"coldHotList1"]];
        
        NSArray *array2 = [PCResultModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:@"coldHotList2"]];
        
        NSArray *array3 = [PCResultModel mj_objectArrayWithKeyValuesArray:[dic valueForKey:@"coldHotList3"]];
        
        [self.dataSource addObject:array1];
        
        [self.dataSource addObject:array2];
        
        [self.dataSource addObject:array3];
        
        self.curentArray = self.dataSource.firstObject;
        
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
