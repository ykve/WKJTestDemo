//
//  FootballDetailCtrl.h
//  LotteryProduct
//
//  Created by pt c on 2019/4/24.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"
#import "FootballRemarkListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FootballDetailCtrl : RootCtrl <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) FootballRemarkListModel *dataModel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
@property (weak, nonatomic) IBOutlet UIButton *remarkBtn;
@property (weak, nonatomic) IBOutlet UIButton *plBtn;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic,assign) BOOL isHistory;
@property (weak, nonatomic) IBOutlet UIView *txBgView;
@end

NS_ASSUME_NONNULL_END
