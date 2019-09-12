//
//  CircleCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CircleCtrl.h"
#import "ShowOrderCtrl.h"
#import "DaShenViewController.h"
#import "CircleDetailViewController.h"
#import "CircleSetCtrl.h"
#import "CircleHomeTableViewCell.h"
#import "LoginAlertViewController.h"

@interface CircleCtrl ()

@end

@implementation CircleCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.layer insertSublayer:jbbj(self.view.bounds) atIndex:0];
    self.view.backgroundColor = [[CPTThemeConfig shareManager] Circle_View_BackgroundC];
    
    [self setNavUI];
    
    self.tableView.rowHeight = 75;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CircleHomeTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CircleHomeTableViewCellID];
    
    self.tableView.backgroundColor = [[CPTThemeConfig shareManager] Circle_View_BackgroundC];;
    [self.view addSubview:self.tableView];

    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0));
    }];
    
        NSArray *array = @[
  @{@"icon":[[CPTThemeConfig shareManager] circleHomeSDQImageName],@"title":@"晒单圈",@"subtitle":@"晒晒来好运",@"backgroundImage" : [[CPTThemeConfig shareManager] circleHomeCell1Bgcolor]},
  @{@"icon":[[CPTThemeConfig shareManager] circleHomeGDDTImageName],@"title":@"跟单大厅",@"subtitle":@"跟大神赚大钱",@"backgroundImage" : [[CPTThemeConfig shareManager] circleHomeCell2Bgcolor]},
  @{@"icon":[[CPTThemeConfig shareManager] circleHomeXWZXImageName],@"title":@"新闻中心",@"subtitle":@"最新资讯应有尽有",@"backgroundImage" : [[CPTThemeConfig shareManager] circleHomeCell3Bgcolor]},
  @{@"icon":[[CPTThemeConfig shareManager] circleHomeDJZXImageName],@"title":@"电竞资讯",@"subtitle":@"最全面的电竞资讯",@"backgroundImage" : [[CPTThemeConfig shareManager] circleHomeCell4Bgcolor]},
  @{@"icon":[[CPTThemeConfig shareManager] circleHomeZCZXImageName],@"title":@"足彩资讯",@"subtitle":@"小单收获大奖", @"backgroundImage" : [[CPTThemeConfig shareManager] circleHomeCell5Bgcolor]}];
    
        [self.dataSource addObjectsFromArray:array];

}

- (void)setNavUI {
    [self setmenuBtn:[[CPTThemeConfig shareManager] IC_Nav_SideImageStr]];
    
    @weakify(self)
    [self rigBtnImage:[[CPTThemeConfig shareManager] IC_Nav_Setting_Icon] With:^(UIButton *sender) {
        @strongify(self)
        
        if ([Person person].uid == nil) {
            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
            [self presentViewController:login animated:YES completion:^{
            }];
            @weakify(self)
            login.loginBlock = ^(BOOL result) {
                @strongify(self)
                CircleSetCtrl *set = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleSetCtrl"];
                [self.navigationController pushViewController:set animated:YES];
            };
            
            return;
        }
        CircleSetCtrl *set = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleSetCtrl"];
        
        [self.navigationController pushViewController:set animated:YES];
    }];
    
    
    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterProduct) {
        UIImageView *imgv = [[UIImageView alloc]initWithImage:IMAGE([[CPTThemeConfig shareManager] IC_Nav_CircleTitleImage])];
        [self.navView addSubview:imgv];
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rightBtn);
            make.centerX.equalTo(self.navView);
            make.size.mas_equalTo(CGSizeMake(imgv.image.size.width, imgv.image.size.height));
        }];
    } else {
        self.titlestring = @"圈子";
    }

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    @weakify(self)
//    [self getSetDatasuccess:^(NSArray *data) {
//        @strongify(self)
//        self.dataArray = data;
//    }];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterHK || [[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        return 0.00001;
    }
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *header = [UIView new];
    
    header.backgroundColor = [[CPTThemeConfig shareManager] CircleVC_HeadView_BackgroundC];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CircleHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CircleHomeTableViewCellID forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = CLEAR;
    
    
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.section];
    
    cell.icon.image = IMAGE(dic[@"icon"]);
    
    cell.titleLbl.text = dic[@"title"];
    
//    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterHK) {
//        if (indexPath.section == 0) {
//            cell.titleLbl.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell_TextLabel_BackgroundC];
//            cell.subTitle.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell_DetailTextLabel_BackgroundC];
//        }else if(indexPath.section == 1){
//            cell.titleLbl.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell1_TextLabel_BackgroundC];
//            cell.subTitle.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell1_DetailTextLabel_BackgroundC];
//        }else if(indexPath.section == 2){
//            cell.titleLbl.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell2_TextLabel_BackgroundC];
//            cell.subTitle.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell2_DetailTextLabel_BackgroundC];
//        }else if(indexPath.section == 3){
//            cell.titleLbl.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell3_TextLabel_BackgroundC];
//            cell.subTitle.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell3_DetailTextLabel_BackgroundC];
//        }else if(indexPath.section == 4){
//            cell.titleLbl.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell4_TextLabel_BackgroundC];
//            cell.subTitle.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell4_DetailTextLabel_BackgroundC];
//        }
//    }else{
//        cell.titleLbl.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell_TextLabel_BackgroundC];
//        cell.subTitle.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell_DetailTextLabel_BackgroundC];
//    }
    
    cell.titleLbl.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell_TextLabel_BackgroundC];
    cell.subTitle.textColor = [[CPTThemeConfig shareManager] CO_Circle_Cell_DetailTextLabel_BackgroundC];
    
    cell.subTitle.text = dic[@"subtitle"];
    
    
    cell.backgroundColor = [[CPTThemeConfig shareManager] CO_Circle_Cell_BackgroundC];
    
//    cell.backgroundColor = CLEAR;
    cell.contentView.backgroundColor = CLEAR;
    
    if ([AppDelegate shareapp].sKinThemeType == SKinType_Theme_White) {
        cell.backImageView.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backImageView.image = IMAGE(dic[@"backgroundImage"]);
    }
    
    
//    tw_qz_next
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:login animated:YES completion:nil];
//        @weakify(self)
        login.loginBlock = ^(BOOL result) {
//            @strongify(self)
//            DaShenViewController *dashen = [[DaShenViewController alloc] init];
//            PUSH(dashen);
        };
        
        return;
    }
    
    if (indexPath.section == 0) {
        
        if ([Person person].uid == nil) {
            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            
            [self presentViewController:login animated:YES completion:nil];
            @weakify(self)
            login.loginBlock = ^(BOOL result) {
                @strongify(self)
                CircleDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
                [self.navigationController pushViewController:detail animated:YES];
            };
            
            return;
        }
        
        CircleDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Circle" bundle:nil] instantiateViewControllerWithIdentifier:@"CircleDetailViewController"];
        [self.navigationController pushViewController:detail animated:YES];
        
//        ShowOrderCtrl *show = [[ShowOrderCtrl alloc]init];
//
//        PUSH(show);
    } else if (indexPath.section == 1){//跟单大厅
        
//        if ([Person person].uid == nil) {
//            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
//            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//
//            [self presentViewController:login animated:YES completion:nil];
//             @weakify(self)
//            login.loginBlock = ^(BOOL result) {
//                @strongify(self)
//                DaShenViewController *dashen = [[DaShenViewController alloc] init];
//                PUSH(dashen);
//            };
//
//            return;
//        }
        
//        if ([Person person].Information) {
//            [AlertViewTool alertViewToolShowMessage:@"研发中，敬请期待..." fromController:self handler:nil];
//
//            return;
//        }
        
        DaShenViewController *dashen = [[DaShenViewController alloc] init];
        PUSH(dashen);
        
    }else if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4){//新闻中心
        
        [AlertViewTool alertViewToolShowMessage:@"研发中，敬请期待" fromController:self handler:nil];

    }
}

-(void)getSetDatasuccess:(void (^)(NSArray *data))success {
    
//    @weakify(self)
    [WebTools postWithURL:@"/circle/getPostSettingList" params:@{@"classify":@"circle"} success:^(BaseData *data) {
        
//        @strongify(self)
        NSArray *array = data.data;
        
        for (NSDictionary *dic in array) {
            
            if ([[dic valueForKey:@"settingId"]integerValue] == 2) {
                
                [Person person].onlywifi = [[dic valueForKey:@"onOff"]boolValue];
            }
        }
        
        success(array);
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

@end
