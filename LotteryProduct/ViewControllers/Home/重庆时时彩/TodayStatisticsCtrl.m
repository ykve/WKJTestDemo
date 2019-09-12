//
//  TodayStatisticsCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "TodayStatisticsCtrl.h"
#import "TodayOneCell.h"
#import "TodayTwoCell.h"
#import "TodayThreeCell.h"
#import "ChongqinTodayModel.h"

@interface TodayStatisticsCtrl ()

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger totalcount;

@property (nonatomic, strong) NSDictionary *setdic;

@end

@implementation TodayStatisticsCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titlestring = @"今日统计";
    
    [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] WFSMImage] With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        [alert buildtodayInfoView];
        [alert show];
    }];
    
    UIButton *setBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE([[CPTThemeConfig shareManager] IC_Nav_Setting_Gear]) andTarget:self andAction:@selector(setClick) andType:UIButtonTypeCustom];
    [self.navView addSubview:setBtn];
    
    @weakify(self)
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.rightBtn.mas_left).offset(-8);
        make.size.mas_equalTo(CGSizeMake(43, 43));
        make.centerY.equalTo(self.rightBtn);
    }];
    
    [self buildTimeViewWithType:self.lottery_type With:^(UIButton *sender) {
        
        ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
        
        [alert builddateView:^(NSString *date) {
            @strongify(self)
            [sender setTitle:date forState:UIControlStateNormal];
            
            self.time = date;
            
            [self initData];
        }];
        [alert show];
    } With:^{
        @strongify(self)
        [self initData];
    }];
    
    UIImage *imgv1 = [Tools createImageWithColor:[UIColor lightGrayColor] Withsize:CGSizeMake(4, 4)];
    UIImage *imgv2 = [Tools createImageWithColor:[UIColor darkGrayColor] Withsize:CGSizeMake(4, 4)];
    
    UIButton *btn1 = [Tools createButtonWithFrame:CGRectZero andTitle:@"未开次数" andTitleColor:[UIColor lightGrayColor] andBackgroundImage:nil andImage:imgv1 andTarget:self andAction:@selector(lightGrayColor) andType:UIButtonTypeCustom];
    btn1.titleLabel.font = FONT(10);
    UIButton *btn2 = [Tools createButtonWithFrame:CGRectZero andTitle:@"已开次数" andTitleColor:[UIColor darkGrayColor] andBackgroundImage:nil andImage:imgv2 andTarget:self andAction:@selector(darkGrayColor) andType:UIButtonTypeCustom];
    btn2.titleLabel.font = FONT(10);
    [self.selectdateView addSubview:btn1];
    [self.selectdateView addSubview:btn2];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.selectdateView).offset(4);
        make.left.equalTo(self.selectdateView).offset(8);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.selectdateView).offset(-4);
         make.left.equalTo(self.selectdateView).offset(8);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TodayOneCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TodayTwoCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJHeaderIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TodayThreeCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJFooterIdentifier];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT+34, 0, SAFE_HEIGHT, 0));
    }];
    
    self.time = [Tools getlocaletime];
    
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
    
    switch (self.lottery_type) {
        case 1:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_cqssc" object:nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_xjssc" object:nil];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initData) name:@"kj_txffc" object:nil];
            break;
        default:
            
            break;
    }
    
    
}

-(void)removenotification {
    
    switch (self.lottery_type) {
        case 1:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_cqssc" object:nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xjssc" object:nil];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_txffc" object:nil];
            break;
        default:
            
            break;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section < 2) {
        
        return 39;
    }
    else {
        return 30;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section < 2) {
        
        return 10;
    }
    else if (section == 2) {
        
        return 2;
    }
    else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        NSArray *array = @[@"号码",@"第一球",@"第二球",@"第三球",@"第四球",@"第五球"];
        UIView *v1 = [UIView viewWithLabelNumber:6 Withlabelwidth:CGSizeMake(SCREEN_WIDTH/6, 40)];
        v1.backgroundColor = [UIColor colorWithHex:@"cccccc"];
        NSInteger index = 0;
        for (UILabel *lab in v1.subviews) {
            
            lab.text = array[index];
            lab.font = FONT(13);
            lab.textColor = [UIColor darkGrayColor];
            lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
            index ++;
        }
        
        return v1;
    }
    else {
        NSArray *array = @[@"开奖号码出现次数统计",@"三星玩法形态",@"二星玩法形态"];
        UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        v2.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:array[section-1] andfont:FONT(13) andTitleColor:[UIColor darkGrayColor] andBackgroundColor:CLEAR andTextAlignment:0];
        [v2 addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(v2).offset(12);
            make.centerY.equalTo(v2);
        }];
        
        return v2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        TodayOneCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
        
        cell.numberlab.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *array = [self.dataSource objectAtIndex:indexPath.section];
        
        ChongqinTodayModel *model = [array objectAtIndex:indexPath.row];
        
        for (int i = 0; i< model.unopenArray.count; i++) {
            
            UILabel *unreadlab = cell.unreadlabs[i];
            UILabel *readlab = cell.readlabs[i];
            unreadlab.text = [NSString stringWithFormat:@"%@",model.unopenArray[i]];
            readlab.text   = [NSString stringWithFormat:@"%@",model.openArray[i]];
            
            if (self.setdic) {
                
                unreadlab.backgroundColor = WHITE;
                
                if (self.setdic[@"y_color"]) {
                    
                    NSInteger y_min = [self.setdic[@"y_min"]integerValue];
                    NSInteger y_max = [self.setdic[@"y_max"]integerValue];
                    if ([model.unopenArray[i]integerValue] >= y_min && [model.unopenArray[i]integerValue] <= y_max) {
                        
                        unreadlab.backgroundColor = [UIColor colorWithHex:self.setdic[@"y_color"]];
                    }
                    
                }
                if (self.setdic[@"o_color"]) {
                    
                    NSInteger y_min = [self.setdic[@"o_min"]integerValue];
                    NSInteger y_max = [self.setdic[@"o_max"]integerValue];
                    if ([model.unopenArray[i]integerValue] >= y_min && [model.unopenArray[i]integerValue] <= y_max) {
                        
                        unreadlab.backgroundColor = [UIColor colorWithHex:self.setdic[@"o_color"]];
                    }
                }
                if (self.setdic[@"b_color"]) {
                    
                    NSInteger y_min = [self.setdic[@"b_min"]integerValue];
                    NSInteger y_max = [self.setdic[@"b_max"]integerValue];
                    if ([model.unopenArray[i]integerValue] >= y_min && [model.unopenArray[i]integerValue] <= y_max) {
                        
                        unreadlab.backgroundColor = [UIColor colorWithHex:self.setdic[@"b_color"]];
                    }
                }
            }
            else{
                unreadlab.backgroundColor = WHITE;
            }
        }
        
        return cell;
    }
    else if (indexPath.section == 1) {
        
        TodayTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:RJHeaderIdentifier];
        
        cell.numberlab.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *array = [self.dataSource objectAtIndex:indexPath.section];
        
        NSNumber *number = [array objectAtIndex:indexPath.row];
        
        cell.countlab.text = [NSString stringWithFormat:@"%ld次",number.integerValue];
        
        if (self.totalcount == 0) {
            
            cell.progressview.progress = 0;
            
            return cell;
        }
        CGFloat progress = (CGFloat)number.integerValue/self.totalcount;
        
        cell.progressview.progress = progress;
        
        return cell;
    }
    else  if (indexPath.section == 2){
        
        TodayThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:RJFooterIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *array = [self.dataSource objectAtIndex:indexPath.section];
        
        if (indexPath.row == 0) {
            
            NSString *str1 = [NSString stringWithFormat:@"组六形态：%@",array[0]];
            NSString *str2 = [NSString stringWithFormat:@"豹子形态：%@",array[1]];
            
            NSMutableAttributedString *attrstr1 = [[NSMutableAttributedString alloc] initWithString:str1];
            //设置文字颜色
            [attrstr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, str1.length-5)];
            
            NSMutableAttributedString *attrstr2 = [[NSMutableAttributedString alloc] initWithString:str2];
            //设置文字颜色
            [attrstr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, str2.length-5)];
            
            cell.status1lab.attributedText = attrstr1;
            cell.status2lab.attributedText = attrstr2;
            cell.status2lab.hidden = NO;
        }
        else if (indexPath.row == 1) {
            
            NSString *str3 = [NSString stringWithFormat:@"组三形态：%@",array[2]];
            
            NSMutableAttributedString *attrstr3 = [[NSMutableAttributedString alloc] initWithString:str3];
            //设置文字颜色
            [attrstr3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, str3.length-5)];
            
            cell.status1lab.attributedText = attrstr3;
            
            cell.status2lab.hidden = YES;
        }
        return cell;
    }
    else {
        
        TodayThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:RJFooterIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *array = [self.dataSource objectAtIndex:indexPath.section];
        
        NSString *str1 = [NSString stringWithFormat:@"对子形态：%@",array[0]];
        NSString *str2 = [NSString stringWithFormat:@"连号形态：%@",array[1]];
        
        NSMutableAttributedString *attrstr1 = [[NSMutableAttributedString alloc] initWithString:str1];
        //设置文字颜色
        [attrstr1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, str1.length-5)];
        
        NSMutableAttributedString *attrstr2 = [[NSMutableAttributedString alloc] initWithString:str2];
        //设置文字颜色
        [attrstr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, str2.length-5)];
        
        cell.status1lab.attributedText = attrstr1;
        cell.status2lab.attributedText = attrstr2;
        cell.status2lab.hidden = NO;
        
        return cell;
    }
   
}

-(void)setClick {
    
    ShowAlertView *alert = [[ShowAlertView alloc]initWithFrame:CGRectZero];
    
    @weakify(self)
    [alert buildtodaysetWithtype:1 WithView:^(NSDictionary *dic ) {
        @strongify(self)
        NSInteger type = [[dic valueForKey:@"type"] integerValue];
        
        if (type == 0) {
            
            self.setdic = nil;
        }
        else {
            
            self.setdic = dic;
        }
        
        [self.tableView reloadData];
    }];
    [alert show];
}

-(void)initData {
    
    NSString *url = nil;
    if (self.lottery_type == 1) {
        
        url = @"/cqsscSg/getInfoA.json";
    }
    else if (self.lottery_type == 2) {
        url = @"/xjsscSg/getInfoA.json";
    }else if (self.lottery_type == 3) {
        url = @"/txffcSg/getInfoA.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@(131),@"date":self.time} success:^(BaseData *data) {
        
        @strongify(self)
        NSDictionary *dic = data.data;
       
        [self.dataSource removeAllObjects];
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        NSArray *list = [dic valueForKey:@"list"];
        
        for (NSDictionary *dic in list) {
            
            ChongqinTodayModel *model = [[ChongqinTodayModel alloc]init];
            model.unopenArray = dic[@"noOpen"];
            model.openArray = dic[@"open"];
            [array addObject:model];
        }
        
        ChongqinTodayModel *model = array.firstObject;
        
        self.totalcount = [model.unopenArray.firstObject integerValue] + [model.openArray.firstObject integerValue];
        
        NSArray *numtotal = dic[@"numTotal"];
        NSArray *sanxing = dic[@"sanxing"];
        NSArray *erxing = dic[@"erxing"];
        
        [self.dataSource addObject:array];
        [self.dataSource addObject:numtotal];
        [self.dataSource addObject:sanxing];
        [self.dataSource addObject:erxing];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
