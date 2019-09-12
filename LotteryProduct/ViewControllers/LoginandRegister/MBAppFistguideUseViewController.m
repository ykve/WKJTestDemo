//
//  MBAppFistguideUseViewController.m
//  WorldElectronic
//
//  Created by 马波 on 16/8/6.
//  Copyright © 2016年 MB. All rights reserved.
//

#import "MBAppFistguideUseViewController.h"
#import "MainTabbarCtrl.h"
#import "NavigationVCViewController.h"
#import "AppDelegate.h"
//定义新特性展示的相片数
#define ImageCounts 3

@interface MBAppFistguideUseViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property(weak, nonatomic)UIPageControl *pageView;

@end

@implementation MBAppFistguideUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    // 因为展示的新特性是ScrollView所以需要创建
    [self setScrollView];
    
    // 设置UIPageControl
    [self setPageControlView];
    
    [self skipfistImangeView:self.view];
    
    
    [self setupNoti];
    
}

- (void)setupNoti{
    
    [self setWithbool:NO Withkey:@"kj_cqssc"];
    
    
    [self setWithbool:YES Withkey:@"kj_xglhc"];
    
    
    [self setWithbool:NO Withkey:@"kj_bjpks"];
    
    
    [self setWithbool:NO Withkey:@"kj_xyft"];
    
    
    [self setWithbool:NO Withkey:@"kj_xjssc"];
    
    
    [self setWithbool:NO Withkey:@"kj_txffc"];
    
    
    [self setWithbool:NO Withkey:@"kj_pcegg"];
}

-(void)setWithbool:(BOOL )sender Withkey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setValue:@(sender) forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    [MBProgressHUD showMessage:@"测试"];
    
   NSString *isopen = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:key]];
    
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            [JPUSHService setTags:[NSSet setWithObject:key] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                
//            [MBProgressHUD showMessage:[NSString stringWithFormat:@"%ld", (long)iResCode]];
                
            } seq:1];
            
        });
    
//    if (![isopen isEqualToString:@"1"]) {
//        [self setupNoti];
//    }

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = [UIScreen mainScreen].bounds;
    
    int i = 0;
    for (UIView *view in self.scrollView.subviews) {
        view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        i++;
    }
}

//创建ScrollView
- (void)setScrollView{
    UIScrollView *scrollView=[[UIScrollView alloc]init];
    scrollView.frame=[UIScreen mainScreen].bounds;// self.view.frame;
    scrollView.delegate=self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    //往ScrollView上添加UIImageView//AppFistguideUse1_008
    
    NSArray *imageArray;

    imageArray = [NSArray arrayWithObjects:[[CPTThemeConfig shareManager] AppFistguideUse1],[[CPTThemeConfig shareManager] AppFistguideUse2],[[CPTThemeConfig shareManager] AppFistguideUse3], nil];

    
    //这里是因为这些变量只需设置一次所以放在外面
    CGFloat iconViewW=[UIScreen mainScreen].bounds.size.width;
    CGFloat iconViewH=[UIScreen mainScreen].bounds.size.height;
    CGFloat iconViewY=0;
    for (int i=0; i<ImageCounts; i++) {
        UIImageView *iconView=[[UIImageView alloc]init];
        CGFloat iconViewX=i*iconViewW;
        iconView.clipsToBounds = YES;
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        iconView.frame=CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
        NSString *name=[imageArray objectAtIndex:i];
        iconView.image=[UIImage imageNamed:name];
        [scrollView addSubview:iconView];
        //拿出最后一个ImageView
        if (i==ImageCounts-1) {
            [self setupLastImageView:iconView];
        }
//        else if (i==0){
//            [self skipfistImangeView:iconView];
//        }
    }
    //设置 scrollView滚动的最大边距
    scrollView.contentSize=CGSizeMake(iconViewW*ImageCounts, 0);
    //对scrollView进行强制分页
    scrollView.pagingEnabled=YES;
    //去除 scrollView底部的滑条
    scrollView.showsHorizontalScrollIndicator=NO;
    //取消 scrollView的弹簧效果(就是滚动到末尾或者是头部的时候不让它再滚动)
//    scrollView.bounces=NO;
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets =NO;
    }
}



//跳过页面

- (void)skipfistImangeView:(UIView *)iconView{
    //因为需要添加的是一个按钮点击进入应用的而UIImageView默认是不能和用户交互的所以需要设置一下
    iconView.userInteractionEnabled=YES;
    UIButton *conmeStart=[[UIButton alloc]init];
    CGFloat comeBntW=60;
    CGFloat comeBntH=44;
    CGFloat comeBntX=SCREEN_WIDTH-comeBntW-12.f;
    CGFloat comeBntY=20;
    conmeStart.frame=CGRectMake(comeBntX, comeBntY, comeBntW, comeBntH);
   
    [conmeStart setTitle:@"跳过 >" forState: UIControlStateNormal];
    [conmeStart setTitleColor:[UIColor colorWithHex:@"EEEEEE"] forState:UIControlStateNormal];
    conmeStart.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [iconView addSubview:conmeStart];
    // 设置button的监听事件
    [conmeStart addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    conmeStart.hidden = YES;
}

// 设置最后一个imageView的按钮进入主微博
- (void)setupLastImageView:(UIImageView *)iconView{
    //因为需要添加的是一个按钮点击进入应用的而UIImageView默认是不能和用户交互的所以需要设置一下
    iconView.userInteractionEnabled=YES;
    UIButton *conmeStart=[[UIButton alloc]init];
    CGFloat comeBntW=186;
    CGFloat comeBntH=45;
    CGFloat comeBntX=SCREEN_WIDTH/2 - 93;
    CGFloat comeBntY;
    if (SCREEN_HEIGHT > 568) {
        comeBntY =SCREEN_HEIGHT-100;
    }else{
        comeBntY =SCREEN_HEIGHT-80;
    }
     conmeStart.frame=CGRectMake(comeBntX, comeBntY, comeBntW, comeBntH);
    
     conmeStart.backgroundColor=[UIColor colorWithHex:@"e6bc86"];
     conmeStart.layer.cornerRadius=8;
     conmeStart.layer.masksToBounds=YES;
    [conmeStart setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [iconView addSubview:conmeStart];
    [conmeStart setTitle:@"开启新的旅程" forState:UIControlStateNormal];
    // 设置button的监听事件
    [conmeStart addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterEight) {
        conmeStart.hidden = NO;
    }else{
        conmeStart.hidden = YES;
    }
   
}
// button的监听事件
- (void)start{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if ([userDefault objectForKey:PERSONKEY]) {
        
        NSMutableDictionary *dic = [userDefault objectForKey:PERSONKEY];
        
        [[Person person] setupWithDic:dic];
        
        [[AppDelegate shareapp] setmainroot];
    }
    else{
        
        [[AppDelegate shareapp] setmainroot];
    }
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
}

// 设置UIPageControl
- (void)setPageControlView{
    
    UIPageControl *pageView=[[UIPageControl alloc]init];
    //设置其不能和用户进行交互
    pageView.hidden=NO;
    pageView.userInteractionEnabled=NO;
    CGFloat pageViewW=100;
    CGFloat pageViewH=30;
    CGFloat pageViewX=(self.view.frame.size.width-pageViewW)*0.5;
    CGFloat pageViewY=self.view.frame.size.height-60;
    //设置页数
    pageView.numberOfPages=ImageCounts;
    pageView.frame=CGRectMake(pageViewX, pageViewY, pageViewW, pageViewH);
    //设置当前页数的颜色
    pageView.currentPageIndicatorTintColor=[UIColor colorWithHex:@"ff552e"];
    //设置其他的颜色
    pageView.pageIndicatorTintColor=[UIColor grayColor];
    [self.view addSubview:pageView];
    //用成员变量记录住UIPageControl的属性
    self.pageView=pageView;
    self.pageView.hidden = YES;
}

//  只要UIScrollView滚动了,就会调用

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    if(offsetX>SCREEN_WIDTH*2+10){
        [self start];
        return;
    }
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    //这里因为要让其滑动到一部分之后再改当前pange
    int pageInt=(int)(pageDouble+0.5);
    //设置当前页码
    self.pageView.currentPage=pageInt;
    
}


@end
