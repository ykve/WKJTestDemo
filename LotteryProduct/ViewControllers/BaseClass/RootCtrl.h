//
//  RootCtrl.h
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/6.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepairView.h"


static NSString *const RJCellIdentifier = @"CellIdentifier";        /**< Cell复用标识符 */
static NSString *const LiuHeTuKuLeftTableCellId = @"LiuHeTuKuLeftTableCellId";        /**< Cell复用标识符 */
static NSString *const LiuHeTuKuRemarkTableViewCellID = @"LiuHeTuKuRemarkTableViewCellID";
static NSString *const CircleHomeTableViewCellID = @"CircleHomeTableViewCellID";


static NSString *const HalfRedBoTableViewCellID = @"HalfRedBoTableViewCellID";        /**< Cell复用标识符 */
static NSString *const HalfBlueBoTableViewCellID = @"HalfBlueBoTableViewCellID";        /**< Cell复用标识符 */


static NSString *const CartHomeCollectionViewCellID = @"CartHomeCollectionViewCellID";        /**< Cell复用标识符 */

static NSString *const CartHomeHeaderViewID = @"CartHomeHeaderViewID";

static NSString *const CartHomeFooterCollectionReusableViewID = @"CartHomeFooterCollectionReusableViewID";


static NSString *const historyArticleCell = @"historyArticleCell";        /**< Cell复用标识符 */


static NSString *const MyArticleTableViewCellID = @"MyArticleTableViewCellID"; /**< Cell复用标识符 */

static NSString *const XMFHomeAdCollectionViewCell = @"XMFHomeAdCollectionViewCell";     /**< Cell复用标识符 */

static NSString *const RJHeaderIdentifier = @"HeaderIdentifier";     /**< 头部复用标识符 */

static NSString *const RJFooterIdentifier = @"FooterIdentifier";    /**< 尾部复用标识符 */

static NSString *const DoubleSideTotalDragonTableViewCellID = @"DoubleSideTotalDragonTableViewCellID"; 
static NSString *const OpenListTableViewCellID = @"OpenListTableViewCellID";



static NSString *const RJOtherIdentifier = @"RJOtherIdentifier";    /**< 备用复用标识符 */

static NSString *const AttentionCollectionViewCellID = @"AttentionCollectionViewCellID";

static NSString *const TouPiaoContentCollectionViewCellID = @"TouPiaoContentCollectionViewCellID";

static NSString *const LHDSHomeCellID = @"LHDSHomeCellID";


@interface RootCtrl : UIViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
/**
 列表
 */
@property (nonatomic, strong) UITableView *tableView;
/**
 滚动视图
 */
@property (nonatomic, strong) UIScrollView *scrollView;
/**
 列表当前页数
 */
@property (nonatomic, assign) int page;
/**
 列表数据集合
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSArray *dataArray;

/**
 导航栏Lab
 */
@property(nonatomic, strong) UILabel *titlelab;
/**
 导航栏名称
 */
@property(nonatomic, copy) NSString *titlestring;
/**
 导航右边按钮
 */
@property(nonatomic, strong) UIButton *rightBtn;
@property(nonatomic, strong) UIButton *rightBtn2;
/**
 导航栏
 */
@property(nonatomic, strong) UIView *navView;
/**
 导航左边按钮
 */
@property(nonatomic, strong) UIButton *leftBtn;

@property(nonatomic, strong) UIView *selectdateView;

@property (nonatomic, strong)UILabel *versionslab;

@property (nonatomic, strong)UILabel *timelab;

@property (nonatomic, strong)UIButton *dateBtn;


/**
 *导航栏右边按钮数组
 */
@property (nonatomic, strong)NSArray *rightBts;
/**
 = 1:重庆时时彩
 = 2:新疆时时彩
 = 3:比特币分分彩
 = 4：六合彩
 = 5:PC蛋蛋
 = 6：北京PK10
 = 7:幸运快艇
  11 澳洲F1赛车
 */
@property (nonatomic, assign) NSInteger lottery_type;
@property (nonatomic, assign) NSInteger lottery_oldID;

@property(nonatomic, copy) void (^rightBlock)(UIButton *sender);
@property(nonatomic, copy) void (^rightBlock2)(UIButton *sender);

@property(nonatomic, copy) void (^leftBlock)(UIButton *sender);

@property(nonatomic, copy) void (^searchBlock)(NSString *search);

@property(nonatomic, copy) void (^dateBlock)(UIButton *sender);

@property(nonatomic, copy) void (^refreshBlock)(void);

@property(nonatomic, strong) UITextField *searchfield;

-(void)rigBtn:(NSString *)title Withimage:(NSString *)img With:(void (^)(UIButton *sender))Click;
-(void)rigBtn2:(NSString *)title Withimage:(NSString *)img With:(void (^)(UIButton*sender))Click;

-(void)leftBtn:(NSString *)title Withimage:(NSString *)img With:(void (^)(UIButton *sender))Click;

-(void)hiddenavView;

-(void)setwhiteC;

/**
 返回上层
 */
-(void)popback;

/**
  返回根视图
 */
-(void)poproot;

/**
 返回上几层
 */
- (void)popIndex:(int)page;

-(void)endRefresh:(UIScrollView *)scrollView WithdataArr:(NSArray *)dataArray;

/**
 拨打电话
 */
-(void)callphone:(NSString *)phone;


-(void)setmenuBtn:(NSString *)imageName;
/**
 历史开奖，遗漏统计
 type = 1:重庆时时彩
 = 2：六合彩
 = 3：北京PK10
 = 4:PC蛋蛋
 */
-(void)buildTimeViewWithType:(NSInteger)type With:(void (^)(UIButton*sender))Click With:(void(^)(void))refresh;

/**
 未登录弹出登录
 */
-(void)showlogin:(void (^)(BOOL success))success;
-(void)leftBtnImage:(NSString *)img With:(void (^)(UIButton *))Click;
-(void)rigBtnImage:(NSString *)img With:(void (^)(UIButton*sender))Click;
/**
 C(m,n)
 */
-(NSInteger)getstep:(NSInteger)m With:(NSInteger)n;

/**
 资讯要加个投注按钮
 */
-(void)buildBettingBtn;

- (void)buildDashenBtn;

- (void)buildKeFuBtn;

-(void)setshake;
-(void)shakeM;
- (void)removeBlock;

/**
 跳转到充值页面
 **/
-(void)addmoneyClick;
- (void)buildKeFuBtnByName:(NSString *)changeName;

- (void)showNoDataImageView;
- (void)hiddenNoDataImageView;
@end
