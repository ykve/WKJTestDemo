//
//  SixPropertyCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/11.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixPropertyCtrl.h"
#import "SixPropertyCell.h"
#import "PropertyModel.h"
#import "ZodiacModel.h"
@interface SixPropertyCtrl ()

@property (nonatomic, strong) UISegmentedControl *segmentCtrl;

@property (nonatomic, strong) NSMutableArray *colorArray;

@property (nonatomic, strong) NSMutableArray *shengxiaoArray;

@property (nonatomic, strong) NSMutableArray *wuxingArray;

@property (nonatomic, strong) NSMutableArray *jiaqinArray;

@end

@implementation SixPropertyCtrl

-(NSMutableArray *)colorArray {
    
    if (!_colorArray) {
        
        _colorArray = [[NSMutableArray alloc]init];
    }
    return _colorArray;
}

-(NSMutableArray *)shengxiaoArray {
    
    if (!_shengxiaoArray) {
        
        _shengxiaoArray = [[NSMutableArray alloc]init];
    }
    return _shengxiaoArray;
}

-(NSMutableArray *)wuxingArray {
    
    if (!_wuxingArray) {
        
        _wuxingArray = [[NSMutableArray alloc]init];
    }
    return _wuxingArray;
}

-(NSMutableArray *)jiaqinArray {
    
    if (!_jiaqinArray) {
        
        _jiaqinArray = [[NSMutableArray alloc]init];
    }
    return _jiaqinArray;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titlestring = @"属性参照";
    
    self.segmentCtrl = [[UISegmentedControl alloc]initWithItems:@[@"波色",@"生肖",@"五行",@"家禽野兽"]];
    self.segmentCtrl.frame = CGRectMake(15, NAV_HEIGHT + 15, SCREEN_WIDTH - 30, 30);
    self.segmentCtrl.tintColor = LINECOLOR;
    self.segmentCtrl.selectedSegmentIndex = 0;
    [self.segmentCtrl addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentCtrl];
    [self segmentClick:self.segmentCtrl];
    
    [self.tableView registerClass:[SixPropertyCell class] forCellReuseIdentifier:RJCellIdentifier];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:RJHeaderIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT + 60, 0, 0, 0));
    }];
    
    [self initData];
    
    //投注按钮
    [self buildBettingBtn];
    
}

-(void)initData {
    
    NSArray *arr1 = @[@"红波",@"蓝波",@"绿波"];
    NSArray *arr4 = @[@"家禽",@"野兽"];
    
    for (NSString *str in arr1) {
        
        PropertyModel *model = [[PropertyModel alloc]init];
        model.title = str;
        if ([str isEqualToString:@"红波"]) {
            
            [model.listArray addObjectsFromArray:@[@"01",@"02",@"07",@"08",@"12",@"13",@"18",@"19",@"23",@"24",@"29",@"30",@"34",@"35",@"40",@"45",@"46"]];
        }
        else if ([str isEqualToString:@"蓝波"]) {
            
            [model.listArray addObjectsFromArray:@[@"03",@"04",@"09",@"10",@"14",@"15",@"20",@"25",@"26",@"31",@"36",@"37",@"41",@"42",@"47",@"48"]];
        }
        else {
            [model.listArray addObjectsFromArray:@[@"05",@"06",@"11",@"16",@"17",@"21",@"22",@"27",@"28",@"32",@"33",@"38",@"39",@"43",@"44",@"49"]];
        }
        
        [self.colorArray addObject:model];
    }
    
    ZodiacModel *zo = [[ZodiacModel alloc]init];
    
    NSArray *zoarr = [zo getnumber:nil];
    
    for (NSDictionary *dic in zoarr) {
        
        PropertyModel *model = [[PropertyModel alloc]init];
        model.title = dic[@"title"];
        [model.listArray addObjectsFromArray:dic[@"array"]];
        [self.shengxiaoArray addObject:model];
    }
    
    NSArray *wuxinarr = [Tools getwuxin];
    for (NSDictionary *dic in wuxinarr) {
        
        PropertyModel *model = [[PropertyModel alloc]init];
        model.title = dic[@"title"];
        [model.listArray addObjectsFromArray:dic[@"array"]];
        [self.wuxingArray addObject:model];
    }
    
    for (NSString *str in arr4) {
        
        PropertyModel *model = [[PropertyModel alloc]init];
        model.title = str;
        if ([str isEqualToString:@"家禽"]) {
            
            [model.listArray addObjectsFromArray:@[@"牛",@"马",@"羊",@"鸡",@"狗",@"猪"]];
        }
        else {
            
            [model.listArray addObjectsFromArray:@[@"鼠",@"虎",@"兔",@"龙",@"蛇",@"猴"]];
        }
        
        [self.jiaqinArray addObject:model];
    }
    
    [self.tableView reloadData];
}

-(void)segmentClick:(UISegmentedControl *)sender {
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (self.segmentCtrl.selectedSegmentIndex) {
        case 0:
            return self.colorArray.count;
            break;
        case 1:
            return self.shengxiaoArray.count;
            break;
        case 2:
            return self.wuxingArray.count;
            break;
        case 3:
            return self.jiaqinArray.count;
            break;
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PropertyModel *model = nil;
    
    if (self.segmentCtrl.selectedSegmentIndex == 0) {
        
        model = [self.colorArray objectAtIndex:indexPath.row];
        
        return model.listArray.count > 9 ? 150/SCAL : 80/SCAL;
    }
    else if (self.segmentCtrl.selectedSegmentIndex == 1) {
        
        model = [self.shengxiaoArray objectAtIndex:indexPath.row];
        
        return model.listArray.count > 9 ? 100/SCAL : 50/SCAL;
    }
    else if (self.segmentCtrl.selectedSegmentIndex == 2) {
        
        model = [self.wuxingArray objectAtIndex:indexPath.row];
        
        return model.listArray.count > 9 ? 100/SCAL : 50/SCAL;
    }
    else {
        return 50/SCAL;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.segmentCtrl.selectedSegmentIndex < 3) {
        
        SixPropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        PropertyModel *model = nil;
        
        if (self.segmentCtrl.selectedSegmentIndex == 0) {
            
            model = [self.colorArray objectAtIndex:indexPath.row];
      
        }
        else if (self.segmentCtrl.selectedSegmentIndex == 1) {
            
            model = [self.shengxiaoArray objectAtIndex:indexPath.row];
        }
        else if (self.segmentCtrl.selectedSegmentIndex == 2) {
            
            model = [self.wuxingArray objectAtIndex:indexPath.row];
        }
        
        cell.titlelab.text = model.title;
        
        cell.dataArray = model.listArray;
        
        cell.type = self.segmentCtrl.selectedSegmentIndex;
        
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJHeaderIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
        PropertyModel *model = [self.jiaqinArray objectAtIndex:indexPath.row];
        
        NSString *text = [NSString stringWithFormat:@"%@:%@",model.title,model.contentstring];
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:text];
        [attr addAttribute:NSForegroundColorAttributeName
                           value:LINECOLOR
                           range:NSMakeRange(model.title.length+1, model.contentstring.length)];
        cell.textLabel.attributedText = attr;
        cell.textLabel.font = FONT(14);
        return cell;
    }
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
