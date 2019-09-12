//
//  CircleUserCenterCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/16.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CircleUserCenterCtrl.h"
#import "CirclelistCell.h"
#import "UIViewController+BackItem.h"
#import "ReportView.h"
#import "LXKeyBoard.h"
#import "PostCirCleCtrl.h"
#import "FansListCtrl.h"
#import "CircleListPostViewController.h"
@interface CircleUserCenterCtrl ()<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *attentionViewLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attentionViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fansViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyViewWidth;
@property (weak, nonatomic) IBOutlet UIImageView *headbagimgv;
@property (weak, nonatomic) IBOutlet UIImageView *headimgv;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UILabel *fansnumlab;
@property (weak, nonatomic) IBOutlet UILabel *attentionnumlab;
@property (weak, nonatomic) IBOutlet UILabel *replaynumlab;
@property (weak, nonatomic) IBOutlet UIView *fansView;
@property (weak, nonatomic) IBOutlet UIView *attentionView;
@property (weak, nonatomic) IBOutlet UIView *replayView;

@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *middleHeaderView;


@property (strong, nonatomic) NSArray *reprotArray;
@property (strong, nonatomic) NSMutableArray *dataScoure;
@property(nonatomic, strong)LXKeyBoard *keyboard;
@property (assign, nonatomic) NSInteger postId;
@property (copy, nonatomic) NSString *commentsId;
@property (strong, nonatomic) UIControl *keyboardControl;

@end

@implementation CircleUserCenterCtrl

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.keyboard.isDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.keyboard.isDisappear = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlestring = self.title;
    self.navView.backgroundColor = CLEAR;
    
    self.middleHeaderView.backgroundColor = [UIColor colorWithHex:@"2C3036"];
    self.fansView.backgroundColor = [[CPTThemeConfig shareManager] CircleUserCenterMiddleBtnBackgroundColor];
    self.attentionView.backgroundColor = [[CPTThemeConfig shareManager] CircleUserCenterMiddleBtnBackgroundColor];
    self.replayView.backgroundColor = [[CPTThemeConfig shareManager] CircleUserCenterMiddleBtnBackgroundColor];
    self.headView.backgroundColor = MAINCOLOR;
//    self.view.backgroundColor = MAINCOLOR;
    [self.mytableView registerClass:[CircleCommentListCell class] forCellReuseIdentifier:RJCellIdentifier];
    [self.mytableView registerClass:[CirclelistCell class] forHeaderFooterViewReuseIdentifier:RJHeaderIdentifier];
    self.mytableView.dataSource = self;
    self.mytableView.delegate = self;
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.55);
    self.mytableView.tableHeaderView = self.headView;
    self.headbagimgv.image = [[CPTThemeConfig shareManager] CircleUderCenterTopImage];
    
    if (@available(iOS 11.0, *)) {
        self.mytableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets =NO;
    }
    
    
    self.mytableView.backgroundColor = [[CPTThemeConfig shareManager] RootVC_ViewBackgroundC];
        
    if (self.member && [Person person].uid.integerValue != self.member.memberId) {
        
        self.replayView.hidden = YES;

        self.replyViewWidth.constant = 0;
        self.fansViewWidth.constant = SCREEN_WIDTH/2;
        self.attentionViewWidth.constant = SCREEN_WIDTH/2;
        self.attentionViewLine.hidden = YES;
        [self.headimgv sd_setImageWithURL:IMAGEPATH(self.member.heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
        self.namelab.text = self.member.nickname;
        self.fansnumlab.text = INTTOSTRING(self.member.fansNumber);
        self.attentionnumlab.text = INTTOSTRING(self.member.focusNumner);
        @weakify(self)
        [self rigBtn:@"举报" Withimage:nil With:^(UIButton *sender) {
            @strongify(self)
            [self report];
        }];
        
        [self initreportData];
    }
    else {
        self.fansViewWidth.constant = SCREEN_WIDTH/3;
        self.attentionViewWidth.constant = SCREEN_WIDTH/3;
        self.replyViewWidth.constant = SCREEN_WIDTH/3;
        @weakify(self)
        [self rigBtn:nil Withimage:[[CPTThemeConfig shareManager] PostCircleImageName] With:^(UIButton *sender) {
            @strongify(self)

            PostCirCleCtrl *post = [[PostCirCleCtrl alloc]init];
            post.updatacircleBlock = ^{
                @strongify(self)
                [self.mytableView.mj_header beginRefreshing];
            };
            
            [self.navigationController pushViewController:post animated:YES];
        }];
        [self.headimgv sd_setImageWithURL:IMAGEPATH([Person person].heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
        self.namelab.text = [Person person].nickname;
        self.replaynumlab.text = INTTOSTRING(self.replynum);
        [self getfansandattentionnumData];
        
        [self.fansView tapHandle:^{
            @strongify(self)
            FansListCtrl *list = [[FansListCtrl alloc]init];
            list.type = 1;
            PUSH(list);
        }];
        
        [self.attentionView tapHandle:^{
            @strongify(self)
            FansListCtrl *list = [[FansListCtrl alloc]init];
            list.type = 2;
            PUSH(list);
        }];
    }
    
    self.page = 1;
    @weakify(self)

    self.mytableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        
        [self initData];
    }];
    
    self.mytableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self.page++;
        
        [self initData];
    }];
    
    [self initData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getfansandattentionnumData) name:@"UPDATAFANSCOUNT" object:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataScoure.count;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CircleModel *model = [self.dataScoure objectAtIndex:section];
    
    return model.postCommentsVOList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CircleModel *model = [self.dataScoure objectAtIndex:section];
    
    return [CirclelistCell getHeight:model];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CircleModel *model = [self.dataScoure objectAtIndex:section];
    CirclelistCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:RJHeaderIdentifier];
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, [CirclelistCell getHeight:model]);
    
    cell.backgroundColor = WHITE;

    @weakify(self)
    if (self.member && [Person person].uid.integerValue != self.member.memberId) {
        
        [cell.headimgv longtapHandle:^{
            @strongify(self)
            [AlertSheetTool AlertSheetToolWithCancelTitle:@"取消" otherItemArrays:@[@"屏蔽",@"举报"] viewController:self handler:^(NSInteger index) {
                @strongify(self)
                if (index == 1) {
                    [self shieldUser:model.postMember.memberId];
                }
                else if (index == 2) {
                    [self showreportView:model.postMember.memberId];
                }
            }];
        }];
    }
    cell.circleClickBlock = ^(NSInteger click,UIButton *sender) {
        @strongify(self)
        if (click == 1) { //点赞
            
            [self deleteCircle:1 WithpostId:model withbtn:sender];
        }
        else if (click == 2) { //品论
            
            //            [self.keyboard setHidden:NO];
            //            if (self.postId != model.circlePost.ID) {
            //
            //                self.keyboard.textView.text = nil;
            //            }
            //            [self.keyboard.textView becomeFirstResponder];
            //            self.postId = model.circlePost.ID;
            
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
            [self attentionClick:model.postMember];
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
    foot.backgroundColor = [[CPTThemeConfig shareManager] Circle_FooterViewLine_BackgroundC];

    return foot;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CircleModel *model = [self.dataScoure objectAtIndex:indexPath.section];
    
    PostCommentsVOList *comm = [model.postCommentsVOList objectAtIndex:indexPath.row];
    
    CGFloat h = [Tools createLableHighWithString:comm.commentsContent andfontsize:15 andwithwidth:SCREEN_WIDTH - 20];
    
    return h + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CircleCommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    
    cell.backgroundColor = [UIColor colorWithHex:@"2C3036"];
    cell.backgroundColor = [[CPTThemeConfig shareManager] Circle_Cell_Commit_BackgroundC];
    cell.textLabel.textColor = [[CPTThemeConfig shareManager] Circle_Cell_Commit_TitleC];
    
    CircleModel *model = [self.dataScoure objectAtIndex:indexPath.section];
    
    PostCommentsVOList *comm = [model.postCommentsVOList objectAtIndex:indexPath.row];
    
    NSString *name = comm.commentsNickname;
    NSString *content = comm.commentsContent;
    NSString *replacename = comm.commentsReplyNickname;
    
    if (replacename.length) {
        
        NSMutableAttributedString *contentattr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@回复%@:%@",name,replacename,content]];
        
//        [contentattr addAttribute:NSForegroundColorAttributeName value:kRGB(45, 85, 138) range:NSMakeRange(0, name.length)];
        
//        [contentattr addAttribute:NSForegroundColorAttributeName value:kRGB(45, 85, 138) range:NSMakeRange(name.length + 2, replacename.length)];
        
        cell.textLabel.attributedText = contentattr;
        
        cell.textLabel.font = FONT(15);
    }
    else{
        NSMutableAttributedString *contentattr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@:%@",name,content]];
        
//        [contentattr addAttribute:NSForegroundColorAttributeName value:kRGB(45, 85, 138) range:NSMakeRange(0, name.length + 1)];
        
        cell.textLabel.attributedText = contentattr;
        
        cell.textLabel.font = FONT(15);
    }
    
    
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CircleModel *model = [self.dataScoure objectAtIndex:indexPath.section];
    
    PostCommentsVOList *comm = [model.postCommentsVOList objectAtIndex:indexPath.row];
    
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
-(void)showreportView:(NSInteger)menberId {
    @weakify(self)
    ReportView *report = [[ReportView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, 0)];
    
    report.reprotData = self.reprotArray.copy;
    
    report.selectRortBlock = ^(NSDictionary *report) {
        @strongify(self)
        PostCirCleCtrl *post = [[PostCirCleCtrl alloc]init];
        post.memberId = menberId;
        post.reportDic = report;
        PUSH(post);
    };
    
    [report show];
}

#pragma mark - 举报
-(void)report {
    
    [self showreportView:self.member.memberId];
}

#pragma mark - 获取举报列表
-(void)initreportData {
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/getPostReportType" params:nil success:^(BaseData *data) {
        @strongify(self)
        self.reprotArray = data.data;
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 获取圈子列表
-(void)initData {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:@(self.page) forKey:@"pageNum"];
    [dic setValue:pageSize forKey:@"pageSize"];
    if (self.member) {
        
        [dic setValue:@(5) forKey:@"type"];
        [dic setValue:@(self.member.memberId) forKey:@"memberId"];
    }
    else{
        [dic setValue:@(4) forKey:@"type"];
    }
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/listPost" params:dic success:^(BaseData *data) {
        @strongify(self)
        if (self.page == 1) {
            
            [self.dataScoure removeAllObjects];
        }
        
        NSArray *array = [CircleModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.dataScoure addObjectsFromArray:array];
        
        [self.mytableView.mj_header endRefreshing];
        [self.mytableView.mj_footer endRefreshing];
        
        [self.mytableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        [self.mytableView.mj_header endRefreshing];
        [self.mytableView.mj_footer endRefreshing];
    }];
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
        [MBProgressHUD showSuccess:data.info];
        
        self.keyboard.textView.text = nil;
        
        self.page = 1;
        
        [self initData];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 关注
-(void)attentionClick:(PostMember *)member {
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/focusOrCancle" params:@{@"memberId":@(member.memberId),@"type":@(member.isFocus + 1)} success:^(BaseData *data) {
        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)
            [self.tableView.mj_header beginRefreshing];
        }];
        
    } failure:^(NSError *error) {
        
        
    } showHUD:NO];
}

#pragma mark - 1点赞 2删除
-(void)deleteCircle:(NSInteger)type WithpostId:(CircleModel *)model withbtn:(UIButton *)sender {
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/praiseOrDelPost" params:@{@"postId":@(model.circlePost.ID),@"type":@(type)} success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info finish:^{
            if (type == 1) {
                
                model.circlePost.meHasPraise = 1;
                sender.selected = YES;
                NSInteger num = model.circlePost.praiseNumber + 1;
                model.circlePost.praiseNumber = num;
//                [sender setTitle:INTTOSTRING(model.circlePost.praiseNumber) forState:UIControlStateNormal];
                NSString *tpm = [NSString stringWithFormat:@" %ld ",(long)model.circlePost.praiseNumber];
                [sender setTitle:tpm forState:UIControlStateNormal];
            }
            else{
                @strongify(self)
                [self.mytableView.mj_header beginRefreshing];
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
            [self.mytableView.mj_header beginRefreshing];
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
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

        @weakify(self)
        _keyboard.sendBlock = ^(NSString *text) {
            if ([Tools isEmptyOrNull:text]) {
                [MBProgressHUD showError:@"请输入评论内容"];
                return;
            }
            @strongify(self)
            [self postComment:text Withuid:self.commentsId];
            [self.keyboard.textView resignFirstResponder];
            [self.keyboardControl removeFromSuperview];
            [self.keyboard removeFromSuperview];
        };
        _keyboard.keyboardBlock = ^{
            @strongify(self)
            [self dismiss];
            [self.tableView reloadData];
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
#pragma mark - 获取粉丝数和关注数
-(void)getfansandattentionnumData {
    @weakify(self)
    [WebTools postWithURL:@"/circle/getFansAndFocusNumber" params:nil success:^(BaseData *data) {
        @strongify(self)
        self.fansnumlab.text = [data.data[@"fansNumber"]stringValue];
        self.attentionnumlab.text = [data.data[@"focusNumner"]stringValue];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}


@end
