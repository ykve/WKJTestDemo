//
//  IGKbetListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/26.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "IGKbetListCtrl.h"
#import "IGKbetSixCell.h"
#import "IGKbetchongqinCell.h"
#import "IGKbetPK10Cell.h"
#import "PCHistoryModel.h"
#import "PCInfoModel.h"
#import "PK10HistoryModel.h"
#import "IGKbetDetailCtrl.h"
#import "UIImage+color.h"
#import "OpenListTableViewCell.h"
#import "BallTool.h"


@interface IGKbetListCtrl ()
{
//    NSMutableArray* _idArray;
    __block NSMutableArray* _historyArray;
    __block IGKbetModel *_model;
}
@end

@implementation IGKbetListCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([IGKbetSixCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([IGKbetchongqinCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJHeaderIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([IGKbetPK10Cell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RJFooterIdentifier];
    [self.tableView registerClass:[OpenListTableViewCell class] forCellReuseIdentifier:OpenListTableViewCellID];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [[CPTThemeConfig shareManager] OpenLotteryVC_View_BackgroundC];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(NAV_HEIGHT, 0, 0, 0));
    }];

    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        [self.view.layer insertSublayer:jbbj(self.view.bounds) atIndex:0];
    }
//    [self refresh];
    
    self.page = 1;
    
    [self initData];
    
    @weakify(self)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        self.page = 1;
        
        [self initData];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)

        self.page ++ ;
        
        [self initData];
    }];

}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    [self performSelector:@selector(configUI) withObject:nil afterDelay:0.1];
    [self reloadData];

//    [self addnotification];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self removenotification];
}
//- (void)configUI{
//    [self reloadData];
//}
- (void)reloadData{
    if(!_model){
        @weakify(self)
        [[CPTOpenLotteryManager shareManager] checkModelByIds:@[@(self.type)] callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
            @strongify(self)
            if(!self){return;}
            self->_model = data;
            [self.tableView reloadData];
        }];
    }
}

-(void)addnotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_cqssc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xglhc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_bjpks" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xyft" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_xjssc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_txffc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"kj_pcegg" object:nil];
    
}

-(void)removenotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_cqssc" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xglhc" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_bjpks" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xyft" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_xjssc" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_txffc" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kj_pcegg" object:nil];
}

-(void)refresh {
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == CPTBuyTicketType_LiuHeCai || self.type == CPTBuyTicketType_OneLiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai|| self.type == CPTBuyTicketType_ShiShiLiuHeCai || self.type == CPTBuyTicketType_NiuNiu_KuaiLe|| self.type == CPTBuyTicketType_NiuNiu_JiShu || self.type == CPTBuyTicketType_NiuNiu_AoZhou || self.type == CPTBuyTicketType_AoZhouShiShiCai || self.type == CPTBuyTicketType_FantanSSC) {
        return 120;
    }else if (self.type == CPTBuyTicketType_PK10 || self.type == CPTBuyTicketType_XYFT|| self.type == CPTBuyTicketType_TenPK10|| self.type == CPTBuyTicketType_FivePK10|| self.type == CPTBuyTicketType_JiShuPK10|| self.type == CPTBuyTicketType_AoZhouF1){
        return 155;
    }else if(self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC || self.type == CPTBuyTicketType_FFC || self.type == CPTBuyTicketType_TJSSC || self.type == CPTBuyTicketType_TenSSC || self.type == CPTBuyTicketType_FiveSSC  || self.type == CPTBuyTicketType_PaiLie35|| self.type == CPTBuyTicketType_AoZhouACT|| self.type == CPTBuyTicketType_FantanPK10|| self.type == CPTBuyTicketType_FantanXYFT || self.type ==  CPTBuyTicketType_JiShuSSC ){
        return 130;
    }else{
        return 95;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC || self.type == CPTBuyTicketType_FFC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC|| self.type == CPTBuyTicketType_JiShuSSC ) {//时时彩
        
        IGKbetchongqinCell *cell = [tableView dequeueReusableCellWithIdentifier:RJHeaderIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (NSLayoutConstraint *rightconst in cell.rights) {
            
            rightconst.constant = 15/SCAL;
//            rightconst.constant = indexPath.row == 0 ? 25/SCAL : 20/SCAL;
        }
        
        if (self.type == CPTBuyTicketType_JiShuSSC || self.type == CPTBuyTicketType_TJSSC || self.type == CPTBuyTicketType_TenSSC || self.type == CPTBuyTicketType_FiveSSC) {
            cell.nextimgv.hidden = YES;
        }
        
        PCHistoryModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        cell.versionslab.text = [NSString stringWithFormat:@"第%@期 %@",[model.issue substringFromIndex:self.type == 3 ? 9 : 8],model.time];
        cell.backgroundColor = [[CPTThemeConfig shareManager] OpenLottery_S_Cell_BackgroundC];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.totallab.hidden = YES;
        if (model.number.length == 0) {
            return cell;
        }
        
        NSArray *array;
        if ([model.number containsString:@","]) {
            array = [model.number componentsSeparatedByString:@","];
        }
        for (UIButton *btn in cell.numberlabs) {
            
            NSString *num;// = [model.number substringWithRange:NSMakeRange(btn.tag-100, 1)];
            if ([model.number containsString:@","]) {
                num = array[btn.tag - 100];
            }else{
                num = [model.number substringWithRange:NSMakeRange(btn.tag-100, 1)];
            }
            
            [btn setTitle:num forState:UIControlStateNormal];
            
            if (indexPath.row == 0) {
                [btn setBackgroundImage:IMAGE(@"kj_orangeboll") forState:UIControlStateNormal];
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
            }
            else{
                [btn setBackgroundImage:IMAGE(@"kj_writeboll") forState:UIControlStateNormal];
                [btn setTitleColor:BLACK forState:UIControlStateNormal];
            }
            
            btn.titleEdgeInsets = indexPath.row == 0 ? UIEdgeInsetsMake(0, 0, 0, 0) : UIEdgeInsetsMake(0, 0, 0, 0);
        }
        
        int num1 = [[model.number substringWithRange:NSMakeRange(0, 1)] intValue];
        int num2 = [[model.number substringWithRange:NSMakeRange(1, 1)] intValue];
        int num3 = [[model.number substringWithRange:NSMakeRange(2, 1)] intValue];
        int num4 = [[model.number substringWithRange:NSMakeRange(3, 1)] intValue];
        int num5 = [[model.number substringWithRange:NSMakeRange(4, 1)] intValue];
        
        cell.totallab.text = [NSString stringWithFormat:@"和值：%d",num1 + num2 + num3 + num4 + num5];

        for (UILabel *lbl in cell.numSubTitleLbls) {
            
            lbl.textColor = [[CPTThemeConfig shareManager] OpenLottery_S_Cell_TitleC];
            lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
            lbl.layer.borderWidth = 1;
            lbl.layer.cornerRadius = 5;
            lbl.layer.masksToBounds = YES;
            lbl.textAlignment = NSTextAlignmentCenter;
            
            switch (lbl.tag) {
                    
                case 10:
                    
                    lbl.text = [NSString stringWithFormat:@"%d",(num1 + num2 + num3 + num4 + num5)];
                    
                    break;
                case 20:
                    
                    if (num1 + num2 + num3 + num4 + num5 >= 23) {
                        lbl.text = @"大";
                    }else{
                        lbl.text = @"小";
                    }
                    
                    break;
                case 30:
                    
                    if ((num1 + num2 + num3 + num4 + num5) % 2 == 0) {
                        lbl.text = @"双";
                    }else{
                        lbl.text = @"单";
                    }
                    
                    break;
                case 40:
                    
                    if (num1 > num5) {
                        lbl.text = @"龙";
                    }else if (num1 < num5){
                        lbl.text = @"虎";
                    } else{
                        lbl.text = @"和";
                    }
                    break;
                case 50:

                    break;
                    
                default:
                    break;
            }
            
        }
        
        return cell;
    }
    else if (self.type == CPTBuyTicketType_LiuHeCai || self.type == CPTBuyTicketType_OneLiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai || self.type == CPTBuyTicketType_ShiShiLiuHeCai) {//六合彩系列
        
        IGKbetSixCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
        
        SixInfoModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        if (self.type == CPTBuyTicketType_OneLiuHeCai || self.type == CPTBuyTicketType_FiveLiuHeCai || self.type == CPTBuyTicketType_ShiShiLiuHeCai) {
            cell.nextimgv.hidden = YES;
        }
        
        cell.versionslab.text = [NSString stringWithFormat:@"第%@期 %@",model.issue,model.time];
        cell.backgroundColor = [[CPTThemeConfig shareManager] OpenLottery_S_Cell_BackgroundC];

        int i = 0;
        NSArray * numberArry = [model.numberstr componentsSeparatedByString:@","];
        NSArray * shengxiaoArry = [model.shengxiao2 componentsSeparatedByString:@","];

        for (NSString *str in numberArry) {
            
            UIButton *btn = [cell.numberBtns objectAtIndex:i];
            
            UILabel *lab = [cell.numberlabs objectAtIndex:i];
            
            lab.textColor = [[CPTThemeConfig shareManager] OpenLottery_S_Cell_TitleC];
            [btn setTitle:str forState:UIControlStateNormal];
            
            [btn setBackgroundImage:[Tools numbertoimage:str Withselect:NO] forState:UIControlStateNormal];
            NSString *wuxing = [Tools numbertowuxin:numberArry[i]];

            
            lab.text = [NSString stringWithFormat:@"%@/%@",shengxiaoArry[i], wuxing];
            
            i++;
        }
        
        return cell;
    }

    else if (self.type == CPTBuyTicketType_PK10 ||self.type == CPTBuyTicketType_XYFT||self.type == CPTBuyTicketType_TenPK10||self.type == CPTBuyTicketType_FivePK10||self.type == CPTBuyTicketType_JiShuPK10||self.type == CPTBuyTicketType_AoZhouF1){//幸运飞艇
        IGKbetPK10Cell *cell = [tableView dequeueReusableCellWithIdentifier:RJFooterIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.type == CPTBuyTicketType_AoZhouF1 ||self.type == CPTBuyTicketType_TenPK10||self.type == CPTBuyTicketType_FivePK10||self.type == CPTBuyTicketType_JiShuPK10) {
            cell.nextimgv.hidden = YES;
        }

        for (NSLayoutConstraint *rightconst in cell.rights) {
            
            rightconst.constant = indexPath.row == 0 ? 15/SCAL : 10/SCAL;
        }
        
        PK10HistoryModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        cell.versionslab.text = [NSString stringWithFormat:@"第%@期 %@",model.issue.length > 8 ? [model.issue substringFromIndex:8] : model.issue ,model.time];
        cell.backgroundColor = [[CPTThemeConfig shareManager] OpenLottery_S_Cell_BackgroundC];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray *numbers = model.num;
        if (model.num) {
            numbers = model.num;
        }else{
            numbers = [model.number componentsSeparatedByString:@","];
        }
        if (numbers.count == 0) {
            return cell;
        }
        //冠亚
        int guanInt = [[NSString stringWithFormat:@"%@", numbers[0]] intValue];
        int yaInt = [[NSString stringWithFormat:@"%@", numbers[1]] intValue];
        int jiInt = [[NSString stringWithFormat:@"%@", numbers[2]] intValue];
        int fourthInt = [[NSString stringWithFormat:@"%@", numbers[3]] intValue];
        int fifthInt = [[NSString stringWithFormat:@"%@", numbers[4]] intValue];
        int sixthInt = [[NSString stringWithFormat:@"%@", numbers[5]] intValue];
        int sevenInt = [[NSString stringWithFormat:@"%@", numbers[6]] intValue];
        
        NSString *guanYaStr = [NSString stringWithFormat:@"%d", guanInt + yaInt];
        int tenthNum = [[NSString stringWithFormat:@"%@", numbers[9]] intValue];
        int ninethNum = [[NSString stringWithFormat:@"%@", numbers[8]] intValue];
        int eightthNum = [[NSString stringWithFormat:@"%@", numbers[7]] intValue];

        for (int i = 0; i < cell.numberLbls.count; i++) {
            UILabel *lbl = cell.numberLbls[i];
            lbl.layer.masksToBounds = YES;
            lbl.layer.cornerRadius = 2;
            lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
            lbl.layer.borderWidth = 1;
            lbl.textColor = [[CPTThemeConfig shareManager] OpenLottery_S_Cell_TitleC];//[UIColor colorWithHex:@"d7d7d7"];
            switch (i) {
                case 0://1冠亚
                    
                    lbl.text = guanYaStr;
                    
                    break;
                case 1://冠亚大小
                    
                    if (guanInt + yaInt > 11) {
                        lbl.text = @"大";
                    }else{
                        lbl.text = @"小";
                    }
                    
                    break;
                case 2://1冠亚单双
                    if ((guanInt + yaInt)%2) {
                        lbl.text = @"单";
                    } else{
                        lbl.text = @"双";
                    }
                    
                    break;
                case 3://龙虎
                    if (guanInt > tenthNum) {
                        lbl.text = @"龙";
                    }else{
                        lbl.text = @"虎";
                    }
                    
                    break;
                case 4://
                    if (yaInt > ninethNum) {
                        lbl.text = @"龙";
                    }else{
                        lbl.text = @"虎";
                    }
                    break;
                case 5://
                    if (jiInt > eightthNum) {
                        lbl.text = @"龙";
                    }else{
                        lbl.text = @"虎";
                    }
                    break;
                case 6:
                    if (fourthInt > sevenInt) {
                        lbl.text = @"龙";
                    }else{
                        lbl.text = @"虎";
                    }
                    break;
                case 7:
                    if (fifthInt > sixthInt) {
                        lbl.text = @"龙";
                    }else{
                        lbl.text = @"虎";
                    }
                    break;
                    
                default:
                    break;
            }
        }
        
        
        for (UIButton *btn in cell.numberBtns) {
            
            //            btn.selected = indexPath.row == 0 ? YES : NO;
            btn.selected = NO;
            [btn setTitleColor:[UIColor colorWithHex:@"FFFFFF"] forState:UIControlStateNormal];
            
            [btn setTitle:[NSString stringWithFormat:@"%@", numbers[btn.tag-100]] forState:UIControlStateNormal];
            
            int num = [[NSString stringWithFormat:@"%@", numbers[btn.tag-100]] intValue];
            
            btn.titleEdgeInsets = indexPath.row == 0 ? UIEdgeInsetsMake(0, 0, 0, 0) : UIEdgeInsetsMake(0, 0, 0, 0);
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 5;
            btn.backgroundColor = [BallTool getColorWithNum:num];

        }
        
        return cell;
    }else if (self.type == CPTBuyTicketType_HaiNanQiXingCai||self.type == CPTBuyTicketType_Shuangseqiu||self.type == CPTBuyTicketType_DaLetou||self.type == CPTBuyTicketType_QiLecai||self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_PaiLie35  ||self.type == CPTBuyTicketType_AoZhouShiShiCai || self.type == CPTBuyTicketType_AoZhouACT || self.type == CPTBuyTicketType_FantanPK10 || self.type == CPTBuyTicketType_FantanXYFT || self.type == CPTBuyTicketType_PCDD){
        CPTBuyTicketType tmpType = self.type;

        OpenListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OpenListTableViewCellID forIndexPath:indexPath];
        cell.type = tmpType;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configUI];
        cell.nameLabel.text = [[CPTBuyDataManager shareManager] changeTypeToString:tmpType];
        cell.backgroundColor = CLEAR;
        if(!_model){return cell;}
        LotteryInfoModel *model = self.dataSource[indexPath.row];
        [cell lotteryInfoModel:model];
        
        if (self.type == CPTBuyTicketType_HaiNanQiXingCai || self.type == CPTBuyTicketType_AoZhouShiShiCai || self.type == CPTBuyTicketType_3D || self.type == CPTBuyTicketType_PaiLie35 || self.type == CPTBuyTicketType_PCDD) {
            for (UIButton *btn in cell.titleBtnArray) {
                
                if (indexPath.row == 0) {
                    [btn setBackgroundImage:IMAGE(@"kj_orangeboll") forState:UIControlStateNormal];
                    [btn setTitleColor:WHITE forState:UIControlStateNormal];
                }else{
                    [btn setBackgroundImage:IMAGE(@"kj_writeboll") forState:UIControlStateNormal];
                    [btn setTitleColor:BLACK forState:UIControlStateNormal];
                }
            }
        }
        
        return cell;
       
    }else if(self.type == CPTBuyTicketType_NiuNiu_KuaiLe){
        OpenListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OpenListTableViewCellID forIndexPath:indexPath];
        cell.type = self.type;
        [cell configUI];
        cell.backgroundColor = CLEAR;
        
        ChongqinInfoModel *model = self.dataSource[indexPath.row];
        [cell sscModel:model];
        for (UIButton *btn in cell.titleBtnArray) {
            
            if (indexPath.row == 0) {
                [btn setBackgroundImage:IMAGE(@"kj_orangeboll") forState:UIControlStateNormal];
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
            }else{
                [btn setBackgroundImage:IMAGE(@"kj_writeboll") forState:UIControlStateNormal];
                [btn setTitleColor:BLACK forState:UIControlStateNormal];
            }
        }
        return cell;
    }else if(self.type == CPTBuyTicketType_NiuNiu_JiShu){
        OpenListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OpenListTableViewCellID forIndexPath:indexPath];
        cell.type = self.type;
        [cell configUI];
        cell.backgroundColor = CLEAR;
        PK10InfoModel *model = self.dataSource[indexPath.row];
        [cell pk10Model:model];
        return cell;
    }else if(self.type == CPTBuyTicketType_NiuNiu_AoZhou){
        OpenListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OpenListTableViewCellID forIndexPath:indexPath];
        cell.type = self.type;
        [cell configUI];
        cell.backgroundColor = CLEAR;
        PK10InfoModel *firstmodel = self.dataSource[indexPath.row];
//        firstmodel.nextTime = _model.aozhouF1.nextTime;
//        firstmodel.issue = _model.aozhouF1.issue;
//        firstmodel.nextIssue = [_model.aozhouF1.nextIssue integerValue];
//        firstmodel.nextTime = _model.aozhouF1.nextTime;
//        firstmodel.number = _model.aozhouF1.number;
//        firstmodel.niuWinner = _model.nnAozhou.niuWinner;
        [cell pk10Model:firstmodel];
        return cell;
    }else if(self.type == CPTBuyTicketType_FantanSSC){
        
        OpenListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OpenListTableViewCellID forIndexPath:indexPath];
        cell.type = self.type;
        [cell configUI];
        cell.backgroundColor = CLEAR;
        ChongqinInfoModel *firstmodel = self.dataSource[indexPath.row];
//        firstmodel.nextTime = firstmodel.nextTime;
//        firstmodel.issue = firstmodel.issue;
//        firstmodel.nextIssue = firstmodel.nextIssue;
//        firstmodel.nextTime = firstmodel.nextTime;
//        firstmodel.numbers = [firstmodel.number componentsSeparatedByString:@","];
        [cell sscModel:firstmodel];
        for (UIButton *btn in cell.titleBtnArray) {
            
            if (indexPath.row == 0) {
                [btn setBackgroundImage:IMAGE(@"kj_orangeboll") forState:UIControlStateNormal];
                [btn setTitleColor:WHITE forState:UIControlStateNormal];
            }else{
                [btn setBackgroundImage:IMAGE(@"kj_writeboll") forState:UIControlStateNormal];
                [btn setTitleColor:BLACK forState:UIControlStateNormal];
            }
        }
        return cell;
//
//        ChongqinInfoModel *firstmodel = [[ChongqinInfoModel alloc] init];
//        firstmodel.nextTime = model.fantanSSC.nextTime;
//        firstmodel.issue = model.fantanSSC.issue;
//        firstmodel.nextIssue = model.fantanSSC.nextIssue;
//        firstmodel.nextTime = model.fantanSSC.nextTime;
//        firstmodel.numbers = [_model.fantanSSC.number componentsSeparatedByString:@","];
//        [cell sscModel:firstmodel];
    }else{
        
        OpenListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OpenListTableViewCellID forIndexPath:indexPath];
        cell.type = self.type;
        [cell configUI];
        
        return cell;
    }
}

- (UIImage *)getBackgroundImage:(UIColor *)color size:(CGSize)size{
    
    UIImage *bacgrroundImage = [[UIImage imageWithColor:color size:size] circleImage];
    return bacgrroundImage;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     if (self.type == CPTBuyTicketType_DaLetou || self.type == CPTBuyTicketType_PaiLie35|| self.type == CPTBuyTicketType_HaiNanQiXingCai|| self.type == CPTBuyTicketType_Shuangseqiu|| self.type == CPTBuyTicketType_3D|| self.type == CPTBuyTicketType_QiLecai|| self.type == CPTBuyTicketType_AoZhouACT|| self.type == CPTBuyTicketType_NiuNiu_JiShu|| self.type == CPTBuyTicketType_NiuNiu_AoZhou|| self.type == CPTBuyTicketType_NiuNiu_KuaiLe|| self.type == CPTBuyTicketType_FantanPK10|| self.type == CPTBuyTicketType_FantanXYFT|| self.type == CPTBuyTicketType_FantanSSC|| self.type == CPTBuyTicketType_TJSSC|| self.type == CPTBuyTicketType_TenSSC|| self.type == CPTBuyTicketType_FiveSSC || self.type == CPTBuyTicketType_AoZhouShiShiCai || self.type == CPTBuyTicketType_JiShuSSC|| self.type == CPTBuyTicketType_OneLiuHeCai|| self.type == CPTBuyTicketType_FiveLiuHeCai|| self.type == CPTBuyTicketType_ShiShiLiuHeCai|| self.type == CPTBuyTicketType_TenPK10|| self.type == CPTBuyTicketType_FivePK10|| self.type == CPTBuyTicketType_JiShuPK10|| self.type == CPTBuyTicketType_AoZhouF1){

        return;
        
    }
    
    IGKbetDetailCtrl *detail = [[IGKbetDetailCtrl alloc]init];
    detail.lotteryname = self.titlestring;
    detail.lottery_type = self.type;
    detail.type = self.type;

    if (self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC || self.type == CPTBuyTicketType_FFC) {//时时彩系列

        PCHistoryModel *model = [self.dataSource objectAtIndex:indexPath.row];
        detail.pcmodel = model;
    }
    else if (self.type == CPTBuyTicketType_LiuHeCai) {//六合彩系列
        
        SixInfoModel *model = [self.dataSource objectAtIndex:indexPath.row];
        detail.sixmodel = model;
    }
    else if (self.type == CPTBuyTicketType_PK10 || self.type == CPTBuyTicketType_XYFT) {//PK10
        
        PK10HistoryModel *model = [self.dataSource objectAtIndex:indexPath.row];
        detail.pk10model = model;
    }else if(self.type == CPTBuyTicketType_PCDD){
        PCHistoryModel *model = [self.dataSource objectAtIndex:indexPath.row];
        detail.pcmodel = model;
    }
    
    PUSH(detail);
}

-(void)initData {
    
    
    if (self.type == CPTBuyTicketType_PK10 || self.type == CPTBuyTicketType_XYFT ) {
        
        [self initbeijinDdata];
    }
    else if (self.type == CPTBuyTicketType_LiuHeCai) {
        
        [self initsixData];
    }
    else if (self.type == CPTBuyTicketType_SSC || self.type == CPTBuyTicketType_XJSSC || self.type == CPTBuyTicketType_FFC ) {
        
        [self initchongqinData];
    }
    else{
        [self initOtherData];
    }
}
#pragma mark - PC数据
-(void)initPCData {
    
    @weakify(self)
    [WebTools postWithURL:@"/pceggSg/getSgHistoryList.json" params:@{@"pageNum":@(self.page),@"pageSize":@30} success:^(BaseData *data) {
        @strongify(self)
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = [PCHistoryModel mj_objectArrayWithKeyValuesArray:data.data];
        
        [self.dataSource addObjectsFromArray:array];
        
        [self endRefresh:self.tableView WithdataArr:data.data];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)

        [self endRefresh:self.tableView WithdataArr:nil];
    } showHUD:NO];
}

#pragma mark 海南七星彩/双色球/大乐透/七星彩/福彩3D
-(void)initOtherData {
    
    @weakify(self)
    [WebTools postWithURL:@"/sg/lishiSg.json" params:@{@"id":@(self.type),@"pageNum":@(self.page),@"pageSize":@30} success:^(BaseData *data) {
        @strongify(self)
        
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }

        if (data.data[@"list"] && [data.data[@"list"] isKindOfClass:[NSArray class]]) {
            
            if (self.type == CPTBuyTicketType_LiuHeCai||self.type == CPTBuyTicketType_OneLiuHeCai||self.type == CPTBuyTicketType_FiveLiuHeCai||self.type == CPTBuyTicketType_ShiShiLiuHeCai) {//六合彩
                NSArray *array = [SixInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                [self.dataSource addObjectsFromArray:array];

            }else if (self.type == CPTBuyTicketType_TenPK10 ||self.type == CPTBuyTicketType_FivePK10 ||self.type == CPTBuyTicketType_JiShuPK10 ||self.type == CPTBuyTicketType_FantanPK10||self.type == CPTBuyTicketType_FantanXYFT || self.type == CPTBuyTicketType_PCDD || self.type == CPTBuyTicketType_AoZhouF1){
                NSArray *array = [PK10HistoryModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                [self.dataSource addObjectsFromArray:array];
                MBLog(@"%@", array.firstObject);

            }else if(self.type == CPTBuyTicketType_FantanSSC){
                
                NSArray *array = [ChongqinInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                [self.dataSource addObjectsFromArray:array];
                
            }else if (self.type == CPTBuyTicketType_NiuNiu_KuaiLe){
                
                NSArray *array = [ChongqinInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                [self.dataSource addObjectsFromArray:array];
            }else if(self.type == CPTBuyTicketType_NiuNiu_JiShu){
                
                NSArray *array = [PK10InfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                [self.dataSource addObjectsFromArray:array];

            }else if(self.type == CPTBuyTicketType_NiuNiu_AoZhou){
                
                NSArray *array = [PK10InfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                [self.dataSource addObjectsFromArray:array];
                
            }else{
                NSArray *array = [PCHistoryModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
                
                [self.dataSource addObjectsFromArray:array];

            }
            
            [self endRefresh:self.tableView WithdataArr:data.data[@"list"]];
        }

        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)
        
        [self endRefresh:self.tableView WithdataArr:nil];
    }showHUD:YES];
}

#pragma mark - 北京PK10/幸运快艇数据/PK10番摊/幸运飞艇番摊/极速时时彩番摊
-(void)initbeijinDdata {
    
    NSString *url = nil;
    if (self.type == CPTBuyTicketType_PK10) {//北京PK10
        url = @"/bjpksSg/historySg.json";
    }else if (self.type == CPTBuyTicketType_XYFT) {//幸运飞艇
        url = @"/xyftSg/historySg.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"type":@"301",@"pageNum":@(self.page),@"pageSize":@30} success:^(BaseData *data) {
        @strongify(self)
        if ([data.data isKindOfClass:[NSArray class]]) {
            
            NSArray *array = [PK10HistoryModel mj_objectArrayWithKeyValuesArray:data.data];
            
            if (self.page == 1) {
                
                [self.dataSource removeAllObjects];
            }
            
            [self.dataSource addObjectsFromArray:array];
            
            [self endRefresh:self.tableView WithdataArr:array];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)

        [self endRefresh:self.tableView WithdataArr:nil];
    }showHUD:YES];
}

#pragma mark - 重庆时时彩/新疆时时彩/比特币分分彩/天津时时彩/10分时时彩/5分时时彩/极速时时彩/澳洲时时彩/快乐牛牛/极速时时彩番摊/排列3/5
-(void)initchongqinData {
    
    NSString *url = nil;
    if (self.type == CPTBuyTicketType_SSC) {//重庆时时彩
        url = @"/cqsscSg/lishiSg.json";
    }else if (self.type == CPTBuyTicketType_XJSSC) {//新疆时时彩
        url = @"/xjsscSg/lishiSg.json";
    }else if (self.type == CPTBuyTicketType_FFC) {//比特币分分彩
        url = @"/txffcSg/lishiSg.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageNum":@(self.page),@"pageSize":@30} success:^(BaseData *data) {
        @strongify(self)
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        if (data.data[@"list"] && [data.data[@"list"] isKindOfClass:[NSArray class]]) {
            
            NSArray *array = [PCHistoryModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
            
            [self.dataSource addObjectsFromArray:array];
            
            [self endRefresh:self.tableView WithdataArr:data.data[@"list"]];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)

        [self endRefresh:self.tableView WithdataArr:nil];
    }showHUD:YES];
}
#pragma mark - 六合彩/1分六合彩/5分六合彩/时时六合彩
-(void)initsixData {
    
    NSString *url = nil;
    if (self.type == CPTBuyTicketType_LiuHeCai) {
        url = @"/lhcSg/lishiSg.json";
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:@{@"pageNum":@(self.page),@"pageSize":@30} success:^(BaseData *data) {
        @strongify(self)
        if (self.page == 1) {
            
            [self.dataSource removeAllObjects];
        }
        
        if (data.data[@"list"] && [data.data[@"list"] isKindOfClass:[NSArray class]]) {
            
            NSArray *array = [SixInfoModel mj_objectArrayWithKeyValuesArray:data.data[@"list"]];
            
            [self.dataSource addObjectsFromArray:array];
            
            [self endRefresh:self.tableView WithdataArr:data.data];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self)

        [self endRefresh:self.tableView WithdataArr:nil];
    } showHUD:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
