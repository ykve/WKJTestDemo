//
//  AdView.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/10.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "AdView.h"
#import "AdCell.h"
#import "AdHongBaoCell.h"

@interface AdView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSUInteger _currentInder;
}
@property(nonatomic, strong)    UITableView *myTableV;

@end

@implementation AdView

- (void)loadTableView{
    _currentInder = 1;
    if(SCREEN_WIDTH <= 321){
        self.myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 101) style:UITableViewStylePlain];
    }else{
        self.myTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-75, 101) style:UITableViewStylePlain];
    }
    [self.myTableV  registerNib:[UINib nibWithNibName:NSStringFromClass([AdCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.myTableV  registerNib:[UINib nibWithNibName:NSStringFromClass([AdHongBaoCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RJCellIdentifierHB"];

    [self addSubview:self.myTableV ];
    self.myTableV .separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableV .backgroundColor = self.backgroundColor = CLEAR;
    self.myTableV .delegate = self;
    self.myTableV .dataSource = self;
    self.myTableV .pagingEnabled = YES;
    self.myTableV .scrollsToTop = NO;
    self.myTableV .scrollEnabled = NO;
}

- (void)reloadData{
    if(self.dataA.count>0){
        return;
    }
    switch (self.type) {
        case CPTADType_sy:
        {
            [self initADsData];
        }
            break;
        case CPTADType_hb:{
            [self initADHongBaosData];
            if(SCREEN_WIDTH <= 321){
                self.myTableV.frame = CGRectMake(0, 0, SCREEN_WIDTH-40, 26*5);
            }else{
                self.myTableV.frame = CGRectMake(0, 0, SCREEN_WIDTH-75, 26*5);
            }
        }
        default:
            break;
    }
}

-(void)startScroll{
    [[AppDelegate shareapp] startScrollByType:self.type target:self selector:@selector(timerFired)];
}

- (void)endScroll{
    [[AppDelegate shareapp] endScroll];
}

- (void)timerFired{
    
    if(self.dataA.count<3){
        return;
    }
    MBLog(@"999");

    if(self.type == CPTADType_hb){
        _currentInder = _currentInder+1;
    }else{
        _currentInder = _currentInder+1;
    }
    if(_currentInder >= self.dataA.count-1){
        _currentInder = 0;
        _myTableV.contentOffset = CGPointMake(0, 0);
        [self timerFired];
    }
    
    NSIndexPath * path = [NSIndexPath indexPathForRow:_currentInder inSection:0];
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        [self.myTableV  scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
    });
}

- (NSMutableArray *)dataA{
    if(!_dataA){
        _dataA = [NSMutableArray array];
    }
    return _dataA;
}

-(void)initADsData {
    
    @weakify(self)
    [WebTools postWithURL:@"/topline/list.json" params:nil success:^(BaseData *data) {
        
        @strongify(self)
        NSArray * ar = data.data[@"data"];
        if([ar isKindOfClass:[NSString class]]){
            return ;
        }
        [self.dataA removeAllObjects];
        NSInteger time = 1;
        if(ar.count>2){
            time = 100;
        }
        for(NSInteger i = 0;i<time;i++){
            [self.dataA addObjectsFromArray:ar];
        }
        [self.myTableV reloadData];
        [self startScroll];
    } failure:^(NSError *error) {
//        @strongify(self)
    } showHUD:NO];
}

-(void)initADHongBaosData {
    
    @weakify(self)
    [WebTools postWithURL:@"/activity/redEnvelopReceiveInfo.json" params:@{@"actId":self.atID} success:^(BaseData *data) {
        
        @strongify(self)
        NSArray * ar = data.data;
        if([ar isKindOfClass:[NSString class]]){
            return ;
        }
        [self.dataA removeAllObjects];
        NSInteger time = 1;
        if(ar.count>4){
            time = 100;
        }
        for(NSInteger i = 0;i<time;i++){
            [self.dataA addObjectsFromArray:ar];
        }
        [self.myTableV reloadData];
        [self startScroll];
    } failure:^(NSError *error) {
        //        @strongify(self)
    } showHUD:NO];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataA? self.dataA.count:0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.cellHeight;
}

//"id": 5,
//"recId": 31547,
//"referrer": "我跟你说很溜",
//"title": "扭扭捏捏 侬个刚度敢进来么的哈  阿拉团队很溜的",
//"content": "测试头条",


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.type) {
        case CPTADType_sy:
        {
            AdCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary * dic = self.dataA[indexPath.row];
            cell.titlelab1.text = dic[@"content"];
            cell.titlelab1.textColor = [[CPTThemeConfig shareManager] CO_Home_HeadlineLabelText];
            cell.line.backgroundColor = [[CPTThemeConfig shareManager] CO_Main_LineViewColor];
            cell.line.hidden = NO;
            return cell;
        }
            break;
        case CPTADType_hb:
        {
            AdHongBaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RJCellIdentifierHB"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSDictionary * dic = self.dataA[indexPath.row];
            cell.nameLa.text = dic[@"mebNickname"];
            NSString * mone = dic[@"receiveAmount"];
            
            cell.moneyLa.text = [NSString stringWithFormat:@"%.2f",[mone floatValue]];
            return cell;
        }
            break;
        default:
            break;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.type == CPTADType_sy)
    {
        if(self.clickCell){
            NSDictionary * dic = self.dataA[indexPath.row];
            NSNumber * actIntoPage = dic[@"recId"];
            self.clickCell([actIntoPage integerValue]);
        }
    }
}

@end
