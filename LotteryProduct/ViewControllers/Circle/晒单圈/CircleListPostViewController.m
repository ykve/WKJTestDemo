//
//  CircleListPostViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CircleListPostViewController.h"
#import "CirclelistCell.h"
#import "CircleModel.h"
#import "ReportView.h"
#import "CircleUserCenterCtrl.h"
#import "LXKeyBoard.h"
#import "PostCirCleCtrl.h"
#import "NSString+AttributedString.h"

@interface CircleListPostViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataScoure;
@property (strong, nonatomic) NSArray *reprotArray;
@property (nonatomic, strong) LXKeyBoard *keyboard;
@property (assign, nonatomic) NSInteger postId;
@property (copy, nonatomic) NSString *commentsId;
@property (strong, nonatomic) UIControl *keyboardControl;
@property (assign, nonatomic) NSInteger openSection;
@property (strong, nonatomic) NSMutableArray *comentArray;
@property (strong, nonatomic) NSMutableArray *heightArray;

@end

@implementation CircleListPostViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.keyboard.isDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.keyboard.isDisappear = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if(!_comentArray){
        _comentArray = [NSMutableArray array];
    }else{
        [self.comentArray removeAllObjects];
    }
    if(!_heightArray){
        _heightArray = [NSMutableArray array];
    }else{
        [self.heightArray removeAllObjects];
    }
    
    self.openSection = -1;
    self.canScroll = YES;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [[CPTThemeConfig shareManager] circleListDetailViewBackgroundColor];//[UIColor colorWithHex:@"2D2F36"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[CirclelistCell class] forHeaderFooterViewReuseIdentifier:RJHeaderIdentifier];
    [self.tableView registerClass:[CircleCommentListCell class] forCellReuseIdentifier:RJCellIdentifier];
    
    self.page = 1;
    @weakify(self)
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)

        self.page++;
        
        [self initData:YES];
    }];
    
    [self configLocalData];

    [self initreportData];
    
    if (self.tag == 1) {
    
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"REFRESHATTENTION" object:nil];
    }
}

- (void)configLocalData{
    UIColor *naC = [UIColor colorWithHex:@"4e79c2"];
    NSArray * array = [Tools readCircleModelDataFromPlistFile:[NSString stringWithFormat:@"CirclePlist%ld.plist",self.tag + 1]];
    if(!array){
        [self initData:NO];
        return;
    }
    for(NSInteger i=0;i<array.count;i++){
        CircleModel *model = [array objectAtIndex:i];
        NSMutableArray * comA = [NSMutableArray array];
        NSMutableArray * heightA = [NSMutableArray array];
        //                NSMutableArray * myAttentionA = [NSMutableArray array];
        
        for(NSInteger n=0;n<model.postCommentsVOList.count;n++){
            
            PostCommentsVOList *comm = [model.postCommentsVOList objectAtIndex:n];
            NSString *replacename = comm.commentsReplyNickname;
            NSString *name = comm.commentsNickname;
            NSString *content = comm.commentsContent;
            if (replacename.length) {
                NSMutableAttributedString *contentattr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@回复%@:%@",name,replacename,content]];
                NSString *ss = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@回复%@:%@",name,replacename,content]];
                [contentattr addAttribute:NSForegroundColorAttributeName value:naC range:NSMakeRange(0, name.length)];
                [contentattr addAttribute:NSForegroundColorAttributeName value:naC range:NSMakeRange(name.length + 2, replacename.length)];
                [comA addObject:contentattr];
                CGFloat heightsa = [ss HeightParagraphSpeace:3 withFont:FONT(13) AndWidth:SCREEN_WIDTH-64];
                [heightA addObject:@(heightsa)];
            }
            else{
                NSMutableAttributedString *contentattr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:%@",name,content]];
                NSString *ss = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@:%@",name,content]];
                [contentattr addAttribute:NSForegroundColorAttributeName value:naC range:NSMakeRange(0, name.length)];
                [comA addObject:contentattr];
                CGFloat heightsa = [ss HeightParagraphSpeace:3 withFont:FONT(13) AndWidth:SCREEN_WIDTH-64];
                [heightA addObject:@(heightsa)];
            }
        }
        [self.comentArray addObject:comA];
        [self.heightArray addObject:heightA];
    }
    [self.dataScoure addObjectsFromArray:array];
    for(NSInteger i = 0;i<self.dataScoure.count;i++){
        if(i==self.openSection&& self.openSection!=-1){
            CircleModel *model = [self.dataScoure objectAtIndex:i];
            model.isOpen = YES;
        }
    }
    [self.tableView reloadData];
    [self initData:NO];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.canScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
        //到顶通知父视图改变状态
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataScoure.count;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CircleModel *model = [self.dataScoure objectAtIndex:section];
    if(model.postCommentsVOList.count>5&& !model.isOpen){
        return 6;
    }else{
        return model.postCommentsVOList.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CircleModel *model = [self.dataScoure objectAtIndex:section];
    
    return [CirclelistCell getHeight:model];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 5.5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CircleModel *model = [self.dataScoure objectAtIndex:section];
    CirclelistCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:RJHeaderIdentifier];
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, [CirclelistCell getHeight:model]);
    
    cell.backgroundColor = [[CPTThemeConfig shareManager] Circle_Cell_BackgroundC];
    @weakify(self)
    [cell.headimgv tapHandle:^{
        @strongify(self)
        CircleUserCenterCtrl *user = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleUserCenterCtrl"];
        user.member = model.postMember;
        user.title = model.postMember.nickname;
        [self.navigationController pushViewController:user animated:YES];
    }];
    [cell.headimgv longtapHandle:^{
        
        [AlertSheetTool AlertSheetToolWithCancelTitle:@"取消" otherItemArrays:@[@"屏蔽",@"举报"] viewController:self handler:^(NSInteger index) {
            @strongify(self)

            if (index == 1) {
                
                [self shieldUser:model.postMember.memberId];
            }
            else if (index == 2) {
                
                [self showreportView:model.postMember];
            }
        }];
    }];
    cell.circleClickBlock = ^(NSInteger click , UIButton *sender) {
        @strongify(self)

        if (click == 1) { //点赞
            
            [self deleteCircle:1 WithpostId:model withbtn:sender];
        }
        else if (click == 2) { //品论
            
            if (self.postId != model.circlePost.ID) {
                
                self.keyboard.textView.text = nil;
            }
            
            [self.keyboard.textView becomeFirstResponder];
            self.keyboard.textView.placeholder = @"发表评论:";
            self.postId = model.circlePost.ID;
            self.commentsId = nil;
            UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
            [keywindow addSubview:self.keyboardControl];
            [keywindow addSubview:self.keyboard];
        }
        else if (click == 3) { //关注
            
            [self attentionClick:model.postMember WithButton:sender];
        }
        else if (click == 4) {
            
            [AlertViewTool alertViewToolShowTitle:@"确定删除这条帖子？" message:@"" cancelTitle:@"取消" confiormTitle:@"确定" fromController:self handler:^(NSInteger index) {
                @strongify(self)

                if (index == 1) {
                    
                    [self deleteCircle:2 WithpostId:model withbtn:sender];
                }
            }];
        }
    };
    cell.isusercircle = NO;
    cell.model = model;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *foot = [UIView new];
    //    foot.backgroundColor = [UIColor groupTableViewBackgroundColor];
    foot.backgroundColor = [[CPTThemeConfig shareManager] Circle_FooterViewLine_BackgroundC];//[UIColor colorWithHex:@"393B44"];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    backView.backgroundColor = [[CPTThemeConfig shareManager] Circle_Cell_Commit_BackgroundC];
    [foot addSubview:backView];
    
    UIView *seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, backView.height, SCREEN_WIDTH, 0.5)];
    seperatorLine.backgroundColor = [[CPTThemeConfig shareManager] Circle_FooterViewLine_BackgroundC];
    [foot addSubview:seperatorLine];
    
    return foot;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CircleModel *model = [self.dataScoure objectAtIndex:indexPath.section];
    
    NSNumber *height = self.heightArray[indexPath.section][indexPath.row];
    CGFloat hhh = [height floatValue];
    CGFloat h;
    if(model.postCommentsVOList.count>5&& !model.isOpen){
        h = [Tools createLableHighWithString:@"查看全部评论" andfontsize:13 andwithwidth:SCREEN_WIDTH - 93];
    }else{
        h = hhh;
    }
    
//    if(indexPath.row == model.postCommentsVOList.count-1){
//        h = h+5;
//    }
    
//    CircleModel *model = [self.dataScoure objectAtIndex:indexPath.section];
//
//    if (indexPath.row == model.postCommentsVOList.count - 1) {
//        return h + 20;
//    }

//    CircleModel *model = [self.dataScoure objectAtIndex:indexPath.section];
//    if (indexPath.row == model.postCommentsVOList.count - 1) {
//        return h + 5;
//    }
    return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CircleCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    CircleModel *model = [self.dataScoure objectAtIndex:indexPath.section];
    
    PostCommentsVOList *comm = [model.postCommentsVOList objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [[CPTThemeConfig shareManager] Circle_Cell_Commit_BackgroundC];
    cell.textLabel.textColor = [[CPTThemeConfig shareManager] Circle_Cell_Commit_TitleC];
//    NSString *name = comm.commentsNickname;
//    NSString *content = comm.commentsContent;
//    NSString *replacename = comm.commentsReplyNickname;
    NSMutableAttributedString *ccccc = self.comentArray[indexPath.section][indexPath.row];
    if(model.postCommentsVOList.count>5 && !model.isOpen){
        if(indexPath.row==5){
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"查看全部评论";
        }else{
            cell.textLabel.attributedText = ccccc;
        }
    }else{
        cell.textLabel.attributedText = ccccc;
    }
    
    cell.textLabel.font = FONT(13);
    cell.textLabel.numberOfLines = 0;
//    cell.textLabel.font = FONT(20);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CircleModel *model = [self.dataScoure objectAtIndex:indexPath.section];
    
    PostCommentsVOList *comm = [model.postCommentsVOList objectAtIndex:indexPath.row];
    if(model.postCommentsVOList.count>5 && !model.isOpen){
        self.openSection = indexPath.section;
        model.isOpen = YES;
        //        [self.tableView reloadData];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationBottom];


        //        [self.tableView beginUpdates];
        //        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //        [self.tableView endUpdates];
        //        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    
    if (self.postId != model.circlePost.ID) {
        
        self.keyboard.textView.text = nil;
    }
    
    [self.keyboard.textView becomeFirstResponder];
    
    self.keyboard.textView.placeholder = [NSString stringWithFormat:@"回复:%@",comm.commentsNickname];
    
    self.postId = model.circlePost.ID;
    
    self.commentsId = INTTOSTRING(comm.commentsId);
    
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    [keywindow addSubview:self.keyboardControl];
    [keywindow addSubview:self.keyboard];
}

#pragma mark - 弹出举报窗并举报
-(void)showreportView:(PostMember *)menber {
    
    ReportView *report = [[ReportView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 0)];
    
    report.reprotData = self.reprotArray.copy;
    @weakify(self)
    report.selectRortBlock = ^(NSDictionary *report) {
        @strongify(self)
        PostCirCleCtrl *post = [[PostCirCleCtrl alloc]init];
        post.memberId = menber.memberId;
        post.reportDic = report;
        PUSH(post);
    };
    
    [report show];
}
#pragma mark - 获取圈子列表
-(void)initData:(BOOL)showHD {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:@(self.page) forKey:@"pageNum"];
    [dic setValue:pageSize forKey:@"pageSize"];
    [dic setValue:@(self.tag + 1) forKey:@"type"];
    @weakify(self)
    [WebTools postWithURL:@"/circle/listPost" params:dic success:^(BaseData *data) {
        @strongify(self)

        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        if ([data.data isKindOfClass:[NSArray class]]) {
            
            if (self.page == 1) {
                [self.heightArray removeAllObjects];
                [self.dataScoure removeAllObjects];
                [self.comentArray removeAllObjects];
            }

            NSArray *array = [CircleModel mj_objectArrayWithKeyValuesArray:data.data];
            
            if (array.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                [self.tableView reloadData];
                return ;
            }
            if (self.page == 1) {
                [Tools saveDataToPlistFile:data.data WithName:[NSString stringWithFormat:@"CirclePlist%ld.plist",self.tag + 1]];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            UIColor *naC = [UIColor colorWithHex:@"4e79c2"];

            for(NSInteger i=0;i<array.count;i++){
                CircleModel *model = [array objectAtIndex:i];
                NSMutableArray * comA = [NSMutableArray array];
                NSMutableArray * heightA = [NSMutableArray array];
//                NSMutableArray * myAttentionA = [NSMutableArray array];
                
                for(NSInteger n=0;n<model.postCommentsVOList.count;n++){
                    
                    PostCommentsVOList *comm = [model.postCommentsVOList objectAtIndex:n];
                    NSString *replacename = comm.commentsReplyNickname;
                    NSString *name = comm.commentsNickname;
                    NSString *content = comm.commentsContent;
                    if (replacename.length) {
                        NSMutableAttributedString *contentattr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@回复%@:%@",name,replacename,content]];
                        NSString *ss = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@回复%@:%@",name,replacename,content]];
                        [contentattr addAttribute:NSForegroundColorAttributeName value:naC range:NSMakeRange(0, name.length)];
                        [contentattr addAttribute:NSForegroundColorAttributeName value:naC range:NSMakeRange(name.length + 2, replacename.length)];
                        [comA addObject:contentattr];
                        CGFloat heightsa = [ss HeightParagraphSpeace:3 withFont:FONT(13) AndWidth:SCREEN_WIDTH-64];
                        [heightA addObject:@(heightsa)];
                    }
                    else{
                        NSMutableAttributedString *contentattr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:%@",name,content]];
                        NSString *ss = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@:%@",name,content]];
                        [contentattr addAttribute:NSForegroundColorAttributeName value:naC range:NSMakeRange(0, name.length)];
                        [comA addObject:contentattr];
                        CGFloat heightsa = [ss HeightParagraphSpeace:3 withFont:FONT(13) AndWidth:SCREEN_WIDTH-64];
                        [heightA addObject:@(heightsa)];
                    }
                }
                [self.comentArray addObject:comA];
                [self.heightArray addObject:heightA];
            }
            [self.dataScoure addObjectsFromArray:array];

            
            
            for(NSInteger i = 0;i<self.dataScoure.count;i++){
                if(i==self.openSection&& self.openSection!=-1){
                    CircleModel *model = [self.dataScoure objectAtIndex:i];
                    model.isOpen = YES;
                }
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } showHUD:showHD];
}

#pragma mark - 获取举报列表
-(void)initreportData {
    
    [WebTools postWithURL:@"/circle/getPostReportType" params:nil success:^(BaseData *data) {
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        self.reprotArray = data.data;
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}
#pragma mark - 发表评论
-(void)postComment:(NSString *)text Withuid:(NSString *)commentsId {
    
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
    
    [mdic setValue:@(self.postId) forKey:@"postId"];
    [mdic setValue:text forKey:@"content"];
    [mdic setValue:commentsId forKey:@"commentsId"];
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/commentsPost" params:mdic success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        [MBProgressHUD showSuccess:data.info];
        
        self.keyboard.textView.text = nil;
        
        [self refreshData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 关注
-(void)attentionClick:(PostMember *)member WithButton:(UIButton *)sender {
    
    [WebTools postWithURL:@"/circle/focusOrCancle" params:@{@"memberId":@(member.memberId),@"type":@(member.isFocus + 1)} success:^(BaseData *data) {

        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        if (member.isFocus == 0) {
            
            member.isFocus = 1;
        }
        else{
            member.isFocus = 0;
        }
        
        [MBProgressHUD showSuccess:data.info finish:^{
            
            [sender setTitle:member.isFocus == 0 ? @"关注" : @"  取消关注" forState:UIControlStateNormal];
            
            [sender setImage:member.isFocus == 0 ? IMAGE(@"关注") : IMAGE(@"") forState:UIControlStateNormal];
            
        }];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"REFRESHATTENTION" object:nil];

//        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
        
    } showHUD:NO];
}

#pragma mark - 1点赞 2删除
-(void)deleteCircle:(NSInteger)type WithpostId:(CircleModel *)model withbtn:(UIButton *)sender {
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/praiseOrDelPost" params:@{@"postId":@(model.circlePost.ID),@"type":@(type)} success:^(BaseData *data) {

        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        
        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)

            if (type == 1) {
                
                model.circlePost.meHasPraise = 1;
                sender.selected = YES;
                NSInteger num = model.circlePost.praiseNumber + 1;
                model.circlePost.praiseNumber = num;
                NSString *tpm = [NSString stringWithFormat:@" %ld ",(long)model.circlePost.praiseNumber];
                [sender setTitle:tpm forState:UIControlStateNormal];
            }
            else{
                [self initData:YES];
//                [self.tableView.mj_header beginRefreshing];
            }
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 屏蔽用户
-(void)shieldUser:(NSInteger)memberId {
    @weakify(self)
    [WebTools postWithURL:@"/circle/shieldUser" params:@{@"memberId":@(memberId)} success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)

            [self refreshData];
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

-(void)refreshData {
    self.page = 1;
    
    [self initData:NO];
}

-(NSMutableArray *)dataScoure {
    
    if (!_dataScoure) {
        
        _dataScoure = [[NSMutableArray alloc]init];
    }
    return _dataScoure;
}

-(LXKeyBoard *)keyboard{
    if (!_keyboard) {
        _keyboard =[[LXKeyBoard alloc]initWithFrame:CGRectZero];
        _keyboard.backgroundColor =[UIColor whiteColor];
        _keyboard.maxLine = 3;
        _keyboard.font = Font(16);
        _keyboard.topOrBottomEdge = 10;
        [_keyboard beginUpdateUI];
        LXWS(weakSelf);
        
        _keyboard.sendBlock = ^(NSString *text) {
            NSLog(@"%@",text);
            if ([Tools isEmptyOrNull:text]) {
                
                [MBProgressHUD showError:@"请输入评论内容"];
                
                return;
            }
            [weakSelf postComment:text Withuid:weakSelf.commentsId];
            [weakSelf.keyboard.textView resignFirstResponder];
            [weakSelf.keyboardControl removeFromSuperview];
            [weakSelf.keyboard removeFromSuperview];
        };
        _keyboard.keyboardBlock = ^{
            
            [weakSelf dismiss];
            [weakSelf.tableView reloadData];
        };
    }
    return _keyboard;
}

-(UIControl *)keyboardControl {
    
    if (!_keyboardControl) {
        
        _keyboardControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _keyboardControl.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_keyboardControl addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _keyboardControl;
}

-(void)dismiss {
    
    [self.keyboard.textView resignFirstResponder];
    [self.keyboardControl removeFromSuperview];
    [self.keyboard removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    [cache.memoryCache removeAllObjects];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}

@end

#pragma mark - circle
@implementation CircleCommentListCell

- (void)layoutSubviews
{
    @weakify(self)
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(2, 62, 0, 0));
    }];
}

@end
