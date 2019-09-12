//
//  CPTBuyHomeCtrl
//  LotteryProduct
//
//  Created by vsskyblue on 2018/5/24.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CPTBuyHomeCtrl.h"
#import "CartBeijinPK10Ctrl.h"
#import "CartPCCtrl.h"
#import "CartSixCtrl.h"
#import "CartHomeModel.h"
#import "CartHomeCell.h"
#import "CartHomeCollectionViewCell.h"
#import "CartHomeHeaderView.h"
#import "CartChongqingBPanViewController.h"
#import "CartBPanBeijingPKViewController.h"
#import "CartHomeFooterCollectionReusableView.h"
#import "CrartHomeSubModel.h"
#import "CartBuyAGCell.h"
#import "LoginAlertViewController.h"
#import "CPTBuySexViewController.h"
#import "CPTWebViewController.h"
#define kLineItem 2
#define kLineItem2 1


@interface CPTBuyHomeCtrl ()< UICollectionViewDataSource, UICollectionViewDelegate,CartHomeHeaderViewDelegate>

@property (nonatomic, assign) NSInteger curenttime;
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
@property (nonatomic, strong)UICollectionView *collectView;
@property (nonatomic, assign)BOOL isShowFooter;

//记录点击的 section
@property (nonatomic, assign)NSInteger sectionNum;

@property (nonatomic, assign)NSIndexPath* selectIndexPath;

@property (nonatomic, strong) CartHomeModel *selectModel;

@property (nonatomic, weak)CartHomeHeaderView *footer;

@property (nonatomic, assign) BOOL isSelected;

//@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation CPTBuyHomeCtrl
{
    NSArray *_qipaiIDArr;
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _qipaiIDArr = @[@"620",@"720",@"830",@"220",@"860",@"900",@"600",@"870",@"230",@"730",@"630",@"380",@"610",@"910",@"920",@"930",@"650"];
//nameA = @[@"德州扑克",@"二八杠",@"抢庄牛牛",@"炸金花",@"三公",@"押庄龙虎",@"21点",@"通比牛牛",@"抢庄牌九",@"十三水",@"斗地主", @"百家乐",@"森林舞会", @"百人牛牛", @"万人扎金花", @"血流成河"];
    if(!_dataSource){
        _dataSource = [NSMutableArray array];
    }
    self.view.backgroundColor = CLEAR;
//    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT+40, SCREEN_WIDTH, SCREEN_HEIGHT-40-NAV_HEIGHT-Tabbar_HEIGHT)];

    _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40-NAV_HEIGHT-Tabbar_HEIGHT) collectionViewLayout:self.layout];
    self.myCollectionView.backgroundColor = [[CPTThemeConfig shareManager] Buy_HomeView_BackgroundColor];
    self.myCollectionView.showsVerticalScrollIndicator = NO;
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CartHomeCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CartHomeCollectionViewCellID];
    [self.myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"buyLotteryTopLineID"];
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CartHomeHeaderView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CartHomeHeaderViewID];
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CartHomeHeaderView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CartHomeHeaderViewID];
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CartBuyAGCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CartBuyAGCell"];

    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.view addSubview:self.myCollectionView];
//    [self.dataSource addObjectsFromArray:[Tools readDataFromPlistFile:@"buyLotteryPlist.plist"]];
    if([AppDelegate shareapp].wkjScheme == Scheme_LotterEight){
        self.myCollectionView.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
    }
    NSArray * nameA;
    NSArray * imageNameA ;
    NSArray * subtitles;
    switch (self.type) {
        case CPTBuyHomeType_QiPai:
        {
            nameA = @[@"德州扑克",@"二八杠",@"抢庄牛牛",@"炸金花",@"三公",@"押庄龙虎",@"21点",@"通比牛牛",@"极速炸金花",@"抢庄牌九",@"十三水",@"幸运五张",@"斗地主", @"百家乐",@"森林舞会", @"百人牛牛",  @"血流成河"];
            imageNameA = @[[[CPTThemeConfig shareManager] BuyLotteryQPdzGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPerBaGangGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPqznnGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPzjhGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPsgGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPyzlhGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPesydGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPtbnnGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPjszjhGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPqzpjGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPsssGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPxywzGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPDDZGrayImageName], [[CPTThemeConfig shareManager] BuyLotteryQPBJLGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPSLWHGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPBRNNGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryQPXLCHGrayImageName]];
            subtitles = @[@"挑战经典德州", @"比胆略比智慧", @"抢庄嗨翻天", @"简单轻松上手", @"气氛热烈火爆", @"龙虎即刻开战", @"棋牌经典之作", @"超爽快超刺激",@"开局激烈过瘾", @"你的庄你做主", @"挑战至尊清龙",@"来拿幸运奖励", @"汇聚天下高手",@"最公平最公正",@"震撼视觉感官",@"独特创新玩法",@"陪你血战到底"];
        }
            break;
        case CPTBuyHomeType_ZhenRenShiXun:
        {
            nameA = @[@"AG国际厅",@"AG旗舰厅"];
            imageNameA = @[@"buy_zc_aggjt",@"buy_zc_agqjt"];
        }
            break;
        case CPTBuyHomeType_ZuCai:
        {
            nameA = @[@"竞彩足球",@"竞彩篮球",@"足球14场",@"任选9场"];
            imageNameA = @[[[CPTThemeConfig shareManager] BuyLotteryZCjczqGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryZCjclqGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryZCzqsscGrayImageName],[[CPTThemeConfig shareManager] BuyLotteryZCrxjcGrayImageName]];
            subtitles = @[@"最火爆的",@"天天赢大奖",@"投了就中奖",@"天天赢大奖"];
        }
            break;
        case CPTBuyHomeType_DianJing:
        {
            nameA = @[@"电竞"];
            imageNameA = @[@"buy_dianjing_unuse"];
        }
            break;
            
        default:
            break;
    }
    for(NSInteger i=0;i<nameA.count;i++){
        CartHomeModel * model = [[CartHomeModel alloc] init];
        if(self.type==CPTBuyHomeType_ZhenRenShiXun||self.type==CPTBuyHomeType_DianJing){
            model.cateName = imageNameA[i];
        }else{
            model.cateName = nameA[i];
        }
        model.name = nameA[i];
        model.intro = subtitles[i];
        [self.dataSource addObject:model];
    }
}

- (void)skipToBPan:(CrartHomeSubModel *)subModel{
    
//    NSInteger num = self.selectIndexPath.section * kLineItem_Number + self.selectIndexPath.item;
 
}

#pragma mark collectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionFooter) {
        if (self.isShowFooter) {
            
            CartHomeHeaderView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CartHomeHeaderViewID forIndexPath:indexPath];
            
            footer.delegate = self;
            
            self.footer = footer;
            
            self.footer.model = self.selectModel;
            
            for (UIView *view in footer.subviews) {
                NSLog(@"%@", view);
            }
            
            return footer;
            
        }else{
            return nil;
        }
    }else if(kind == UICollectionElementKindSectionHeader){
        
        if (indexPath.section != 0) {
            UICollectionReusableView *topLine = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"buyLotteryTopLineID" forIndexPath:indexPath];
            topLine.backgroundColor = [[CPTThemeConfig shareManager] CartSectionLineColor];

            return topLine;
        }else{
            return nil;
        }
        
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return CGSizeMake(SCREEN_WIDTH, 1);
    }else{
        return CGSizeMake(0, 0);
    }
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该彩种暂未开放" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([Person person].uid == nil) {
        LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
        login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:login animated:YES completion:nil];
        return;
    }
    if(self.type == CPTBuyHomeType_QiPai){//棋牌
        
        NSString *gameId = _qipaiIDArr[indexPath.row+indexPath.section*2];
        MBLog(@"---%@",gameId);
        @weakify(self)
        NSDictionary *dic = @{@"userId":[Person person].uid,@"account":[Person person].account,@"kindId":gameId};
        [WebTools postWithURL:@"/ky/game.json" params:dic success:^(BaseData *data) {
            @strongify(self)
            if(data.status.integerValue == 1){
                MBLog(@"%@",data.data);
                NSString *url = data.data;
                CPTWebViewController *webVc = [[CPTWebViewController alloc] init];
                webVc.urlStr = url;
                webVc.isKY = YES;
                PUSH(webVc);
            }else{
                [MBProgressHUD showMessage:data.info];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }else if(self.type == CPTBuyHomeType_ZhenRenShiXun){//真人视讯
        
        NSDictionary *dic = @{@"userId":[Person person].uid,@"account":[Person person].account,@"actype":@"1",@"gameType":@(18)};
        @weakify(self)
        [WebTools postWithURL:@"/ag/agJump.json" params:dic success:^(BaseData *data) {
            @strongify(self)
            if(data.status.integerValue == 1){
                MBLog(@"%@",data.data);
                NSString *url = data.data;
                CPTWebViewController *webVc = [[CPTWebViewController alloc] init];
                webVc.isGame = YES;
                webVc.isAG = YES;
                webVc.urlStr = url;
                PUSH(webVc);
            }else{
                [MBProgressHUD showMessage:data.info];
            }
        } failure:^(NSError *error) {
            MBLog(@"%@",error.description);
        }];
    }else if(self.type == CPTBuyHomeType_DianJing){//电竞
        NSDictionary *dic = @{@"userId":[Person person].uid,@"account":[Person person].account};
        @weakify(self)
        [WebTools postWithURL:@"/esgame/go.json" params:dic success:^(BaseData *data) {
            @strongify(self)
            if(data.status.integerValue == 1){
                MBLog(@"%@",data.data);
                NSString *url = data.data;
                CPTWebViewController *webVc = [[CPTWebViewController alloc] init];
                webVc.titlestring = @"电竞";
                webVc.isGame = YES;
                webVc.isAG = YES;
                webVc.urlStr = url;
                PUSH(webVc);
            }else{
                [MBProgressHUD showMessage:data.info];
            }
        } failure:^(NSError *error) {
            MBLog(@"%@",error.description);
        }];
//        [AlertViewTool alertViewToolShowMessage:@"研发中,敬请期待" fromController:self handler:nil];
    }else if(self.type == CPTBuyHomeType_ZuCai){//足彩
        [AlertViewTool alertViewToolShowMessage:@"研发中,敬请期待" fromController:self handler:nil];
    }
    
   
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"研发中，敬请期待" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    [alert addAction:defaultAction];
//    [self presentViewController:alert animated:YES completion:nil];
    
//    self.isShowFooter = YES;
//    self.sectionNum = indexPath.section;
//    self.selectIndexPath = indexPath;
//    self.isSelected = YES;
//
//    CartHomeModel *model = self.dataSource[indexPath.section * kLineItem + indexPath.item];
//
//    self.selectModel = model;
//
//    CartHomeCollectionViewCell *cell = (CartHomeCollectionViewCell *)[self.collectView cellForItemAtIndexPath:indexPath];
//
//    cell.isSelected = YES;
//
//    [self.myCollectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView* )collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (self.sectionNum == section) {
        if (self.isShowFooter) {
            
            CGSize size = CGSizeMake(SCREEN_WIDTH, ((self.selectModel.lotterys.count + 1)/2) * 50 + 80);
            return size;
            
        }else{
            return CGSizeZero;
        }
    }else{
        return CGSizeZero;
        
    }
    
}




- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0f, 15.0f, 0.0f, 15.0f);
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(self.type == CPTBuyHomeType_ZhenRenShiXun){
        return self.dataSource.count;
    }else{
        if (self.dataSource.count%kLineItem == 0) {
            return self.dataSource.count/kLineItem;
        }else{
            return self.dataSource.count/kLineItem + 1;
        }
    }
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //   self.dataSource.count - (section + 1) * kItem_Number
    if(self.type == CPTBuyHomeType_ZhenRenShiXun){
            return kLineItem2;
    }else{
        //如果能被每行的个数整除
        if (self.dataSource.count % kLineItem == 0) {
            //返回每行的个数
            return  kLineItem;
        }else{
            if (section == self.dataSource.count/kLineItem) {
                return self.dataSource.count % kLineItem;
            }else{
                return kLineItem;
            }
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger num;
    if(self.type == CPTBuyHomeType_ZhenRenShiXun || self.type == CPTBuyHomeType_DianJing ){
        num = indexPath.section * kLineItem2 + indexPath.item;
        CartBuyAGCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CartBuyAGCell" forIndexPath:indexPath];
        CartHomeModel *model = [self.dataSource objectAtIndex:num];
        cell.agImageV.image = IMAGE(model.cateName);
        return cell;
    }else{
        CartHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CartHomeCollectionViewCellID forIndexPath:indexPath];
        [[CPTThemeConfig shareManager] Buy_HomeView_BackgroundColor];
        num = indexPath.section * kLineItem + indexPath.item;

        CartHomeModel *model = [self.dataSource objectAtIndex:num];
        NSString * imageName = model.cateName;
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            imageName = [NSString stringWithFormat:@"tw_%@",imageName];
        }
        cell.icon.image = IMAGE(imageName);
        cell.titlelab.text = model.name;
        cell.subTitleLbl.text = model.intro;
        cell.isSelected = NO;
        //当选中的时候让色块出现
        if (indexPath == self.selectIndexPath){
            if (self.isSelected) {
                cell.isSelected = YES;
            }
        }
        cell.subTitleLbl.textColor = [[CPTThemeConfig shareManager] CO_Home_CellCartCellSubtitleText];
        cell.titlelab.textColor = [[CPTThemeConfig shareManager] CO_Home_CollectionView_CartCellTitle];
        cell.timelab.textColor = [UIColor lightGrayColor];
        return cell;
    }
    return nil;
}

-(UICollectionViewFlowLayout *)layout {
    
    if (!_layout) {
        
        CGFloat itemSpace = 0;
        
        _layout = [[UICollectionViewFlowLayout alloc]init];
        
        _layout.minimumInteritemSpacing = itemSpace;
        
        _layout.minimumLineSpacing = itemSpace;
        CGFloat itemWidth;
        if(self.type == CPTBuyHomeType_ZhenRenShiXun){
             itemWidth = SCREEN_WIDTH;
            _layout.itemSize = CGSizeMake(itemWidth, 249/SCAL);

        }else if (self.type == CPTBuyHomeType_DianJing){
            _layout.itemSize = CGSizeMake(SCREEN_WIDTH, 207/SCAL);
        }else{

             itemWidth = (SCREEN_WIDTH - 30 - itemSpace * (kLineItem + 1)) / kLineItem;
            _layout.itemSize = CGSizeMake(itemWidth, 110);
        }
        
        
        //        _layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30 + SCREEN_WIDTH * 0.4 + 10);
    }
    
    return _layout;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
