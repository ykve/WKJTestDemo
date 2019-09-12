//
//  LastnumberCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "LastnumberCtrl.h"
#import "SixHelpCell.h"
#import "VersionsPickerView.h"
@interface LastnumberCtrl ()

@end

@implementation LastnumberCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.type == Weishudaxiao) {
        
        self.titlestring = @"尾数大小统计图";
    }
    else if (self.type == Jiaqinyeshou) {
        
        self.titlestring = @"家禽野兽统计图";
    }
    else if (self.type == Lianxiaozoushi) {
        
        self.titlestring = @"连肖走势图";
    }
    else{
        self.titlestring = @"连码走势图";
    }
    
    @weakify(self)
    [self rigBtn:[NSString stringWithFormat:@"%ld",[[NSDate date] getYear]] Withimage:@"玩法筛选" With:^(UIButton *sender) {
        
        VersionsPickerView *picker = [VersionsPickerView share];
        [picker setpicker];
        picker.onlyshowyear = YES;
        
        picker.VersionBlock = ^(NSString *time, NSString *version, NSString *url) {
            @strongify(self)
            [self.rightBtn setTitle:time forState:UIControlStateNormal];
            
            [self initData:time];
        };
        
        [picker show];
    }];
    [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.navView).offset(-8);
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.centerY.equalTo(self.titlelab);
    }];
    
    self.rightBtn.layer.cornerRadius = 4;
    self.rightBtn.layer.borderColor = WHITE.CGColor;
    self.rightBtn.layer.borderWidth = 1.0f;
    [self.rightBtn setImagePosition:WPGraphicBtnTypeRight spacing:3];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SixHelpCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.rowHeight = 25;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, SAFE_HEIGHT, 0));
    }];
    
    [self initData:[NSString stringWithFormat:@"%ld",[[NSDate date] getYear]]];
    
    //投注按钮
    [self buildBettingBtn];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor = [UIColor colorWithHex:@"dddddd"];

    SixHelpCell *cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SixHelpCell class]) owner:self options:nil]firstObject];
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    [view addSubview:cell];
    
    NSArray *titles = @[@"年份/期数",@"正一",@"正二",@"正三",@"正四",@"正五",@"正六",@"特码"];
    int i = 0;
    for (UILabel *lab in cell.numberlabs) {
        
        lab.text = titles[i];
        lab.backgroundColor = BASECOLOR;
        i++;
    }
    
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SixHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    NSArray *array = [self.dataSource objectAtIndex:indexPath.row];
    
    int i = 0;
    
    NSString *laststring = nil;
    
    for (Drawlab *lab in cell.numberlabs) {
        
        lab.backgroundColor = indexPath.row%2 == 0 ? WHITE : [UIColor groupTableViewBackgroundColor];
        
        NSString *string = array[i];
        
        if (i == 0) {
            
            lab.text = [NSString stringWithFormat:@"%@-%@",self.rightBtn.titleLabel.text,string];
        }
        else {
            
            lab.text = string;
            
            if (self.type == Weishudaxiao) {
                
                if ([string isEqualToString:@"大"]) {
                    
                    lab.textColor = [UIColor redColor];
                }
                else if ([string isEqualToString:@"小"]) {
                    
                    lab.textColor = kColor(70, 127, 172);
                }
            }
            else if (self.type == Lianmazoushi) {
                
                if (laststring) {
                    
                    if ((laststring.integerValue == string.integerValue + 1) || (laststring.integerValue == string.integerValue - 1)) {
                        
                        lab.bgColor = [UIColor redColor];
                        lab.showbg = YES;
                        lab.textColor = WHITE;
                        NSInteger index = [cell.numberlabs indexOfObject:lab];
                        
                        Drawlab *lastlab = [cell.numberlabs objectAtIndex:index-1];
                        
                        lastlab.bgColor = [UIColor redColor];
                        lastlab.showbg = YES;
                        lastlab.textColor = WHITE;
                    }
                    else {
                        lab.showbg = NO;
                        lab.textColor = YAHEI;
                    }
                }
                else {
                    lab.showbg = NO;
                    lab.textColor = YAHEI;
                }
                laststring = string;
            }
            else if (self.type == Lianxiaozoushi) {
                
                NSArray *zodiac = @[@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪"];
                
                if (laststring) {
                    
                    NSInteger zodiac_row = [zodiac indexOfObject:string];
                    
                    NSInteger zodiac_last_row = [zodiac indexOfObject:laststring];
                    
                    if ((zodiac_last_row == zodiac_row + 1) || (zodiac_last_row == zodiac_row - 1)) {
                        
                        lab.bgColor = [UIColor redColor];
                        lab.showbg = YES;
                        lab.textColor = WHITE;
                        NSInteger index = [cell.numberlabs indexOfObject:lab];
                        
                        Drawlab *lastlab = [cell.numberlabs objectAtIndex:index-1];
                        
                        lastlab.bgColor = [UIColor redColor];
                        lastlab.showbg = YES;
                        lastlab.textColor = WHITE;
                    }
                    else {
                        lab.showbg = NO;
                        lab.textColor = YAHEI;
                    }
                }
                else {
                    lab.showbg = NO;
                    lab.textColor = YAHEI;
                }
                laststring = string;
            }
            else {
                
                if ([string isEqualToString:@"野"]) {
                    
                    lab.textColor = [UIColor redColor];
                }
                else if ([string isEqualToString:@"家"]) {
                    
                    lab.textColor = kColor(70, 127, 172);
                }
            }
        }
        
        i++;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)initData:(NSString *)year {
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getInfoC.json" params:@{@"type":[NSString stringWithFormat:@"%u",self.type],@"year":year} success:^(BaseData *data) {
        @strongify(self)
        [self.dataSource removeAllObjects];
        
        NSArray *array = data.data;
        
        [self.dataSource addObjectsFromArray:array];
        
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
