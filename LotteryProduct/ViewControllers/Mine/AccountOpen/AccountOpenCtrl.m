//
//  AccountOpenCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/20.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "AccountOpenCtrl.h"
#import "AccountLinkView.h"
#import "AccountFootView.h"
#import "LinkManageModel.h"
@interface AccountOpenCtrl ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (strong, nonatomic) AccountLinkView *linkView;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *linkArray;

@end

@implementation AccountOpenCtrl

-(NSMutableArray *)linkArray {
    
    if (!_linkArray) {
        
        _linkArray = [[NSMutableArray alloc]init];
    }
    return _linkArray;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self.segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    
    self.linkView = [[[NSBundle mainBundle]loadNibNamed:@"AccountLinkView" owner:self options:nil]firstObject];
    
    [self.scrollView addSubview:self.linkView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
    [self.scrollView addSubview:self.tableView];
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    
    self.scrollView.delegate = self;
    
    for (int i = 0; i< 3; i++) {
        
        LinkManageModel *model = [[LinkManageModel alloc]init];
        model.url = @"http://www.baidu.com";
        model.edit = NO;
        [self.linkArray addObject:model];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.linkArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    LinkManageModel *model = [self.linkArray objectAtIndex:section];
    
    return model.edit == NO ? 0 : 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    AccountFootView *foot = [[[NSBundle mainBundle]loadNibNamed:@"AccountFootView" owner:self options:nil]firstObject];
    
    LinkManageModel *model = [self.linkArray objectAtIndex:section];
    
    foot.selectFootBlock = ^(NSInteger index) {
        
        if (index == 0) { //复制
            
            
        }
        else if (index == 1) { //撤销
            
            
        }
        else{ // 二维码
            
        }
        
        model.edit = NO;
        
        [tableView reloadData];
    };
    
    return foot;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RJCellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    LinkManageModel *model = [self.linkArray objectAtIndex:indexPath.section];
    
    cell.textLabel.text = model.url;
    
    UIButton *btn = [Tools createButtonWithFrame:CGRectMake(0, 0, 50, 30) andTitle:@"操作" andTitleColor:LINECOLOR andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(selectopen:) andType:UIButtonTypeCustom];
    btn.tag = 100 + indexPath.section;
    cell.accessoryView = btn;
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    self.segment.selectedSegmentIndex = index;
}

-(void)selectopen:(UIButton *)sender {
    
    LinkManageModel *model = [self.linkArray objectAtIndex:sender.tag - 100];
    
    model.edit = YES;
    
    [self.tableView reloadData];
}

- (IBAction)segmentClick:(UISegmentedControl *)sender {
    @weakify(self)
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self)
        self.scrollView.contentOffset = CGPointMake(sender.selectedSegmentIndex * SCREEN_WIDTH, 0);
    }];
}

-(void)viewDidLayoutSubviews {
    
    self.linkView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
    
    self.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.scrollView.bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
