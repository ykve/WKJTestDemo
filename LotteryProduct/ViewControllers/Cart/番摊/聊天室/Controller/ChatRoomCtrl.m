//
//  ChatRoomCtrl.m
//  LotteryProduct
//
//  Created by pt c on 2019/5/2.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "ChatRoomCtrl.h"
#import "ChatMessageModel.h"
#import "ChatRoomCell.h"
#import "Chat_OrderListModel.h"
#import "Chat_OrderCell.h"
#import "Chat_OrderCell.h"
#import "ChatRoomCell_right.h"
#import "SendOrderListCell.h"
#import "ForrowOrderViewController.h"
#import "Chat_OrderCell_right.h"
#import "BallTool.h"
#import <IQKeyboardManager.h>
#import "NavigationVCViewController.h"
#import "LoginAlertViewController.h"
#import "HongBaoRootVC.h"
#import "ChatHongbaoGetAlert.h"
#import "ChatSentHongbaoView.h"
#import "ChatHongbaoTopView.h"
#import "ChatHongbaoReciviced.h"
#import "UIViewController+HDHUD.h"
#import "CPTChatManager.h"
#import "HomeActivityAlertView.h"
#import "PublicInterfaceTool.h"

@interface ChatRoomCtrl ()
{
    CPTChatManager *_manager;
    BOOL _isBan;
    BOOL _getOrderAlready;
    NSTimeInterval _lateTime;//上次发送成功的时间
    BOOL _currentIsInBottom;
}

@property (strong, nonatomic) UITableView *chatTableView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UILabel *emergencyLabel;
@property (strong, nonatomic) UIButton *sendBtn;
@property (strong, nonatomic) UITableView *orderListTableView;

@property (assign, nonatomic) CGFloat headerHeight;

@end

@implementation ChatRoomCtrl
{
    NSMutableArray *_dataArr;
    NSInteger _orderPage;
    
    NSMutableArray *_orderListArr;
}

-(void)popback{
    [[CPTChatManager shareManager] cannelBlock];
    [self removeBlock];
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)showHongBaoJilu{
    @weakify(self)
    [self rigBtn:@"红包记录" Withimage:nil With:^(UIButton *sender) {
        @strongify(self)
        if ([Person person].uid == nil) {
            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:login animated:YES completion:nil];
            login.loginBlock = ^(BOOL result) {
                
            };
            return;
        }
        HongBaoRootVC * vc = [[HongBaoRootVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    _selectedSegmentIndex = selectedSegmentIndex;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CPTChatManager shareManager] openSocket];
    if(self.isFormHome){
        self.navView.hidden = NO;
        [self showHongBaoJilu];
    }else{
        self.navView.hidden = YES;
    }
    
    _currentIsInBottom = YES;
    _selectedSegmentIndex = 1001;
    _manager = [CPTChatManager shareManager];
    _headerHeight = 0;
    
    _orderPage = 1;
    self.titlestring = self.roomName;
    _dataArr = [NSMutableArray array];
    _orderListArr = [NSMutableArray array];
    //    [self startMQTT];
    [self getLastestRecord];
    
    [self setupUI];
    [self initTableView];
    [self.view bringSubviewToFront:_topView];
    
    [self chatInfo];
    
    
    //通知类型 0 信息 1 公告  2 删除信息 3 聊天红包 4 聊天室人数 5新红包提醒
    //    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kLoginSuccessNotification object:nil];
    
    

    _sendBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_ChatRoomt_SendBtnBack];
    [self loadTotlePeople];
    [self loadHongbaoData];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noTalkingAction) name:kNoTalkingNotification object:nil];
}

- (void)setupUI {
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor colorWithHex:@"7F7F7F" Withalpha:0.8];
    [self.view addSubview:topView];
    _topView = topView;
   
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.offset(0);
        make.height.mas_equalTo(self.headerHeight);
    }];
    
    UILabel *emergencyLabel = [[UILabel alloc] init];
    emergencyLabel.font = [UIFont systemFontOfSize:13];
    emergencyLabel.textColor = [UIColor whiteColor];
    emergencyLabel.numberOfLines = 0;
    emergencyLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:emergencyLabel];
    _emergencyLabel = emergencyLabel;
    
    [emergencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    
    [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
        if(!self.isFormHome){
            make.top.offset(0);
        }else{
            make.top.offset(NAV_HEIGHT);
        }
    }];
    
    UIView *bootomView = [[UIView alloc] init];
    bootomView.backgroundColor = [UIColor colorWithHex:@"#F8F8F8"];
    [self.view addSubview:bootomView];
    
    [bootomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kiPhoneX_Bottom_Height);
        make.height.mas_equalTo(49);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHex:@"CFCFCF"];
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(bootomView.mas_top);
        make.height.mas_equalTo(1);
    }];

    
    
    UIButton *hongbaoBtn = [[UIButton alloc] init];
    [hongbaoBtn addTarget:self action:@selector(clickHongBao:) forControlEvents:UIControlEventTouchUpInside];
    [hongbaoBtn setImage:[UIImage imageNamed:@"lt_hb_icon"] forState:UIControlStateNormal];
    hongbaoBtn.backgroundColor = [UIColor clearColor];
    [bootomView addSubview:hongbaoBtn];
    
    [hongbaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(bootomView);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *sendBtn = [[UIButton alloc] init];
    [sendBtn setTitle:@"发推单" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sendBtn.backgroundColor = [UIColor colorWithHex:@"#5DADFF"];
    sendBtn.layer.cornerRadius = 5;
    [bootomView addSubview:sendBtn];
    _sendBtn = sendBtn;
    
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bootomView.mas_centerY);
        make.right.equalTo(bootomView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(65, 35));
    }];
    
    
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;  //边框类型
    textField.font = [UIFont systemFontOfSize:14.0];  // 字体
    textField.textColor = [UIColor colorWithHex:@"333333"];  // 字体颜色
    textField.placeholder = @"请输入你的"; // 占位文字
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeDefault; // 键盘类型
    textField.returnKeyType = UIReturnKeyGo;
    [bootomView addSubview:textField];
    _textField = textField;
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bootomView.mas_centerY);
        make.left.equalTo(hongbaoBtn.mas_right);
        make.right.equalTo(sendBtn.mas_left).offset(-15);
        make.height.mas_equalTo(@(35));
    }];
}

#pragma mark - vvUITableView
- (void)initTableView {
    
    CGFloat navHeight = 0;
    if (self.isFormHome) {
        navHeight = Height_NavBar;
    }
    _chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT - Height_NavBar - 50 - kiPhoneX_Bottom_Height) style:UITableViewStylePlain];
    _chatTableView.backgroundColor = [UIColor whiteColor];
    _chatTableView.dataSource = self;
    _chatTableView.delegate = self;
    if (@available(iOS 11.0, *)) {
        _chatTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    // 去除横线
    _chatTableView.separatorStyle = UITableViewCellAccessoryNone;
    _chatTableView.estimatedRowHeight = 0;
    _chatTableView.estimatedSectionHeaderHeight = 0;
    _chatTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_chatTableView];
    
    
    _orderListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, 330) style:UITableViewStylePlain];
    _orderListTableView.backgroundColor = [UIColor whiteColor];
    _orderListTableView.dataSource = self;
    _orderListTableView.delegate = self;
    _orderListTableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    _orderListTableView.estimatedRowHeight =0;
    _orderListTableView.estimatedSectionHeaderHeight =0;
    _orderListTableView.estimatedSectionFooterHeight =0;
    [self.view addSubview:_orderListTableView];
    
    @weakify(self)
    _orderListTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self->_orderPage++;
        [self getOrderList];
    }];
    
}

#pragma mark -  聊天信息
- (void)chatInfo {
    @weakify(self)
    _manager.didReceiveChatMessage = ^(ChatMessageModel * model, NSString * str) {
        @strongify(self);
        
        //        if (self.selectedSegmentIndex == 1000) {
        //            return;
        //        }
        if(model.messageType == 0){
            if([model.userId isEqualToString:[[Person person] uid]]){
                return ;
            }
            [self->_dataArr addObject:model];
            [self.chatTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self->_dataArr.count-1  inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            if(self->_currentIsInBottom){
                [self chatToBottom];
            }
        }else if (model.messageType == 1){
            if(model.status == 1){
                self.headerHeight = 30;
                [UIView animateWithDuration:0.2 animations:^{
                    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(self.headerHeight);
                    }];
                }];
                self.emergencyLabel.text = model.content;
                @weakify(self)
                for(UIView *v in self.view.subviews){
                    if([v isKindOfClass:[ChatHongbaoTopView class]]){
                        [UIView animateWithDuration:0.3 animations:^{
                            @strongify(self)
                            if(!self.isFormHome){
                                v.frame = CGRectMake(0, self.headerHeight,  CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
                            }else{
                                v.frame = CGRectMake(0, NAV_HEIGHT+self.headerHeight, CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
                            }
                        }];
                        break;
                    }
                }
                
            }else{
                self.headerHeight = 0;
                [UIView animateWithDuration:0.2 animations:^{
                    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(self.headerHeight);
                    }];
                }];
                @weakify(self)
                for(UIView *v in self.view.subviews){
                    if([v isKindOfClass:[ChatHongbaoTopView class]]){
                        [UIView animateWithDuration:0.3 animations:^{
                            @strongify(self)
                            if(!self.isFormHome){
                                v.frame = CGRectMake(0, 0,  CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
                            }else{
                                v.frame = CGRectMake(0, NAV_HEIGHT, CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
                            }
                        }];
                        break;
                    }
                }
            }
        }else if (model.messageType == 2){//删除信息
            for(int i = 0;i<self->_dataArr.count;i++){
                ChatMessageModel *mm = self->_dataArr[i];
                if(mm.ID == model.ID){
                    [self->_dataArr removeObject:mm];
                    [self.chatTableView reloadData];
                }
            }
        }else if (model.messageType == 3){//聊天红包个数
            NSInteger money = model.money;
            
        }else if (model.messageType == 4){// 聊天室人数
            NSInteger to = model.totalNumber;
            if(to>0){
                self.titlestring = [NSString stringWithFormat:@"聊天室(%ld)",(long)to];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CHATROOMCountP" object:self.titlestring];
            }
        }else if (model.messageType == 5){// 新红包提醒
            NSInteger money = model.money;
            NSInteger sendNumber = model.sendNumber;
            if(sendNumber>0 && sendNumber>0){
                [self showHongbaoName:model.nickname money:[NSString stringWithFormat:@"%ld",(long)money] count:[NSString stringWithFormat:@"%ld",(long)sendNumber]];
            }
        } else if (model.messageType == 6){  // 聊天室禁入
            if (self.selectedSegmentIndex == 1001) {
                [self alertView];
            }
            
        } else {
            MBLog(@"1");
        }
    };
}

- (void)alertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                             message:kGoInChatRoomMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NavigationVCViewController *nav = (NavigationVCViewController *)self.navigationController;
    [nav removepang];
}
- (void)chatToBottom{
    if(self->_dataArr.count > 0){
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self->_dataArr.count-1 inSection:0];
        [self.chatTableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    _currentIsInBottom = YES;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNoTalkingNotification object:nil];
}
- (void)loginSuccess{
    [self getOrderList];
    [self getSpeakPower];
}
- (void)getSpeakPower{
    @weakify(self);
    [WebTools postWithURL:@"/wechat/chatUserStatus.json" params:nil success:^(BaseData *data) {
        @strongify(self);
        if(data.status.integerValue == 1){
            if([data.data isEqualToString:@"1"]){
                
                self->_isBan = YES;
            }else{
                self->_isBan = NO;
            }
            [self updatePowerStatus];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)updatePowerStatus{
    if(_isBan){
        self.textField.enabled = NO;
        self.textField.placeholder = @"已被禁言";
    }else{
        self.textField.enabled = YES;
        self.textField.placeholder = @"请输入";
    }
}

- (void)clickChat:(UITapGestureRecognizer *)rec{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.2 animations:^{
        _orderListTableViewHeight.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillShow:(NSNotification *)aNotification{
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    NSDictionary *useInfo = [aNotification userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    [UIView animateWithDuration:0.2 animations:^{
        _orderListTableViewHeight.constant = 0;
        _bottomViewToBottomSpace.constant = [value CGRectValue].size.height;
        [self.view layoutIfNeeded];
    }];
    [self chatToBottom];
}
- (void)keyboardWillHide:(NSNotification *)aNotification{
    
    NSDictionary *useInfo = [aNotification userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    [UIView animateWithDuration:0.2 animations:^{
        _bottomViewToBottomSpace.constant = 0;
        [self.view layoutIfNeeded];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _chatTableView){
        return _dataArr.count;
    }else{
        return _orderListArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _chatTableView){
        ChatMessageModel *model = _dataArr[indexPath.row];
        if(model.type == 0){//聊天消息
            if([model.userId isEqualToString:[Person person].uid]){
                ChatRoomCell_right *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatRoomCell_right"];
                if(cell == nil){
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatRoomCell_right" owner:self options:nil]lastObject];
                    
                }
                [cell setDataWithModel:model];
                return cell;
            }else{
                static NSString *cellID = @"ChatRoomCell";
                ChatRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"ChatRoomCell" owner:self options:nil]lastObject];
                }
                [cell setDataWithModel:model];
                return cell;
            }
            
        }else if(model.type == 1){//推单
            if([model.userId isEqualToString:[Person person].uid]){
                static NSString *cellID = @"Chat_OrderCell_right";
                Chat_OrderCell_right *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"Chat_OrderCell_right" owner:self options:nil]lastObject];
                }
                [cell setDataWithModel:model];
                @weakify(self);
                cell.showErrorMessage = ^(NSString * str) {
                    @strongify(self);
                    [self showHint:str];
                };
                return cell;
            }else{
                static NSString *cellID = @"Chat_OrderCell";
                Chat_OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell == nil) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"Chat_OrderCell" owner:self options:nil]lastObject];
                }
                [cell setDataWithModel:model];
                @weakify(self);
                cell.didPushOrder = ^(PushOrderModel * mod) {
                    @strongify(self);
                    ForrowOrderViewController *forrow = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"ForrowOrderViewController"];
                    forrow.model = mod;
                    [self.navigationController pushViewController:forrow animated:YES];
                };
                cell.didReceiveRet = ^(BaseData * data) {
                    //                    @strongify(self);
                    id ret = data.data;
                    if([ret isKindOfClass:[NSString class]]){
                        [MBProgressHUD showSuccess:ret];
                    }
                    
                };
                cell.showErrorMessage = ^(NSString * str) {
                    @strongify(self);
                    [self showHint:str];
                };
                
                return cell;
            }
            
        }
        return [UITableViewCell new];
    }else{//
        static NSString *cellID = @"SendOrderListCell";
        SendOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SendOrderListCell" owner:self options:nil]lastObject];
        }
        Chat_OrderListModel *model = _orderListArr[indexPath.row];
        [cell setDataWithModel:model];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _chatTableView){
        ChatMessageModel *model = _dataArr[indexPath.row];
        if(model.type == 1){//推单
            return 135;
        }else{
            return [BallTool getChatMessageHeightWithString:model.content]+40;
        }
    }
    return 135;
}
- (void)subscibe{
    ////    NSString *topic1 = [NSString stringWithFormat:@"APP_CHATLOTTERY_NOTICE_KEY_%ld",self.lotteryId];
    ////    [_manager subscibeToTopic:topic1];
    ////    NSString *topic2 = [NSString stringWithFormat:@"APP_CLATLOTTERY_KEY_%ld",_lotteryId];
    //    [_manager subscibeToTopic:@"APP_CHAT_KEY"];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self cancelSubscribe];
    self.selectedSegmentIndex = 0;
    
}
- (void)cancelSubscribe{
    ////    NSString *topic = [NSString stringWithFormat:@"APP_CLATLOTTERY_KEY_%ld",_lotteryId];
    //    [_manager cancelSubscibeToTopic:@"APP_CHAT_KEY"];
}
- (void)startMQTT{
    if([_manager nowIsConnected]){
        [self subscibe];
    }else{
        [_manager openSocket];
        [self performSelector:@selector(startMQTT) withObject:nil afterDelay:3];
    }
}

- (void)sendClick:(UIButton *)sender {
    
    if([sender.titleLabel.text isEqualToString:@"发推单"]){
        if(!_getOrderAlready){
            [self getOrderList];
            [self getSpeakPower];
        }
        if(self.orderListTableViewHeight.constant == 0){
            [UIView animateWithDuration:0.2 animations:^{
                self.orderListTableViewHeight.constant = 300;
                [self.view layoutIfNeeded];
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                self.orderListTableViewHeight.constant = 0;
                [self.view layoutIfNeeded];
            }];
        }
        
    }else if ([sender.titleLabel.text isEqualToString:@"发送"]){
        if(![Person person].uid){
            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:login animated:YES completion:nil];
            return;
        }
        if(_lateTime){
            NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
            if(now < _lateTime+3){
                _lateTime = [[NSDate date] timeIntervalSince1970];
                [MBProgressHUD showError:@"发言太过频繁"];
                return;
            }
        }
        if(_textField.text.length!=0){
            
            ChatMessageModel * tmpModel = [[ChatMessageModel alloc] init];
            tmpModel.nickname = [[Person person] nickname];
            tmpModel.content = _textField.text;
            tmpModel.userId = [[Person person] uid];
            tmpModel.head = [[Person person] heads];
            [self->_dataArr addObject:tmpModel];
            [self.chatTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self->_dataArr.count-1  inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            CGFloat height = self.chatTableView.frame.size.height;
            CGFloat contentOffsetY = self.chatTableView.contentOffset.y;
            CGFloat bottomOffset = self.chatTableView.contentSize.height - contentOffsetY;
            if (bottomOffset <= height)
            {
                //在最底部
                
            }
            //滚动到底部
            [self chatToBottom];
            self.textField.text = @"";
            
            @weakify(self)
            NSDictionary *dic = @{@"content":tmpModel.content,@"type":@(0),@"lotteryId":@(_lotteryId)};
            [WebTools postWithURL:@"/wechat/sendOut.json" params:dic success:^(BaseData *data) {
                @strongify(self)
                if(data.status.integerValue == 1){
                    self->_lateTime = [[NSDate date] timeIntervalSince1970];
                    MBLog(@"%@",data.data);
                    self.textField.text = @"";
                    //                    [self.view endEditing:YES];
                    //                    if(![[CPTChatManager shareManager] nowIsConnected]){
                    //                        [self getLastestRecord];
                    //                    }
                }else if(data.status.integerValue == 1101){//被禁言
                    self->_isBan = YES;
                    [self updatePowerStatus];
                    [self showHint:data.info];
                }else{
                    [self showHint:data.info];
                }
            } failure:^(NSError *error) {
                MBLog(@"1");
            }showHUD:NO];
            
        }else{
            [self showHint:@"请输入聊天内容"];
        }
    }
    MBLog(@"----");
}

- (void)noTalkingAction {
    [self->_dataArr removeLastObject];
    [self.chatTableView reloadData];
}

- (void)getOrderList{
    @weakify(self)
    [WebTools postWithURL:@"/wechat/getPushOrderList.json" params:@{@"pageNum":@(_orderPage),@"pageSize":pageSize,@"lotteryId":@(self.lotteryId)} success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            self->_getOrderAlready = YES;
            MBLog(@"%@",data.data);
            if(self->_orderPage == 1){
                [self->_orderListArr removeAllObjects];
            }
            id ret = data.data;
            if([ret isKindOfClass:[NSArray class]]){
                NSArray *arr = ret;
                if(arr.count == 0&&self->_orderPage > 1){
                    self->_orderPage --;
                    [self.orderListTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.orderListTableView.mj_footer endRefreshing];
                }
                if(self->_orderPage == 1&&arr.count == 0){
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 20, 60, 50)];
                    imgView.image = [UIImage imageNamed:@"no_order"];
                    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.orderListTableView.frame.size.height)];
                    [bgView addSubview:imgView];
                    self.orderListTableView.backgroundView = bgView;
                    self.orderListTableView.mj_footer.hidden = YES;
                }else{
                    self.orderListTableView.mj_footer.hidden = NO;
                    self.orderListTableView.backgroundView = nil;
                }
                for (NSDictionary *dic in data.data) {
                    Chat_OrderListModel *model = [Chat_OrderListModel mj_objectWithKeyValues:dic];
                    [self->_orderListArr addObject:model];
                }
                [self->_orderListTableView reloadData];
                
            }
            
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)getLastestRecord{
    NSDictionary *dic = @{@"pageNum":@(1),@"pageSize":@(50),@"lotteryId":@(self.lotteryId)};
    @weakify(self)
    [WebTools postWithURL:@"/wechat/chatInfoList.json" params:dic success:^(BaseData *data) {
        //        MBLog(@"%@",data.data);
        @strongify(self)
        if(data.status.integerValue == 1){
            id arr = data.data;
            if(!_dataArr){
                return ;
            }
            if([arr isKindOfClass:[NSArray class]]){
                [self->_dataArr removeAllObjects];
                for (NSDictionary *dic in data.data) {
                    ChatMessageModel *model = [ChatMessageModel mj_objectWithKeyValues:dic];
                    model.orderModel = [OrderModel mj_objectWithKeyValues:model.pushOrderContentVO];
                    [self->_dataArr addObject:model];
                }
            }
            [self.chatTableView reloadData];
            if(self->_dataArr.count){
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self->_dataArr.count-1 inSection:0];
                [self->_chatTableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionNone animated:NO];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _orderListTableView){
        Chat_OrderListModel *model = _orderListArr[indexPath.row];
        @weakify(self)
        NSDictionary *dic = @{@"content":_textField.text,@"type":@(1),@"lotteryId":@(_lotteryId),@"trackId":model.pushOrderId};
        [WebTools postWithURL:@"/wechat/sendOut.json" params:dic success:^(BaseData *data) {
            @strongify(self)
            if(data.status.integerValue == 1){
                MBLog(@"%@",data.data);
                self.textField.text = @"";
            }
        } failure:^(NSError *error) {
            
        }];
    }
}
- (void)setFrameWithView:(UIView *)view{
    
}

- (void)showHongbaoName:(NSString *)name money:(NSString *)money count:(NSString *)count{
    @weakify(self)
    
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        
        ChatHongbaoGetAlert *vc = [[[NSBundle mainBundle]loadNibNamed:@"ChatHongbaoGetAlert" owner:self options:nil]firstObject];
        vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [vc showInView:self.view name:name money:money count:count];
        [self checkIsNeedLoadHongbao];
    });
}

- (void)checkIsNeedLoadHongbao{
    BOOL isOK = NO;
//    for(UIView *v in self.view.subviews){
//        if([v isKindOfClass:[ChatHongbaoTopView class]]){
//            isOK = YES;
//            break;
//        }
//    }
    if(!isOK){
        [self loadHongbaoData];
    }
}

- (void)clickHongBao:(id)sender{
    
    
    __weak __typeof(self)weakSelf = self;
    [PublicInterfaceTool getWechatInfoSuccess:^(BaseData * _Nonnull data) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if ([data.data[@"chatRoomPack"] integerValue] == 1) {
            [MBProgressHUD showError:kClickSendRedEnvelopeMessage];
        } else {
            [strongSelf gotoHongBao];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:kClickSendRedEnvelopeMessage];
    }];
    
    
    
}

- (void)gotoHongBao {
    __weak ChatSentHongbaoView *vc = [[[NSBundle mainBundle]loadNibNamed:@"ChatSentHongbaoView" owner:self options:nil]firstObject];
    vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [vc show];
    @weakify(self)
    [vc setClickOKBtn:^(NSInteger money, NSInteger count) {
        @strongify(self)
        [WebTools postWithURL:@"/chatPack/sendRedPack.json" params:@{@"number":@(count),@"money":@(money)} success:^(BaseData *data) {
            @strongify(self)
            if(data.status.integerValue == 1){
                MBLog(@"%@",data.data);
                //                [MBProgressHUD showSuccess:@"发送成功！"];
                [vc dismiss];
                [self checkIsNeedLoadHongbao];
            }
        } failure:^(NSError *error) {
            
        }];
    }];
    
    //    [AppDelegate shareapp].chatSentHongbaoView = vc;
}

- (void)loadHongbaoData{
    @weakify(self)
    [WebTools postWithURL:@"/chatPack/chatPackInfo.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            MBLog(@"%@",data.data);
            NSDictionary *dic = data.data;
            if([dic[@"money"] floatValue]<=0.5){
                return ;
            }
            for(UIView *v in self.view.subviews){
                if([v isKindOfClass:[ChatHongbaoTopView class]]){
                    return ;
                    break;
                }
            }
            
            ChatHongbaoTopView *hbTopV = [[[NSBundle mainBundle]loadNibNamed:@"ChatHongbaoTopView" owner:self options:nil]firstObject];
            if(self.isFormHome){
                hbTopV.frame = CGRectMake(SCREEN_WIDTH, self.headerHeight+NAV_HEIGHT, SCREEN_WIDTH, 55);
            }else{
                hbTopV.frame = CGRectMake(SCREEN_WIDTH, self.headerHeight, SCREEN_WIDTH, 55);
            }
            NSInteger hbID = [dic[@"id"] integerValue];
            hbTopV.hbID = hbID;
            [hbTopV.headImageV sd_setImageWithURL:[NSURL URLWithString:dic[@"head"]] placeholderImage:IMAGE(@"头像")];
            hbTopV.nickLab.text = dic[@"nickname"];
            hbTopV.moneyLab.text = [NSString stringWithFormat:@"%.2f元",[dic[@"money"] floatValue]];
            NSInteger totle = [dic[@"sendNumber"] integerValue];
            NSInteger current = [dic[@"holdNumber"] intValue];
            hbTopV.countLab.text = [NSString stringWithFormat:@"剩余：%d/%d",totle-current,totle];
            [hbTopV showInView:self.view];
            [hbTopV setClickOKBtn:^(CGFloat money) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    HomeActivityAlertView *vc = [[[NSBundle mainBundle]loadNibNamed:@"HomeActivityAlertView" owner:self options:nil]firstObject];
                    vc.actID = @(hbID);
                    vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                    [vc showView:self.view some:@(money)];
                    [vc setClickOKBtn:^{
                        [self checkIsNeedLoadHongbao];
                    }];
                });
                //                    ChatHongbaoReciviced * rv = [[[NSBundle mainBundle]loadNibNamed:@"ChatHongbaoReciviced" owner:self options:nil]firstObject];
                //                    rv.moneyLab.text = [NSString stringWithFormat:@"%.2f元",money];
                ////                    rv.center = self.view.center;
                //                    [rv show];
                //                    [rv setClickOKBtn:^{
                //                        [self checkIsNeedLoadHongbao];
                //                    }];
            }];
            
            
        }else{
            //            [self checkIsNeedLoadHongbao];
        }
    } failure:^(NSError *error) {
    } showHUD:NO];
}

- (void)loadTotlePeople{
    @weakify(self)
    [WebTools postWithURL:@"/wechat/initInfo.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            MBLog(@"%@",data.data);
            if([data.data isKindOfClass:[NSDictionary class]]){
                NSDictionary *dic = data.data;
                NSInteger to = [dic[@"tatolNumber"] integerValue];
                if(to>0){
                    self.titlestring = [NSString stringWithFormat:@"聊天室(%ld)",(long)to];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHATROOMCountP" object:self.titlestring];
                }
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if ((bottomOffset-200) <= height) {
        _currentIsInBottom = YES;
    } else {
        _currentIsInBottom= NO;
    }
}

@end
