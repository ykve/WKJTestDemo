//
//  CircleSearchView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/2.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CircleSearchView.h"
#import "CircleSearchCell.h"

@interface CircleSearchView ()

@end

@implementation CircleSearchView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WHITE;

    @weakify(self)
    [self rigBtn:@"取消" Withimage:nil With:^(UIButton *sender) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.rightBtn setTitleColor:WHITE forState:UIControlStateNormal];
    
    [self.navView addSubview:self.searchfield];
    
    [self.searchfield mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.navView).offset(10);
        make.right.equalTo(self.rightBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.rightBtn);
        make.height.equalTo(@35);
    }];
    
    self.searchBlock = ^(NSString *search) {
        
        
    };
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:@"为你推荐圈内大神" andfont:FONT(13) andTitleColor:[UIColor lightGrayColor] andBackgroundColor:CLEAR andTextAlignment:0];
    [self.view addSubview:lab];
    
    UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:@"一键关注" andTitleColor:[UIColor colorWithHex:@"C39E56"] andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(attentionClick) andType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [UIColor colorWithHex:@"C39E56"].CGColor;
    btn.layer.borderWidth = 1;
    [self.view addSubview:btn];
    
    UIButton *btn2 = [Tools createButtonWithFrame:CGRectZero andTitle:@"换一组" andTitleColor:kColor(86, 131, 255) andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(changeClick) andType:UIButtonTypeCustom];
    [self.view addSubview:btn2];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.navView.mas_bottom);
        make.left.equalTo(self.view).offset(12);
        make.height.equalTo(@20);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-SAFE_HEIGHT - 12);
        make.size.mas_equalTo(CGSizeMake(85, 30));
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.right.equalTo(self.view).offset(-12);
        make.centerY.equalTo(btn);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleSearchCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    self.tableView.rowHeight = 68;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT+20, 0, SAFE_HEIGHT+54, 0));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CircleSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    
    return cell;
}

-(void)attentionClick {
    
    
}

-(void)changeClick {
    
    
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
