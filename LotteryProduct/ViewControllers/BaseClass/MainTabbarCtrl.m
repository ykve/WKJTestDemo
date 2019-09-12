//
//  MainTabbarCtrl.m
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/7.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import "MainTabbarCtrl.h"
#import "HomeCtrl.h"

#import "AppDelegate.h"
#import "CircleCtrl.h"
#import "MineCtrl.h"
#import "LoginAlertViewController.h"
#import "YQJPushManager.h"
#import "MessageCenterViewController.h"
#import "AppDelegate.h"
#import "ZAlertViewManager.h"
#import "BettingRecordViewController.h"
#import "CPTOpenLotteryRootCtrlViewController.h"
#import "MineInfoViewController.h"
#import "LiveOpenLotteryViewController.h"
#import "CartCtrl.h"
#import "CPTHomeCtrl.h"
#import "TestTabBar.h"
@interface MainTabbarCtrl ()<UITabBarControllerDelegate,YQJPushManagerDelegate,AxcAE_TabBarDelegate>
{
    //    UIImageView *selectimgv;
    
}



@end

@implementation MainTabbarCtrl

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    [self addChildViewControllers];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginout) name:@"LOGINOUT" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buylottery) name:@"BUYLOTTERY" object:nil];
    
    [YQJPushManager addListener:self];
    self.axcTabBar.backgroundColor = [[CPTThemeConfig shareManager] CO_TabBarBackground];
    
    UIView * xx = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    [self.axcTabBar insertSubview:xx aboveSubview:self.axcTabBar.backgroundImageView];
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        xx.backgroundColor = [UIColor hexStringToColor:@"#E6E6E6"];
    }else{
        xx.backgroundColor = [UIColor hexStringToColor:@"3e404a"];
    }
}

- (void)addChildViewController:(RootCtrl *)child title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    
    [child.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] CO_TabBarTitle_Normal]} forState:UIControlStateNormal];
    [child.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[[CPTThemeConfig shareManager] CO_TabBarTitle_Selected]} forState:UIControlStateSelected];
    //    UIImage *imagex = [self scaleImage:image toScale:1.0];
    //    UIImage *selectimagex = [self scaleImage:selectedImage toScale:1.0];
    //    child.tabBarItem.image = SCREEN_WIDTH > 375 ? imagex : image;
    //    child.tabBarItem.selectedImage = [SCREEN_WIDTH > 375 ? selectimagex : selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    child.tabBarItem.image = image;
    //    child.tabBarItem.selectedImage
    child.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    child.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    child.tabBarItem.title = title;
    [self addChildViewController:child];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[MineCtrl class]]) {
        if ([Person person].uid == nil) {
            
            LoginAlertViewController *login = [[LoginAlertViewController alloc]initWithNibName:NSStringFromClass([LoginAlertViewController class]) bundle:[NSBundle mainBundle]];
            login.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:login animated:YES completion:nil];
            login.loginBlock = ^(BOOL result) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
            };
            return NO;
        }
    }
    
    
    return YES;
}

//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//    if (item.tag == 4) {
//
//        MBLog(@"111");
//    }
//}

//完成代理方法
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if([viewController isKindOfClass:[HomeCtrl class]]){
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString *isChangeSkin = [user valueForKey:@"isChangeSkin"];
        if([isChangeSkin isEqualToString:@"1"]){
            [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"isChangeSkin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
    if ([viewController isKindOfClass:[MineCtrl class]]) {
        
        RootCtrl *rootVc = self.selectedViewController;
        rootVc.titlelab.textColor = [[CPTThemeConfig shareManager] MineTitleStrColor];
        [rootVc.rightBtn setTitleColor:[[CPTThemeConfig shareManager] MineTitleStrColor] forState:UIControlStateNormal];
        
    } else {
        
        RootCtrl *rootVc = self.selectedViewController;
        rootVc.titlelab.textColor = [[CPTThemeConfig shareManager] CO_NavigationBar_TintColor];
        [rootVc.rightBtn setTitleColor:[[CPTThemeConfig shareManager] CO_NavigationBar_Title] forState:UIControlStateNormal];
    }
}

-(void)loginout {
    
    self.selectedIndex = 0;
    //    LoginCtrl *login = [[LoginCtrl alloc]initWithNibName:NSStringFromClass([LoginCtrl class]) bundle:[NSBundle mainBundle]];
    //    login.loginBlock = ^(BOOL result) {
    //
    //        [Person person].showlogin = NO;
    //    };
    //    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    //    nav.navigationBar.hidden = YES;
    //    if ([[AppDelegate currentViewController] isKindOfClass:[login class]]) {
    //        return;
    //    }
    //    [[AppDelegate currentViewController].navigationController presentViewController:nav animated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)buylottery {
    
    self.selectedIndex = 2;
}

-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    MBLog(@"推送数据：%@",userInfo);
    
    NSString *msgtype = [userInfo valueForKey:@"msgType"];
    NSString *title = nil;
    
    if([userInfo[@"aps"][@"alert"] isKindOfClass:[NSDictionary class]]) {
        
        title = [[CPTBuyDataManager shareManager] changeTypeToString:msgtype.integerValue];
        if([title isEqualToString:@" "]){
            title = userInfo[@"aps"][@"alert"][@"title"];
        }else{
            title = [title stringByAppendingString:userInfo[@"aps"][@"alert"][@"body"]];
        }
    }else{
        title = userInfo[@"aps"][@"alert"];
    }
    
    if ([msgtype isEqualToString:@"win_push"] && [[[NSUserDefaults standardUserDefaults] valueForKey:@"lottery_voice"]boolValue]) {
        
        [[ZAlertViewManager shareManager]showVoice:@"中奖"];
        
    }
    else if ([msgtype isEqualToString:@"open_push"]  && [[[NSUserDefaults standardUserDefaults] valueForKey:@"lottery_voice"]boolValue]) {
        
        [[ZAlertViewManager shareManager]showVoice:@"开奖"];
    }
    else{
        [[ZAlertViewManager shareManager]showVoice:nil];
    }
    
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    
    if (state == UIApplicationStateBackground) {
        
        [self push:msgtype];
    }
    else{
        [[ZAlertViewManager shareManager] showWithType:AlertViewTypeMessage title:title];
        
        @weakify(self)
        [[ZAlertViewManager shareManager] didSelectedAlertViewWithBlock:^{
            @strongify(self)
            [self push:msgtype];
        }];
        
        [[ZAlertViewManager shareManager]dismissAlertWithTime:5];
    }
    
    
    
}

-(void)push:(NSString *)msgtype {
    
    if ([msgtype isEqualToString:@"win_push"]) {
        
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
        
        BettingRecordViewController *bettingRecordVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"BettingRecordViewController"];
        
        [[AppDelegate currentViewController].navigationController pushViewController:bettingRecordVC animated:YES];
    }
    else if ([msgtype isEqualToString:@"open_push"]) {
        [[AppDelegate currentViewController].navigationController popToRootViewControllerAnimated:YES];
        self.selectedIndex = 1;
    }
    else if([msgtype isEqualToString:@"1201"]){
        BOOL isHaveVC = NO;
        for(UIViewController *vc in self.selectedViewController.navigationController.viewControllers){
            if([vc isKindOfClass:[LiveOpenLotteryViewController class]]){
                isHaveVC = YES;
                break;
            }
        }
        if(!isHaveVC){
            LiveOpenLotteryViewController *liveVc = [[UIStoryboard storyboardWithName:@"Fantan" bundle:nil] instantiateViewControllerWithIdentifier:@"LiveOpenLotteryViewController"];
            liveVc.lotteryId = CPTBuyTicketType_LiuHeCai;
            liveVc.lottery_oldID = 4;
            [self.selectedViewController.navigationController pushViewController:liveVc animated:YES];
        }
    }
    else{
        [[AppDelegate currentViewController].navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MessageCenterViewController"] animated:YES];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [YQJPushManager removeListener:self];
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewControllers{
    
    // 创建选项卡的数据 想怎么写看自己，这块我就写笨点了
    NSArray <NSDictionary *>*VCArray =
    @[@{@"vc":[[CPTHomeCtrl alloc]init],@"normalImg":[[CPTThemeConfig shareManager] IC_TabBar_Home],@"selectImg":[[CPTThemeConfig shareManager] IC_TabBar_Home_Selected],@"itemTitle":@"主页"},
      @{@"vc":[[CPTOpenLotteryRootCtrlViewController alloc]init],@"normalImg":[[CPTThemeConfig shareManager] IC_TabBar_KJ_],@"selectImg":[[CPTThemeConfig shareManager] IC_TabBar_KJ_Selected],@"itemTitle":@"开奖"},
      @{@"vc":[[CartCtrl alloc]init],@"normalImg":[[CPTThemeConfig shareManager] IC_TabBar_GC],@"selectImg":[[CPTThemeConfig shareManager] IC_TabBar_GC_Selected],@"itemTitle":@"购彩"},
      @{@"vc":[[CircleCtrl alloc]init],@"normalImg":[[CPTThemeConfig shareManager] IC_TabBar_QZ],@"selectImg":[[CPTThemeConfig shareManager] IC_TabBar_QZ_Selected],@"itemTitle":@"圈子"},
      @{@"vc":[[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"MineCtrl"],@"normalImg":[[CPTThemeConfig shareManager] IC_TabBar_Me],@"selectImg":[[CPTThemeConfig shareManager] IC_TabBar_Me_Selected],@"itemTitle":@"我的"}];
    // 1.遍历这个集合
    // 1.1 设置一个保存构造器的数组
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    // 1.2 设置一个保存VC的数组
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 2.根据集合来创建TabBar构造器
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        // 3.item基础数据三连
        model.itemTitle = [obj objectForKey:@"itemTitle"];
        model.selectImageName = [obj objectForKey:@"selectImg"];
        model.normalImageName = [obj objectForKey:@"normalImg"];
        // 4.设置单个选中item标题状态下的颜色
        model.selectColor = [[CPTThemeConfig shareManager] CO_TabBarTitle_Selected];
        model.normalColor = [[CPTThemeConfig shareManager] CO_TabBarTitle_Normal];
        
        /***********************************/
        if (idx == 2 ) { // 如果是中间的
            // 设置凸出 矩形
            model.bulgeStyle = AxcAE_TabBarConfigBulgeStyleSquare;
            // 设置凸出高度
            model.bulgeHeight = 16;
            // 设置成图片文字展示
            model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTopPictureBottomTitle;
            // 设置图片
            model.selectImageName = [[CPTThemeConfig shareManager] IC_TabBar_GC_Selected];
            model.normalImageName = [[CPTThemeConfig shareManager] IC_TabBar_GC];
            model.selectBackgroundColor = model.normalBackgroundColor = [UIColor clearColor];
            model.backgroundImageView.hidden = YES;
            // 设置图片大小c上下左右全边距
            model.componentMargin = UIEdgeInsetsMake(0, 0, 0, 0 );
            // 设置图片的高度为40
            model.icomImgViewSize = CGSizeMake(self.tabBar.frame.size.width / 5, 47);
            model.titleLabelSize = CGSizeMake(self.tabBar.frame.size.width / 5, 20);
            // 图文间距0
            model.pictureWordsMargin = 0;
            // 设置标题文字字号
            model.titleLabel.font = [UIFont systemFontOfSize:11];
            // 设置大小/边长 自动根据最大值进行裁切
            model.itemSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 5.0 ,self.tabBar.frame.size.height + 20);
        }else{  // 其他的按钮来点小动画吧
            // 来点效果好看
            //            model.interactionEffectStyle = AxcAE_TabBarInteractionEffectStyleSpring;
            // 点击背景稍微明显点吧
            //            model.selectBackgroundColor = AxcAE_TabBarRGBA(248, 248, 248, 1);
            model.normalBackgroundColor = [UIColor clearColor];
        }
        // 备注 如果一步设置的VC的背景颜色，VC就会提前绘制驻留，优化这方面的话最好不要这么写
        // 示例中为了方便就在这写了
        UIViewController *vc = [obj objectForKey:@"vc"];
        //        vc.view.backgroundColor = [UIColor whiteColor];
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:vc];
        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];
    // 使用自定义的TabBar来帮助触发凸起按钮点击事件
    TestTabBar *testTabBar = [TestTabBar new];
    [self setValue:testTabBar forKey:@"tabBar"];
    // 5.2 设置VCs -----
    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
    self.viewControllers = tabBarVCs;
    //////////////////////////////////////////////////////////////////////////
    // 注：这里方便阅读就将AE_TabBar放在这里实例化了 使用懒加载也行
    // 6.将自定义的覆盖到原来的tabBar上面
    // 这里有两种实例化方案：
    // 6.1 使用重载构造函数方式：
    //    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    // 6.2 使用Set方式：
    self.axcTabBar = [AxcAE_TabBar new] ;
    self.axcTabBar.tabBarConfig = tabBarConfs;
    // 7.设置委托
    self.axcTabBar.delegate = self;
    self.axcTabBar.backgroundColor = [UIColor whiteColor];
    // 8.添加覆盖到上边
    [self.tabBar addSubview:self.axcTabBar];
    [self addLayoutTabBar]; // 10.添加适配
}
// 9.实现代理，如下：
static NSInteger lastIdx = 0;
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    //    if (index != 2) { // 不是中间的就切换
    // 通知 切换视图控制器
    [self setSelectedIndex:index];
    lastIdx = index;
    //    }else{ // 点击了中间的
    //
    //        [self.axcTabBar setSelectIndex:lastIdx WithAnimation:NO]; // 换回上一个选中状态
    //        // 或者
    //        //        self.axcTabBar.selectIndex = lastIdx; // 不去切换TabBar的选中状态
    //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击了中间的,不切换视图"
    //                                                                          preferredStyle:UIAlertControllerStyleAlert];
    //        [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //            NSLog(@"好的！！！！");
    //        }])];
    //        [self presentViewController:alertController animated:YES completion:nil];
    //    }
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if(self.axcTabBar){
        self.axcTabBar.selectIndex = selectedIndex;
        if(selectedIndex != 2 && selectedIndex !=4){
            if([[Person person] uid]){
                [[Person person] checkIsNeedRMoney:^(double money) {
                } isNeedHUD:NO];
            }
        }
    }
}

// 10.添加适配
- (void)addLayoutTabBar{
    // 使用重载viewDidLayoutSubviews实时计算坐标 （下边的 -viewDidLayoutSubviews 函数）
    // 能兼容转屏时的自动布局
    MBLog(@"1");
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
}




@end
