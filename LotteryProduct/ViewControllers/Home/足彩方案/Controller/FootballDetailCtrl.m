//
//  FootballDetailCtrl.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/24.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "FootballDetailCtrl.h"
#import "FootballRemarkView.h"
#import "FootballDetailModel.h"
#import "FootballDetailHeaderView.h"
#import "BallTool.h"
#import "RemarkListCell.h"
#import "FootBallPlanCtrl.h"
#import "NSString+IsBlankString.h"
#import "LoginAlertViewController.h"
#import <WebKit/WebKit.h>
@interface FootballDetailCtrl ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong)FootballDetailHeaderView *tableViewHeader;
@end

@implementation FootballDetailCtrl
{
    FootballDetailModel *_model;
    NSInteger _page;
    NSMutableArray *_dataArr;
    BOOL _isResponse;
    NSString *_parentId;
    NSString *_responsePreStr;
    CGFloat _hhh;
    BOOL _getNewList;
    NSInteger _count;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [self buildBottomView];
    _page = 1;
    self.titlestring = @"足彩方案";
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:_dataModel.heads] placeholderImage:IMAGE(@"mrtx")];
    self.nameLabel.text = _dataModel.referrer;
    @weakify(self)
    if(!self.isHistory){
        [self rigBtn:@"历史" Withimage:nil With:^(UIButton *sender) {
            @strongify(self)
            FootBallPlanCtrl *footVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"FootBallPlanCtrl"];
            footVc.isHistory = YES;
            footVc.hostID = self.dataModel.referrerId;
            PUSH(footVc);
        }];
    }
    
    [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.focusBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [self getData];
    
    self.tableView2.estimatedRowHeight =0;
    self.tableView2.estimatedSectionHeaderHeight =0;
    self.tableView2.estimatedSectionFooterHeight =0;
    if (@available(iOS 11.0, *)) {
        self.tableView2.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.tableView2.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        self->_page++;
        [self getRemarkData];
    }];
    [self setupTableViewHeaderView];
    self.automaticallyAdjustsScrollViewInsets = NO;

}
- (void)buildBottomView{
    
}
- (IBAction)focusClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        //                        login.loginBlock = ^(BOOL result) {
        //
        //                        };
        return;
    }
    self.focusBtn.userInteractionEnabled = NO;
    NSDictionary *dic = @{@"referrer":_dataModel.referrer,@"referrerId":@(_dataModel.referrerId)};
    if(sender.selected == NO){//关注
        @weakify(self)
        [WebTools postWithURL:@"/football/addRecommendFollow.json" params:dic success:^(BaseData *data) {
            @strongify(self)
            if(data.status.integerValue == 1){
                self.focusBtn.selected = YES;
                [self shouldUpdateFocusList];
            }
            self.focusBtn.userInteractionEnabled = YES;
            
        } failure:^(NSError *error) {
            @strongify(self)
            self.focusBtn.userInteractionEnabled = YES;
        }];
    }else{//取消关注
        @weakify(self)
        [WebTools postWithURL:@"/football/addRecommendFollow.json" params:dic success:^(BaseData *data) {
            @strongify(self)
            if(data.status.integerValue == 1){
                self.focusBtn.selected = NO;
                [self shouldUpdateFocusList];
            }
            self.focusBtn.userInteractionEnabled = YES;
        } failure:^(NSError *error) {
            @strongify(self)
            self.focusBtn.userInteractionEnabled = YES;
        }];
    }
}
- (void)shouldUpdateFocusList{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"focus_update" object:nil];
}
- (void)getData{
    NSDictionary *dic = @{@"recommendId":@(_dataModel.ID.integerValue)};
    @weakify(self)
    [WebTools postWithURL:@"/football/getRecommendKey.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            [self getRemarkData];
            MBLog(@"%@",data.data);
            self->_model = [FootballDetailModel mj_objectWithKeyValues:data.data];
            self->_model.title = [Tools filterHTML:self->_model.title];
//            self->_model.content = [Tools filterHTML:self->_model.content];
            self->_model.title = [self->_model.title stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
            self->_model.title = [self->_model.title stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];
//            self->_model.content = [self->_model.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
//            self->_model.content = [self->_model.content stringByReplacingOccurrencesOfString:@"&amp;" withString:@""];

//            NSMutableAttributedString *titleStr=  [[NSMutableAttributedString alloc] initWithData:[self->_model.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//            [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(0, titleStr.length)];
//            [paragraphStyle setLineSpacing:0];
//            [titleStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleStr.length)];
//            self->_model.htmlTitle = titleStr;
//            NSMutableAttributedString *titleStr1=  [[NSMutableAttributedString alloc] initWithData:[self->_model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//            NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//            [titleStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0, titleStr1.length)];
//            [paragraphStyle1 setLineSpacing:0];
//            [titleStr1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, titleStr1.length)];
//            self->_model.htmlContent = titleStr1;
            if(self->_model.alreadyFllow == 0){
                self.focusBtn.selected = NO;
            }else{
                self.focusBtn.selected = YES;
            }
            [self setHeaderData];
//            [self.tableView2 reloadData];
            
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 获取评论list
- (void)getRemarkData{
    NSDictionary *dic = @{@"recommendId":_dataModel.ID,@"pageNum":@(_page),@"pageSize":@(10)};
    @weakify(self)
    [WebTools postWithURL:@"/football/pageCommendList.json" params:dic success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            self->_getNewList = YES;
            if(self->_page == 1){
                [self->_dataArr removeAllObjects];
            }
            if([data.data isKindOfClass:[NSArray class]]){
                NSArray *arr = data.data;
                if(arr.count){
                    for (NSDictionary *dd in arr) {
                        RemarkListModel *model = [RemarkListModel mj_objectWithKeyValues:dd];
                        [self->_dataArr addObject:model];
                    }
                    [self.tableView2 reloadData];
                    MBLog(@"评论列表刷新--%f",self.tableView2.contentSize.height);
                    [self.tableView2.mj_footer endRefreshing];
                }else{
                    if(self->_page > 1){
                        self->_page--;
                    }
                    [self.tableView2.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                [self.tableView2.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self.tableView2.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        @strongify(self)
        [self.tableView2.mj_footer endRefreshing];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemarkListModel *model = _dataArr[indexPath.row];
    CGFloat height = [BallTool heightWithFont:14 limitWidth:SCREEN_WIDTH-50 string:model.content];
    return 65+height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"RemarkListCell";
    RemarkListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RemarkListCell" owner:nil options:nil]lastObject];
    }
    RemarkListModel *model = _dataArr[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if(_model){
//        CGFloat height1 = [BallTool heightWithFont:15 limitWidth:SCREEN_WIDTH-20 string:_model.title];
//        CGFloat height2 = [BallTool heightWithFont:13 limitWidth:SCREEN_WIDTH-20 string:_model.content];
////        CGFloat height3 = [BallTool heightWithFont:13 limitWidth:SCREEN_WIDTH-20 string:@"123"];
////        NSInteger num = [BallTool numberOfEmptyLine:_model.content];
////        MBLog(@"%ld---%f-%@",(long)num,height3,_model.content);
////        CGFloat h1 = [self heightForAttributeString:_model.title withTextFontSize:15];
////        CGFloat h2 = [self heightForAttributeString:_model.content withTextFontSize:13];
//        return 130+height1+self.tableViewHeader.contentWebVeiw.frame.size.height;
//    }
//    return 125;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if(_model){
//        if(self.tableViewHeader==nil){
//            self.tableViewHeader = [[[NSBundle mainBundle] loadNibNamed:@"FootballDetailHeaderView" owner:self options:nil]lastObject];
//            [self.tableViewHeader.contentWebVeiw addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
//            self.tableViewHeader.contentWebVeiw.UIDelegate = self;
//            self.tableViewHeader.contentWebVeiw.navigationDelegate = self;
//            [self.tableViewHeader setDataWithModel:_model];
//        }
//    }
//    return self.tableViewHeader;
//}
- (void)setupTableViewHeaderView{
    
    self.tableViewHeader = [[[NSBundle mainBundle] loadNibNamed:@"FootballDetailHeaderView" owner:self options:nil]lastObject];
    [self.tableViewHeader.contentWebVeiw addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
    self.tableViewHeader.contentWebVeiw.UIDelegate = self;
    self.tableViewHeader.contentWebVeiw.navigationDelegate = self;
//    self.tableViewHeader.contentWebVeiw.scrollView.delegate = self;
    [self.headerView addSubview: self.tableViewHeader];
    [self.tableViewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.width.offset(SCREEN_WIDTH);
        make.height.offset(30);
    }];
//    self.tableView2.tableHeaderView = self.headerView;
}
- (void)setHeaderData{
    [self.tableViewHeader setDataWithModel:_model];
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSString *javascript = @"var meta = document.createElement('meta');meta.setAttribute('name', 'viewport');meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);";
    
    [webView evaluateJavaScript:javascript completionHandler:nil];
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    //    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    decisionHandler(WKNavigationResponsePolicyCancel);
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.tableViewHeader.contentWebVeiw && [keyPath isEqual:@"scrollView.contentSize"]) {
        UIScrollView *scrollView = self.tableViewHeader.contentWebVeiw.scrollView;
        CGSize size = CGSizeMake(SCREEN_WIDTH, scrollView.contentSize.height);
        _hhh = size.height+127;
        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, size.height+127);
//        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.offset(size.height+50+[BallTool heightWithFont:14 limitWidth:SCREEN_WIDTH-50 string:_model.content]+40);
//        }];
        self.tableViewHeader.webBgViewHeight.constant = size.height;
        self.tableView2.tableHeaderView = self.headerView;
//        _count++;
//        if(_getNewList == YES&&_count>2){
        self.tableView2.contentSize = CGSizeMake(SCREEN_WIDTH, self.tableView2.contentSize.height-_hhh);
//            _getNewList = NO;
//            _count = 0;
//        }
        
        MBLog(@"head----%f",self.headerView.frame.size.height);
        MBLog(@"----%f",self.tableView2.contentSize.height);
        
    }
}
- (void)pinglunListReload{
    [self.tableView2 reloadData];
}
- (IBAction)remarkClick:(UIButton *)sender {
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        //                        login.loginBlock = ^(BOOL result) {
        //
        //                        };
    }else{
        sender.hidden = YES;
        [_textField becomeFirstResponder];
        if(_responsePreStr){
            _textField.text = _responsePreStr;
        }
    }
}
#pragma mark 提交评论
- (IBAction)requestRemark:(UIButton *)sender {
    [self realRemark];
}
- (void)realRemark{
    [_textField resignFirstResponder];
    NSMutableDictionary *paramDic;
    if (_isResponse) {
        
        NSString *remarkStr = [[_textField.text componentsSeparatedByString:@":"] lastObject];
        
        NSDictionary *params = @{@"recommendId":_dataModel.ID, @"content": remarkStr, @"parentId": _parentId};
        paramDic = (NSMutableDictionary*)params;
        
        if ([NSString isBlankString:remarkStr]) {
            [MBProgressHUD showMessage:@"回复评论不能为空"];
            return;
        }
    }else{
        if ([NSString isBlankString:_textField.text]) {
            [MBProgressHUD showMessage:@"评论不能为空"];
            return;
        }
        if (self.textField.text.length >= 200) {
            [MBProgressHUD showMessage:@"评论字数不能超过100"];
            return;
        }
        self.remarkBtn.enabled = NO;
        //    @"parentId":[Person person].uid
        //    @"referrerId":@(_dataModel.referrerId),
        NSDictionary *dic = @{@"content":_textField.text,@"recommendId":_dataModel.ID};
        paramDic = (NSMutableDictionary *)dic;
    }
    @weakify(self)
    [WebTools postWithURL:@"/football/addRecommendCommend.json" params:paramDic success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            self->_page = 1;
            [self getRemarkData];
            self.textField.text = @"";
//            [UIView animateWithDuration:0.2 animations:^{
//                self.tableView2.contentOffset = CGPointZero;
//            }];
        }
        self.remarkBtn.enabled = YES;
    } failure:^(NSError *error) {
        @strongify(self)
        self.remarkBtn.enabled = YES;
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RemarkListModel *model = _dataArr[indexPath.row];
    _parentId = model.ID;
    _responsePreStr = [NSString stringWithFormat:@"%@ @%@:",[Person person].nickname, model.nickname];
    _isResponse = YES;
    [self remarkClick:_plBtn];
}

@end
