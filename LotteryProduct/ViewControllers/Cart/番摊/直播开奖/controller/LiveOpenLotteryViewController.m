//
//  LiveOpenLotteryViewController.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/15.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "LiveOpenLotteryViewController.h"
#import "ChatRoomCtrl.h"
#import "Chat_OrderListModel.h"
#import "ChatRoomCell_right.h"
#import "ChatRoomCell.h"
#import "Chat_OrderCell_right.h"
#import "Chat_OrderCell.h"
#import "ForrowOrderViewController.h"
#import "SendOrderListCell.h"
#import "LiveListCell.h"
#import <WebKit/WebKit.h>
#import "BallTool.h"
#import "LoginAlertViewController.h"
#import "UIViewController+HDHUD.h"
#import "LoginAlertViewController.h"
#import "HongBaoRootVC.h"
#import "ChatHongbaoGetAlert.h"
#import "ChatSentHongbaoView.h"
#import "ChatHongbaoTopView.h"
#import "ChatHongbaoReciviced.h"
#import "CPTChatManager.h"
#import "PublicInterfaceTool.h"

#define kOpenViewHeight 210
@interface LiveOpenLotteryViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation LiveOpenLotteryViewController
{
    CPTChatManager *_manager;
//    ChatRoomCtrl *chatVC;
    NSMutableArray *_dataArr;
    NSInteger _orderPage;
    NSInteger _livePage;

    NSMutableArray *_orderListArr;
    BOOL _isBan;
    NSMutableArray *_liveListArr;
    BOOL _getOrderAlready;
    NSTimeInterval _lateTime;
    BOOL _currentIsInBottom;

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

- (void)subscibe{
//    [_manager subscibeToTopic:@"kj_xglhc_recommend"];
////    NSString *topic2 = [NSString stringWithFormat:@"APP_CLATLOTTERY_KEY_%ld",self.lotteryId];
//    [_manager subscibeToTopic:@"APP_CHAT_KEY"];
}
- (void)cancelSubscribe{
//    //    NSString *topic = [NSString stringWithFormat:@"APP_CLATLOTTERY_KEY_%ld",_lotteryId];
//    [_manager cancelSubscibeToTopic:@"kj_xglhc_recommend"];
//    [_manager cancelSubscibeToTopic:@"APP_CHAT_KEY"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self cancelSubscribe];
}
- (void)chatToBottom{
    if(self->_dataArr.count!=0){
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self->_dataArr.count-1 inSection:0];
        [self.chatTableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[CPTChatManager shareManager] openSocket];
    _currentIsInBottom = YES;
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_Dark){
        self.bottomBtn.backgroundColor = [UIColor colorWithHex:@"9E2D32"];
    }else if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        self.bottomBtn.backgroundColor = [UIColor colorWithHex:@"25749F"];
    }
    _manager = [CPTChatManager shareManager];
    @weakify(self)
    _manager.connectSuccess = ^{
        @strongify(self)
        [self subscibe];
    };
    _dataArr = [NSMutableArray array];
    _orderListArr = [NSMutableArray array];
    _liveListArr = [NSMutableArray array];
    _orderPage = 1;
    _livePage = 1;
    self.titlestring = @"直播开奖";
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLiveView:)];
//    [_liveBgView addGestureRecognizer:tap];

    [self startMQTT];
    
    [self getLastestRecord];
//    [self getOrderList];
//    [self getSpeakPower];
    _manager.didReceiveChatMessage = ^(ChatMessageModel * model, NSString * str) {
        @strongify(self);
//        if(model.messageType == 0){
//            [self->_dataArr addObject:model];
//            [self.chatTableView reloadData];
//            CGFloat height = self.chatTableView.frame.size.height;
//            CGFloat contentOffsetY = self.chatTableView.contentOffset.y;
//            CGFloat bottomOffset = self.chatTableView.contentSize.height - contentOffsetY;
//            if (bottomOffset <= height)
//            {
//                //在最底部
//
//            }
//            //滚动到底部
//            [self chatToBottom];
//        }else if(str.integerValue == 1){
//            if(self){
//                [self->_dataArr addObject:model];
//                [self->_chatTableView reloadData];
//                [self updateMessageTableView];
//            }
//        }else if (model.messageType == 4){//
//            NSInteger to = model.totalNumber;
//            if(to>0){
//                self.chatTitleLabel.text = [NSString stringWithFormat:@"聊天室(%ld)",(long)to];
//            }
//        }else if (model.messageType == 5){//
//            NSInteger money = model.money;
//            NSInteger sendNumber = model.sendNumber;
//            if(sendNumber>0 && sendNumber>0){
//                [self showHongbaoName:model.nickname money:[NSString stringWithFormat:@"%ld",(long)money] count:[NSString stringWithFormat:@"%ld",(long)sendNumber]];
//            }
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
//            if(model.status == 1){
//                [UIView animateWithDuration:0.2 animations:^{
//                    self.headerHeight.constant = 30;
//                    [self.view layoutIfNeeded];
//                }];
//                self.emergencyLabel.text = model.content;
//                @weakify(self)
//                for(UIView *v in self.view.subviews){
//                    if([v isKindOfClass:[ChatHongbaoTopView class]]){
//                        [UIView animateWithDuration:0.3 animations:^{
//                            @strongify(self)
//                            if(!self.isFormHome){
//                                v.frame = CGRectMake(0, self.headerHeight.constant,  CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
//                            }else{
//                                v.frame = CGRectMake(0, NAV_HEIGHT+self.headerHeight.constant, CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
//                            }
//                        }];
//                        break;
//                    }
//                }
//
//            }else{
//                [UIView animateWithDuration:0.2 animations:^{
//                    self.headerHeight.constant = 0;
//                    [self.view layoutIfNeeded];
//                }];
//                @weakify(self)
//                for(UIView *v in self.view.subviews){
//                    if([v isKindOfClass:[ChatHongbaoTopView class]]){
//                        [UIView animateWithDuration:0.3 animations:^{
//                            @strongify(self)
//                            if(!self.isFormHome){
//                                v.frame = CGRectMake(0, 0,  CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
//                            }else{
//                                v.frame = CGRectMake(0, NAV_HEIGHT, CGRectGetWidth(v.frame), CGRectGetHeight(v.frame));
//                            }
//                        }];
//                        break;
//                    }
//                }
//            }
        }else if (model.messageType == 2){//删除
            for(int i = 0;i<self->_dataArr.count;i++){
                ChatMessageModel *mm = self->_dataArr[i];
                if(mm.ID == model.ID){
                    [self->_dataArr removeObject:mm];
                    [self.chatTableView reloadData];
                }
            }
        }else if (model.messageType == 4){//
            NSInteger to = model.totalNumber;
            if(to>0){
                self.chatTitleLabel.text = [NSString stringWithFormat:@"聊天室(%ld)",(long)to];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CHATROOMCountP" object:self.chatTitleLabel.text];
            }
        }else if (model.messageType == 5){//
            NSInteger money = model.money;
            NSInteger sendNumber = model.sendNumber;
            if(sendNumber>0 && sendNumber>0){
                [self showHongbaoName:model.nickname money:[NSString stringWithFormat:@"%ld",(long)money] count:[NSString stringWithFormat:@"%ld",(long)sendNumber]];
            }
        }
    };
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
    _orderListTableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    _orderListTableView.estimatedRowHeight =0;
    _orderListTableView.estimatedSectionHeaderHeight =0;
    _orderListTableView.estimatedSectionFooterHeight =0;
    _orderListTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self->_orderPage++;
        [self getOrderList];
    }];
    _listTabelView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    _listTabelView.estimatedRowHeight =0;
    _listTabelView.estimatedSectionHeaderHeight =0;
    _listTabelView.estimatedSectionFooterHeight =0;
    _listTabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self->_livePage++;
        [self getRecommendsList];
    }];
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChat:)];
//    [_chatTableView addGestureRecognizer:tap1];
    _chatTableView.estimatedRowHeight =0;
    _chatTableView.estimatedSectionHeaderHeight =0;
    _chatTableView.estimatedSectionFooterHeight =0;
    [self getRecommendsList];
    [self hiddenChatViewWithAnimate:NO];
    [self buildWebView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kLoginSuccessNotification object:nil];
    
    
    _sendBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_LiveLot_BottomBtnBack];
    _chatTitleBgView.backgroundColor = [[CPTThemeConfig shareManager] CO_LiveLot_BottomBtnBack];
    [_bottomBtn setBackgroundColor:[[CPTThemeConfig shareManager] CO_LiveLot_BottomBtnBack]];
    
    if(self.pureChat){
        _chatTitleHeight.constant = 0;
        CGFloat bom = SAFE_TO_BOTTOM?25:0;
        _chatBgHeight.constant = SCREEN_HEIGHT-NAV_HEIGHT-SAFE_TO_BOTTOM+bom;
        _topSafeArea.constant = -kOpenViewHeight;
        self.titlestring = @"聊天室";
    }
    [self loadHongbaoData];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];

}
- (void)updateMessageTableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.chatTableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArr.count - 1 inSection:0];
        // 判断是否可以滚动到最后一条消息
        if (indexPath.row < [self.chatTableView numberOfRowsInSection:0]) {
            [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    });
}
- (void)loginSuccess{
    [self getOrderList];
    [self getSpeakPower];
}
- (void)buildWebView{
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kOpenViewHeight)];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.userInteractionEnabled = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:LIVE_H5]]];
    [self.liveBgView addSubview:self.webView];
}
#pragma mark 直播推单
- (void)getRecommendsList{
    @weakify(self)
    NSDictionary *dic = @{@"pageNum":@(_livePage),@"pageSize":@(10)};
    [WebTools postWithURL:@"/lhcSg/getLhcRecommends.json" params:dic success:^(BaseData *data) {
        @strongify(self);
        if(data.status.integerValue == 1){
            if([data.data isKindOfClass:[NSDictionary class]]){
                NSDictionary *dic = (NSDictionary *)data.data;
                if([dic.allKeys containsObject:@"list"]){
                    if(self->_livePage == 1){
                        [self->_liveListArr removeAllObjects];
                    }
                    NSArray *arr = dic[@"list"];
                    if(self->_livePage != 1&&arr.count == 0){
                        [self.listTabelView.mj_footer endRefreshingWithNoMoreData];
                    }
                    
                    for (NSDictionary *dd in arr) {
                        LiveListModel *model = [LiveListModel mj_objectWithKeyValues:dd];
                        [self->_liveListArr addObject:model];
                    }
                    [self.listTabelView reloadData];
                }
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)liveListEndRefresh{
    [_listTabelView.mj_footer endRefreshing];
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
    
    [UIView animateWithDuration:0.2 animations:^{
        _orderListTableViewHeight.constant = 0;
        [self.view layoutIfNeeded];
    }];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSuccessNotification object:nil];
    MBLog(@"dealloc");
}
- (void)keyboardWillHide:(NSNotification *)aNotification{

}


- (IBAction)sendClick:(UIButton *)sender {
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
            [self getRecommendsList];
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
                
            }showHUD:NO];
            
        }else{
            [self showHint:@"请输入聊天内容"];
        }
    }
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
- (void)startMQTT{
    if([_manager nowIsConnected]){
        [self subscibe];
    }else{
        [_manager openSocket];
        [self performSelector:@selector(startMQTT) withObject:nil afterDelay:3];
    }
}
- (void)tapLiveView:(UITapGestureRecognizer *)tap{
    [self hiddenChatViewWithAnimate:YES];
}
- (void)hiddenChatViewWithAnimate:(BOOL)animate{
    CGFloat bom = SAFE_TO_BOTTOM?25:0;
    if(animate){
        [UIView animateWithDuration:0.2 animations:^{
            _chatBgHeight.constant = SCREEN_HEIGHT-NAV_HEIGHT-kOpenViewHeight-SAFE_TO_BOTTOM + bom;
            //        _topSafeArea.constant = 0;
            _topSafeArea.constant = SCREEN_HEIGHT-NAV_HEIGHT-kOpenViewHeight+40;
            [self.view layoutIfNeeded];
        }];
    }else{
        _chatBgHeight.constant = SCREEN_HEIGHT-NAV_HEIGHT-kOpenViewHeight-SAFE_TO_BOTTOM + bom;
        //        _topSafeArea.constant = 0;
        _topSafeArea.constant = SCREEN_HEIGHT-NAV_HEIGHT-kOpenViewHeight+40;
    }
    
    self.upDownBtn.selected = NO;
}

- (IBAction)fullScreenClick:(UIButton *)sender {
    if(sender.selected == NO){
        CGFloat bom = SAFE_TO_BOTTOM?25:0;
        [UIView animateWithDuration:0.2 animations:^{
            _chatBgHeight.constant = SCREEN_HEIGHT-NAV_HEIGHT-SAFE_TO_BOTTOM+bom;
            _topSafeArea.constant = -kOpenViewHeight;
            [self.view layoutIfNeeded];
        }];
        sender.selected = YES;
    }else{
        CGFloat bom = SAFE_TO_BOTTOM?25:0;
        [UIView animateWithDuration:0.2 animations:^{
            _chatBgHeight.constant = SCREEN_HEIGHT-NAV_HEIGHT-kOpenViewHeight-SAFE_TO_BOTTOM+bom;
            _topSafeArea.constant = 0;
            [self.view layoutIfNeeded];
        }];
        sender.selected = NO;
    }
}
//点击聊天室
- (IBAction)chatClick:(UIButton *)sender {
    __weak __typeof(self)weakSelf = self;
    [PublicInterfaceTool getWechatInfoSuccess:^(BaseData * _Nonnull data) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if ([data.data[@"chatRoom"] integerValue] == 1) {
            [MBProgressHUD showError:kGoInChatRoomMessage];
        } else {
            [strongSelf gotoChatRoom];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:kGoInChatRoomMessage];
    }];
    

}

- (void)gotoChatRoom {
    //    [self.chatBgView sendSubviewToBack:chatVC.view];
    CGFloat bom = SAFE_TO_BOTTOM?25:0;
    [UIView animateWithDuration:0.2 animations:^{
        _chatBgHeight.constant = SCREEN_HEIGHT-NAV_HEIGHT-kOpenViewHeight-SAFE_TO_BOTTOM+bom;
        _topSafeArea.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

//隐藏聊天室
- (IBAction)close:(UIButton *)sender {
    [self hiddenChatViewWithAnimate:YES];
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
                    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.listTabelView.frame.size.height)];
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
                [self.orderListTableView reloadData];
                
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
//                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self->_dataArr.count-1 inSection:0];
//                [self->_chatTableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionNone animated:NO];
                [self updateMessageTableView];
            }
            
        }
        
    } failure:^(NSError *error) {
        
    }];
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
                cell.showErrorMessage = ^(NSString * str) {
                    @strongify(self);
                    [self showHint:str];
                };
                
                return cell;
            }
            
        }
        return [UITableViewCell new];
    }else if(tableView == _orderListTableView){//
        static NSString *cellID = @"SendOrderListCell";
        SendOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SendOrderListCell" owner:self options:nil]lastObject];
        }
        Chat_OrderListModel *model = _orderListArr[indexPath.row];
        [cell setDataWithModel:model];
        return cell;
    }else if (tableView == _listTabelView){//直播推单
        LiveListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiveListCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LiveListCell" owner:nil options:nil]lastObject];
        }
        LiveListModel *model = _liveListArr[indexPath.row];
        [cell setDataWithModel:model];
        return cell;
    }
    return [UITableViewCell new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _chatTableView){
        return _dataArr.count;
    }else if(tableView == _orderListTableView){
        return _orderListArr.count;
    }else if(tableView == _listTabelView){
        return _liveListArr.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _chatTableView){
        ChatMessageModel *model = _dataArr[indexPath.row];
        if(model.type == 1){
            return 135;
        }else{
            return [BallTool getChatMessageHeightWithString:model.content]+40;
        }
    }else if (tableView == _listTabelView){
        return 203;
    }
    return 135;
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

- (void)showHongbaoName:(NSString *)name money:(NSString *)money count:(NSString *)count{
    dispatch_async(dispatch_get_main_queue(), ^{
        ChatHongbaoGetAlert *vc = [[[NSBundle mainBundle]loadNibNamed:@"ChatHongbaoGetAlert" owner:self options:nil]firstObject];
        vc.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [vc showInView:self.view name:name money:money count:count];
        [self checkIsNeedLoadHongbao];
    });
}

- (IBAction)clickHongBao:(id)sender{
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
                [MBProgressHUD showSuccess:@"发送成功！"];
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
            ChatHongbaoTopView *hbTopV = [[[NSBundle mainBundle]loadNibNamed:@"ChatHongbaoTopView" owner:self options:nil]firstObject];
            [self.view addSubview:hbTopV];
            [hbTopV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.chatTitleBgView.mas_bottom);
                make.left.right.equalTo(self.chatTitleBgView);
                make.height.offset(55);
            }];

            NSInteger hbID = [dic[@"id"] integerValue];
            hbTopV.hbID = hbID;
            [hbTopV.headImageV sd_setImageWithURL:[NSURL URLWithString:dic[@"head"]] placeholderImage:IMAGE(@"头像")];
            hbTopV.nickLab.text = dic[@"nickname"];
            hbTopV.moneyLab.text = [NSString stringWithFormat:@"%.2f元",[dic[@"money"] floatValue]];
            NSInteger totle = [dic[@"sendNumber"] integerValue];
            NSInteger current = [dic[@"holdNumber"] intValue];
            hbTopV.countLab.text = [NSString stringWithFormat:@"剩余：%d/%d",totle-current,totle];
//            [hbTopV showInView:self.view];
            [hbTopV setClickOKBtn:^(CGFloat money) {
                ChatHongbaoReciviced * rv = [[[NSBundle mainBundle]loadNibNamed:@"ChatHongbaoReciviced" owner:self options:nil]firstObject];
                rv.moneyLab.text = [NSString stringWithFormat:@"%.2f元",money];
                [rv show];
                [rv setClickOKBtn:^{
                    [self checkIsNeedLoadHongbao];
                }];
            }];
        }else{
            [self checkIsNeedLoadHongbao];
        }
    } failure:^(NSError *error) {
    } showHUD:NO];
}
- (void)checkIsNeedLoadHongbao{
    BOOL isOK = NO;
    for(UIView *v in self.view.subviews){
        if([v isKindOfClass:[ChatHongbaoTopView class]]){
            isOK = YES;
            break;
        }
    }
    if(!isOK){
        [self loadHongbaoData];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height)
    {
        _currentIsInBottom = YES;
        MBLog(@"YESYESYESYES");
    }
    else
    {
        _currentIsInBottom= NO;
        MBLog(@"NONONONONO");
    }
}
@end
