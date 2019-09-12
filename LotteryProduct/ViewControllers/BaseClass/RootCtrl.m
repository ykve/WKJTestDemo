//
//  RootCtrl.m
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/6.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"
//#import "CartBeijinPK10Ctrl.h"
//#import "CartPCCtrl.h"
//#import "CartSixCtrl.h"
#import "CartCtrl.h"
#import "MainTabbarCtrl.h"
#import <XXShield/XXShield.h>
#import "LiuHeDaShenViewController.h"
#import "MSWeakTimer.h"
#import "TopUpViewController.h"
#import "LoginAlertViewController.h"
#import "RepairView.h"
#import "CPTBuyRootVC.h"
#import "CPTBuySexViewController.h"
#import "KeFuViewController.h"
#import "CountDown.h"
#import "CartListCtrl.h"
@interface RootCtrl ()<WB_StopWatchDelegate>
{
    WB_Stopwatch *stopwatch;
    MSWeakTimer *weakTimer;
    UIImageView *_noDataImageView;
}

/// 倒计时对象
@property (nonatomic, strong) CountDown *countDownObj;
//@property(nonatomic, copy) void (^refreshtimeBlock)(void);
//@property (nonatomic, strong) RepairView *repairView;


@end

@implementation RootCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setmenuBtn:[[CPTThemeConfig shareManager] IC_Nav_SideImageStr]];
    self.countDownObj = [[CountDown alloc] init];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [XXShieldSDK registerStabilityWithAbility:(EXXShieldTypeExceptDangLingPointer)];
    });
    
    
    self.view.backgroundColor = [[CPTThemeConfig shareManager] RootVC_ViewBackgroundC];
    
    
    if (@available(iOS 11.0, *)) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#else
    float barHeight =0;
    if (!isIPad()&& ![[UIApplication sharedApplication] isStatusBarHidden]) {
        
        barHeight+=([[UIApplication sharedApplication]statusBarFrame]).size.height;
    }
    if(self.navigationController &&!self.navigationController.navigationBarHidden) {
        
        barHeight+=self.navigationController.navigationBar.frame.size.height;
    }
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y +barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y +barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
#endif
    
    [self leftBtn:nil Withimage:[[CPTThemeConfig shareManager] backBtnImageName] With:^(UIButton *sender) {
        
        if (stopwatch) {
            
            [stopwatch reset];
            
            stopwatch = nil;
        }
        [self popback];
    }];
    
}

-(UITableView *)tableView {
    
    if (!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
- (void)setwhiteC {
    self.view.backgroundColor = [[CPTThemeConfig shareManager] RootWhiteC];
}
-(UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

-(NSMutableArray *)dataSource {
    
    if(!_dataSource){
        
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

#pragma mark - tableviewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    return cell;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)removeBlock{
    if(self.leftBlock){
        self.leftBlock= nil;
    }
    if(self.rightBlock){
        self.rightBlock = nil;
    }
    if(self.searchBlock){
        self.searchBlock = nil;
    }
    if(self.dateBlock){
        self.dateBlock = nil;
    }
    if(self.refreshBlock){
        self.refreshBlock = nil;
    }
}

#pragma mark - 返回上层
-(void)popback{
    
    [self removeBlock];
    if (self.presentingViewController) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -  返回根视图
-(void)poproot{
    [self removeBlock];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - 返回上几层
- (void)popIndex:(int)page{
    [self removeBlock];
    
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    id vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
    if([vc isKindOfClass:[CartListCtrl class]]){
        CartListCtrl * vcc = (CartListCtrl *)vc;
        [vcc cannelTimer];
    }
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-page] animated:YES];
}

-(void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
    if (stopwatch) {
        
        [stopwatch reset];
        
        stopwatch = nil;
    }
    
    if(self.countDownObj){
        [self.countDownObj destoryTimer];
        self.countDownObj = nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)endRefresh:(UIScrollView *)scrollView WithdataArr:(NSArray *)dataArray {
    
    [scrollView.mj_header endRefreshing];
    [scrollView.mj_footer endRefreshing];
    
    if (dataArray == nil) return;
    if ([dataArray isKindOfClass:[NSString class]]) return;
    
    if (dataArray.count < pageSize.integerValue){
        
        //        [scrollView.mj_footer endRefreshingWithNoMoreData];
    }
}

-(void)hiddenavView {
    
    self.navView.hidden = YES;
    self.navView.alpha = 0;
}
-(UIView *)navView {
    
    if (!_navView) {
        
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAV_HEIGHT)];
        _navView.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack]; 
        _navView.layer.shadowColor = [UIColor blackColor].CGColor;
        _navView.layer.shadowOffset = CGSizeMake(0, 1);
        _navView.layer.shadowOpacity = 0.15;
        [self.view addSubview:_navView];
        @weakify(self)
        [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.left.top.right.equalTo(self.view);
            make.height.equalTo(@(NAV_HEIGHT));
        }];
    }
    
    return _navView;
}

-(void)setTitlestring:(NSString *)titlestring {
    
    _titlestring = titlestring;
    if (!_titlelab) {
        
        _titlelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:[UIFont systemFontOfSize:17] andTitleColor:[[CPTThemeConfig shareManager] CO_NavigationBar_TintColor] andBackgroundColor:CLEAR andTextAlignment:1];
        [_titlelab sizeToFit];
        [self.navView addSubview:_titlelab];
       
    }
    _titlelab.text = titlestring;
    @weakify(self)
    [_titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerX.equalTo(self.navView);
        make.bottom.equalTo(self.navView);
        make.height.equalTo(@43);
    }];
    
}

- (void)setRightBts:(NSArray *)rightBts{
    
    if (rightBts.count >= 3) {
        MBLog(@"你是来搞笑的嘛?放这么多按钮");
        return;
    }
    
    for (int i = 0; i < rightBts.count; i++) {
        
        CGFloat y = NAV_HEIGHT - 44;
        
        CGFloat btnW = 30;
        
        CGFloat btnH = 44;
        
        CGFloat x = SCREEN_WIDTH - (5 + btnW)*(i+1);
        
        UIButton *btn =rightBts[i];
        btn.frame = CGRectMake(x, y, btnW, btnH);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 25);
        [self.navView addSubview:btn];
    }
}

-(void)rigBtn:(NSString *)title Withimage:(NSString *)img With:(void (^)(UIButton*sender))Click {
    
    if (self.rightBtn) {
        
        [self.rightBtn removeFromSuperview];
    }
    
    self.rightBtn = [Tools createButtonWithFrame:CGRectZero andTitle:title andTitleColor:[[CPTThemeConfig shareManager] CO_NavigationBar_Title] andBackgroundImage:nil andImage:IMAGE(img) andTarget:self andAction:@selector(rightClick:) andType:UIButtonTypeCustom];
    [self.navView addSubview:self.rightBtn];
    self.rightBlock = Click;
    self.rightBtn.titleLabel.numberOfLines = 2;
    
    
    [self.rightBtn setTitleColor:[[CPTThemeConfig shareManager] CO_NavigationBar_Title] forState:UIControlStateNormal];
    
    CGFloat w = 0;
    if (title.length > 0) {
        
        w = [Tools createLableWidthWithString:title andfontsize:14 andwithhigh:20];
    }
    if (img > 0) {
        
        w += 33;
    }
    @weakify(self)
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.navView).offset(-1);
        make.right.equalTo(self.navView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(w+10, 43));
    }];
}
-(void)rigBtn2:(NSString *)title Withimage:(NSString *)img With:(void (^)(UIButton*sender))Click {
    
    if (self.rightBtn2) {
        
        [self.rightBtn2 removeFromSuperview];
    }
    
    self.rightBtn2 = [Tools createButtonWithFrame:CGRectZero andTitle:title andTitleColor:[[CPTThemeConfig shareManager] CO_NavigationBar_Title] andBackgroundImage:nil andImage:IMAGE(img) andTarget:self andAction:@selector(rightClick2:) andType:UIButtonTypeCustom];
    
    [self.navView addSubview:self.rightBtn2];
    self.rightBlock2 = Click;
    self.rightBtn2.titleLabel.numberOfLines = 2;
    
    
    [self.rightBtn2 setTitleColor:[[CPTThemeConfig shareManager] CO_NavigationBar_Title] forState:UIControlStateNormal];
    CGFloat w = 0;
    if (title.length > 0) {
        
        w = [Tools createLableWidthWithString:title andfontsize:14 andwithhigh:20];
    }
    if (img > 0) {
        
        w += 33;
    }
    @weakify(self)
    [self.rightBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.bottom.equalTo(self.navView).offset(-1);
        make.right.equalTo(self.rightBtn).offset(-30);
        make.size.mas_equalTo(CGSizeMake(w+10, 43));
    }];
}
-(void)leftBtn:(NSString *)title Withimage:(NSString *)img With:(void (^)(UIButton *))Click {
    if (self.leftBtn) {
        
        [self.leftBtn removeFromSuperview];
    }
    self.leftBtn = [Tools createButtonWithFrame:CGRectZero andTitle:title andTitleColor:kColor(51, 51, 51) andBackgroundImage:nil andImage:IMAGE(img) andTarget:self andAction:@selector(leftClick:) andType:UIButtonTypeCustom];
    [self.navView addSubview:self.leftBtn];
    
    __weak typeof(self) weakSelf = self;
    weakSelf.leftBlock = Click;
    
    self.leftBtn.titleLabel.numberOfLines = 1;
    
    @weakify(self)
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.bottom.equalTo(self.navView).offset(-1);
        
        make.size.mas_equalTo(CGSizeMake(44, 43));
    }];
}

-(void)leftBtnImage:(NSString *)img With:(void (^)(UIButton *))Click {
    if (self.leftBtn) {
        
        [self.leftBtn removeFromSuperview];
    }
    self.leftBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"" andTitleColor:kColor(51, 51, 51) andBackgroundImage:nil andImage:IMAGE(img) andTarget:self andAction:@selector(leftClick:) andType:UIButtonTypeCustom];
    [self.navView addSubview:self.leftBtn];
    
    __weak typeof(self) weakSelf = self;
    weakSelf.leftBlock = Click;
    
    self.leftBtn.titleLabel.numberOfLines = 1;
    
    @weakify(self)
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            make.bottom.equalTo(self.navView).offset(-10);
            make.left.equalTo(self.navView).offset(5);
        }else{
            if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish && [[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_Dark){
                make.bottom.equalTo(self.navView).offset(-13);
                make.left.equalTo(self.navView).offset(10);
            }else{
                make.bottom.equalTo(self.navView).offset(-5);
                make.left.equalTo(self.navView).offset(5);
            }
        }
        
    }];
}
-(void)rigBtnImage:(NSString *)img With:(void (^)(UIButton*sender))Click {
    
    if (self.rightBtn) {
        
        [self.rightBtn removeFromSuperview];
    }
    
    self.rightBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"" andTitleColor:[[CPTThemeConfig shareManager] CO_NavigationBar_Title] andBackgroundImage:nil andImage:IMAGE(img) andTarget:self andAction:@selector(rightClick:) andType:UIButtonTypeCustom];
    [self.navView addSubview:self.rightBtn];
    self.rightBlock = Click;
    self.rightBtn.titleLabel.numberOfLines = 2;
    
    
    [self.rightBtn setTitleColor:[[CPTThemeConfig shareManager] CO_NavigationBar_Title] forState:UIControlStateNormal];
    
    CGFloat w = 0;
    if (img > 0) {
        
        w += 33;
    }
    @weakify(self)
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            make.bottom.equalTo(self.navView).offset(-10);
        }else{
            make.bottom.equalTo(self.navView).offset(-5);
        }
        make.right.equalTo(self.navView).offset(-10);
    }];
}
-(void)rightClick:(UIButton *)sender {
    if (self.rightBlock) {
        self.rightBlock(sender);
    }
}
-(void)rightClick2:(UIButton *)sender {
    if (self.rightBlock2) {
    self.rightBlock2(sender);
    }
}

-(void)leftClick:(UIButton *)sender {
    if (self.leftBlock) {
        self.leftBlock(sender);
    }
    
}



-(void)callphone:(NSString *)phone {
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView * webview = [[UIWebView alloc] init];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:webview];
}

-(UITextField *)searchfield {
    
    if (!_searchfield) {
        
        _searchfield = [[UITextField alloc]init];
        
        _searchfield.layer.cornerRadius = 5;
        
        _searchfield.layer.masksToBounds = YES;
        
        _searchfield.backgroundColor = WHITE;
        
        _searchfield.placeholder = @"搜索";
        
        _searchfield.returnKeyType = UIReturnKeySearch;
        
        UIButton *searchBtn = [Tools createButtonWithFrame:CGRectMake(0, 0, 40, 30) andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"search") andTarget:self andAction:@selector(searchClick) andType:UIButtonTypeCustom];
        
        _searchfield.leftView = searchBtn;
        
        _searchfield.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return _searchfield;
}

-(void)searchClick {
    
    if (self.searchBlock) {
        
        self.searchBlock(self.searchfield.text);
    }
}

-(void)setmenuBtn:(NSString *)imageName {
    
    @weakify(self)
    [self leftBtnImage:imageName With:^(UIButton *sender) {
        
        @strongify(self)
        
        if ([Person person].uid == nil) {
            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
            [self presentViewController:login animated:YES completion:^{
            }];
            return;
        }
        [[LeftCtrl share]show:self];
        
    }];
    
}


-(void)buildTimeViewWithType:(NSInteger)type With:(void (^)(UIButton*sender))Click With:(void (^)(void))refresh {
    
    self.refreshBlock = refresh;
    self.lottery_type = type;
    
    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 34)];
    infoView.backgroundColor = WHITE;
    [self.view addSubview:infoView];
    self.selectdateView = infoView;
    
    if (Click != nil) {
        
        self.dateBlock = Click;
        
        self.dateBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"选择日期" andTitleColor:YAHEI andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(dateClick:) andType:UIButtonTypeCustom];
        self.dateBtn.layer.cornerRadius = 4;
        self.dateBtn.layer.borderColor = CC.CGColor;
        self.dateBtn.layer.borderWidth = 0.7;
        self.dateBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [infoView addSubview:self.dateBtn];
        
        @weakify(self)
        [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.right.equalTo(infoView).offset(-10);
            make.centerY.equalTo(infoView);
            make.size.mas_equalTo(CGSizeMake(80, 24));
        }];
    }
    
    self.versionslab = [Tools createLableWithFrame:CGRectZero andTitle:@"距离-期开奖" andfont:FONT(14) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
    [infoView addSubview:self.versionslab];
    
    self.timelab = [Tools createLableWithFrame:CGRectZero andTitle:@"-:-" andfont:FONT(14) andTitleColor:[UIColor redColor] andBackgroundColor:CLEAR andTextAlignment:0];
    [infoView addSubview:self.timelab];
    
    @weakify(self)
    [Tools getNextOpenTime:type Withresult:^(NSDictionary *dic) {
        @strongify(self)
        NSString *issure = [dic[@"issue"]isKindOfClass:[NSNumber class]] ? [dic[@"issue"] stringValue]  : dic[@"issue"];
        //        NSString *issure = [NSString stringWithFormat:@"%ld", [issureStr integerValue] + 1];
        
        if (issure.length > 8) {
            
            self.versionslab.text = [NSString stringWithFormat:@"距离%@期开奖",[issure substringFromIndex:type == 3 ? 9 : 8]];
        }
        else {
            self.versionslab.text = [NSString stringWithFormat:@"距离%@期开奖",issure];
        }
        
//        stopwatch = [[WB_Stopwatch alloc]initWithLabel:self.timelab andTimerType:WBTypeTimer];
//        stopwatch.delegate = self;
//        [stopwatch setTimeFormat:@"HH:mm:ss"];
//        stopwatch.startTimeInterval = [dic[@"start"]integerValue];     // 当前时间
//        [stopwatch setCountDownTime:[dic[@"time"]integerValue]];//多少秒 （1分钟 == 60秒）   // 时间差
//        if ([dic[@"time"]integerValue]>=0) {
//            [stopwatch start];
//        }
        
        [self.countDownObj countDownWithStratTimeStamp:[dic[@"start"] integerValue] finishTimeStamp:[dic[@"opentime"]integerValue] completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
            @strongify(self)
            NSString * hourS;
            NSString * minS;
            NSString * secondS;
            
            if (hour<10) {
                hourS = [NSString stringWithFormat:@"0%ld",(long)hour];
            }else{
                hourS = [NSString stringWithFormat:@"%ld",(long)hour];
            }
            if (minute<10) {
                minS = [NSString stringWithFormat:@"0%ld",(long)minute];
            }else{
                minS = [NSString stringWithFormat:@"%ld",(long)minute];
            }
            if (second<10) {
                secondS = [NSString stringWithFormat:@"0%ld",(long)second];
            }else{
                secondS = [NSString stringWithFormat:@"%ld",(long)second];
            }
            self.timelab.text = [NSString stringWithFormat:@"%@:%@:%@",hourS,minS,secondS];
            
        }];
        
    }];
    
    [self.versionslab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if (Click != nil) {
            
            make.right.equalTo(self.timelab.mas_left).offset(-4);
        }
        else{
            make.centerX.equalTo(infoView).offset(-10);
        }
        
        make.centerY.equalTo(infoView);
    }];
    
    [self.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        if (Click != nil) {
            
            make.right.equalTo(self.dateBtn.mas_left).offset(-15);
        }
        else{
            make.left.equalTo(self.versionslab.mas_right).offset(4);
        }
        
        make.centerY.equalTo(infoView);
    }];
    
    
}

-(void)dateClick:(UIButton *)sender {
    
    self.dateBlock(sender);
    
}

#pragma mark - 未登录弹出登录
-(void)showlogin:(void (^)(BOOL success))success {
    
    //    LoginCtrl *login = [[LoginCtrl alloc]initWithNibName:NSStringFromClass([LoginCtrl class]) bundle:[NSBundle mainBundle]];
    //
    //    login.loginBlock = ^(BOOL result) {
    //
    //        if (result) {
    //
    //            success(YES);
    //        }
    //    };
    //    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    //
    //    nav.navigationBar.hidden = YES;
    //
    //    [self presentViewController:nav animated:YES completion:nil];
}

//时间到了
-(void)timerLabel:(WB_Stopwatch*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    self.versionslab.text = @"开奖中";
    
    NSInteger time = self.lottery_type == 3 ? 10 : 100;
    
    if(weakTimer){
        [weakTimer invalidate];
        weakTimer = nil;
    }
    weakTimer = [MSWeakTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(reloadData) userInfo:nil repeats:NO dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    
    //    });
    
}

- (void)reloadData{
    if(weakTimer){
        [weakTimer invalidate];
        weakTimer = nil;
    }
    if(!self.refreshBlock){
        return;
    }
    @weakify(self)
    self.refreshBlock();
    
    [Tools getNextOpenTime:self.lottery_type Withresult:^(NSDictionary *dic) {
        @strongify(self)
        if ([dic[@"issue"] length] > 8) {
            
            self.versionslab.text = [NSString stringWithFormat:@"距离%@期开奖",[dic[@"issue"] substringFromIndex:self.lottery_type == 3 ? 9 : 8]];
        }
        else {
            self.versionslab.text = [NSString stringWithFormat:@"距离%@期开奖",dic[@"issue"]];
        }
        
        [stopwatch setCountDownTime:[dic[@"time"]integerValue]];//多少秒 （1分钟 == 60秒）
        
        if ([dic[@"time"]integerValue]>=0) {
            
            [stopwatch start];
        }
    }];
}


//开始倒计时
-(void)timerLabel:(WB_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WB_StopwatchLabelType)timerType {
    //    NSLog(@"time:%f",time);
    
}

#pragma mark - C(m,n)
-(NSInteger)getstep:(NSInteger)m With:(NSInteger)n {
    
    NSInteger x = [self getstep1With:m With:n];
    NSInteger y = [self getstep2With:n];
    
    return x/y;
}

-(NSInteger)getstep1With:(NSInteger)m With:(NSInteger)n {
    
    NSInteger result = m;
    
    for (int i = 1 ;i<n ;i++) {
        
        result *= --m;
    }
    
    return result;
}

-(NSInteger)getstep2With:(NSInteger)n {
    
    NSInteger result = n;
    
    for (NSInteger i = n ; i>2; ) {
        
        result *= --n;
        
        i = n;
    }
    
    return result;
}

- (void)buildDashenBtn{
    UIButton *dashenBtn = [Tools createButtonWithFrame:CGRectMake(SCREEN_WIDTH - 70, SCREEN_HEIGHT - 30 - 120 - 60, 67, 67) andTitle:nil andTitleColor:nil andBackgroundImage:nil andImage:IMAGE([[CPTThemeConfig shareManager] LHDSBtnImage]) andTarget:self andAction:@selector(skipToDaShenVc) andType:UIButtonTypeCustom];

        dashenBtn.frame = CGRectMake(SCREEN_WIDTH - 70, SCREEN_HEIGHT - 190, 60, 100);
    dashenBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:dashenBtn];
    [self.view bringSubviewToFront:dashenBtn];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    
                                                    initWithTarget:self
                                                    
                                                    action:@selector(handlePan:)];
    
    [dashenBtn addGestureRecognizer:panGestureRecognizer];
}

- (void)skipToDaShenVc{
    LiuHeDaShenViewController *daShenVc = [[LiuHeDaShenViewController alloc] init];
    PUSH(daShenVc);
}

-(void)buildBettingBtn {
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish || [[AppDelegate shareapp] wkjScheme] == Scheme_LotterEight){
        return;
    }
    UIButton *btn = [Tools createButtonWithFrame:CGRectMake(10, SCREEN_HEIGHT - 30 - 120 - 60, 55, 55) andTitle:@"投注" andTitleColor:[[CPTThemeConfig shareManager] bettingBtnColor] andBackgroundImage:[[CPTThemeConfig shareManager] TouZhuImage] andImage:nil andTarget:self andAction:@selector(BettingClick:) andType:UIButtonTypeCustom];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 3, 0 );
    btn.titleLabel.font = FONT(12);
    
    if ([Person person].Information==NO) {
        
        [self.view addSubview:btn];
        [self.view bringSubviewToFront:btn];
    }
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    
                                                    initWithTarget:self
                                                    
                                                    action:@selector(handlePan:)];
    
    [btn addGestureRecognizer:panGestureRecognizer];
}


#pragma mark 客服
- (void)buildKeFuBtnByName:(NSString *)changeName{
//    UIButton *keFuBtn = [Tools createButtonWithFrame:CGRectMake(SCREEN_WIDTH - 132/2-10, SCREEN_HEIGHT - 30 - 120 - 60, 132/2, 122/2) andTitle:nil andTitleColor:nil andBackgroundImage:nil andImage:IMAGE(changeName) andTarget:self andAction:@selector(changeToBuy:) andType:UIButtonTypeCustom];
//    keFuBtn.tag = 10001;
//    keFuBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//
//    [self.view addSubview:keFuBtn];
//    [self.view bringSubviewToFront:keFuBtn];
//
//    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
//                                                    initWithTarget:self
//                                                    action:@selector(handlePan:)];
//    [keFuBtn addGestureRecognizer:panGestureRecognizer];
}



- (void)changeToBuy:(UIButton *)btn{
    KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
    PUSH(kefuVc);
}

- (void)skipToKeFuVc{
    
    
    KeFuViewController *kefuVc = [[KeFuViewController alloc] init];
    
    PUSH(kefuVc);
    
}
- (void) handlePan:(UIPanGestureRecognizer*) recognizer

{
    
    CGPoint translation = [recognizer translationInView:self.view];
    
    CGFloat centerX=recognizer.view.center.x+ translation.x;
    CGFloat centerY=recognizer.view.center.y+ translation.y;
    CGFloat thecenterX=0;
    CGFloat thecenterY=0;
    recognizer.view.center=CGPointMake(centerX,
                                       
                                       recognizer.view.center.y+ translation.y);
    
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if(recognizer.state==UIGestureRecognizerStateEnded|| recognizer.state==UIGestureRecognizerStateCancelled) {
        
        if(centerX>SCREEN_WIDTH/2) {
            
            thecenterX=SCREEN_WIDTH-50/2;
            
        }else{
            
            thecenterX=50/2;
            
        }
        if (centerY>SCREEN_HEIGHT-NAV_HEIGHT) {
            
            thecenterY=SCREEN_HEIGHT-NAV_HEIGHT;
        }
        else if (centerY<NAV_HEIGHT) {
            
            thecenterY=NAV_HEIGHT;
        }
        else{
            thecenterY = recognizer.view.center.y+ translation.y;
        }
        [UIView animateWithDuration:0.3 animations:^{
            
            recognizer.view.center=CGPointMake(thecenterX,thecenterY);
            
        }];
        
    }
}

-(void)BettingClick:(UIButton *)sender {
    /**
     //1 重庆时时彩  2新疆时时彩  3 比特币分分彩 4 六合彩 5 pc 蛋蛋 6北京PK10 7 幸运飞艇 9 足彩资讯
     */
    CPTBuyRootVC * vc = [[CPTBuyRootVC alloc] init];
    CPTBuySexViewController *six = [[CPTBuySexViewController alloc]init];
    if(self.lottery_oldID > 0 && self.lottery_oldID == 4){
        vc.lotteryId = CPTBuyTicketType_LiuHeCai;
        six.categoryId =  CPTBuyCategoryId_LHC;
        six.lottery_type = CPTBuyTicketType_LiuHeCai;
        six.lotteryId = CPTBuyTicketType_LiuHeCai;
        six.type = CPTBuyTicketType_LiuHeCai;
        six.endTime = 60;
    }else{
        switch (self.lottery_type) {
            case 1:
            {
                six.categoryId =  CPTBuyCategoryId_SSC;
                vc.lotteryId = CPTBuyTicketType_SSC;
                six.lottery_type = CPTBuyTicketType_SSC;
                six.lotteryId = CPTBuyTicketType_SSC;
                six.type = CPTBuyTicketType_SSC;
                six.endTime = 5;
            }
                break;
            case 4:
            {
                vc.lotteryId = CPTBuyTicketType_LiuHeCai;
                six.lottery_type = CPTBuyTicketType_LiuHeCai;
                six.lotteryId = CPTBuyTicketType_LiuHeCai;
                six.type = CPTBuyTicketType_LiuHeCai;
                six.categoryId =  CPTBuyCategoryId_LHC;
                six.endTime = 60;
            }
                break;
            case 6:
            {
                vc.lotteryId = CPTBuyTicketType_PK10;
                six.lottery_type = CPTBuyTicketType_PK10;
                six.lotteryId = CPTBuyTicketType_PK10;
                six.type = CPTBuyTicketType_PK10;
                six.categoryId =  CPTBuyCategoryId_PK10;
                six.endTime = 5;
            }
                break;
            case 5:
            {
                vc.lotteryId = CPTBuyTicketType_PCDD;
                six.lottery_type = CPTBuyTicketType_PCDD;
                six.lotteryId = CPTBuyTicketType_PCDD;
                six.type = CPTBuyTicketType_PCDD;
                six.categoryId =  CPTBuyCategoryId_PCDD;
                six.endTime = 5;
            }
                break;
            case 2:
            {
                vc.lotteryId = CPTBuyTicketType_XJSSC;
                six.lottery_type = CPTBuyTicketType_XJSSC;
                six.lotteryId = CPTBuyTicketType_XJSSC;
                six.type = CPTBuyTicketType_XJSSC;
                six.categoryId =  CPTBuyCategoryId_SSC;
                six.endTime = 5;
            }
                break;
            case 3:
            {
                vc.lotteryId = CPTBuyTicketType_FFC;
                six.lottery_type = CPTBuyTicketType_FFC;
                six.lotteryId = CPTBuyTicketType_FFC;
                six.type = CPTBuyTicketType_FFC;
                six.categoryId =  CPTBuyCategoryId_FFC;
                six.endTime = 5;
            }
                break;
            case 7:
            {
                vc.lotteryId = CPTBuyTicketType_XYFT;
                six.lottery_type = CPTBuyTicketType_XYFT;
                six.lotteryId = CPTBuyTicketType_XYFT;
                six.type = CPTBuyTicketType_XYFT;
                six.categoryId =  CPTBuyCategoryId_XYFT;
                six.endTime = 5;
            }
                break;
            case 11:
            {
                vc.lotteryId = CPTBuyTicketType_AoZhouF1;
                six.lottery_type = CPTBuyTicketType_AoZhouF1;
                six.lotteryId = CPTBuyTicketType_AoZhouF1;
                six.type = CPTBuyTicketType_AoZhouF1;
                six.endTime = 5;
            }
                break;
            default:
                break;
        }
    }
    [[CPTBuyDataManager shareManager] configType:six.type];
    vc.type = six.type;
    [vc loadVC:six title:[[CPTBuyDataManager shareManager] changeTypeToString:six.lottery_type]];
    PUSH(vc);
    
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    //
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"BUYLOTTERY" object:nil];
    
}

-(void)setshake {
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:NO];
    
    [self resignFirstResponder];
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"lottery_shake"]boolValue]) {
        
        [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
        
        [self becomeFirstResponder];
    }
}
#pragma mark -  充值
-(void)addmoneyClick {
    if ([Person person].uid == nil) {
        @weakify(self)
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        login.loginBlock = ^(BOOL result) {
            @strongify(self)
            [self addmoneyClick];
        };
        return ;
    }
    TopUpViewController *topUpVC = [[TopUpViewController alloc] init];
    [self.navigationController pushViewController:topUpVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shakeM{
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)showNoDataImageView{
    if(!_noDataImageView){
        _noDataImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 152)];
        _noDataImageView.image = IMAGE(@"noDataImageView");
        _noDataImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:_noDataImageView];
        _noDataImageView.center = self.view.center;
    }
}
- (void)hiddenNoDataImageView{
    if(_noDataImageView){
        [_noDataImageView removeFromSuperview];
    }
}


@end
