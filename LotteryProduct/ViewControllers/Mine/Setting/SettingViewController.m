//
//  SettingViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//


#import "SettingViewController.h"
#import "AppDelegate.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISwitch *shakeswitch;

@property (weak, nonatomic) IBOutlet UISwitch *voiceswitch;

@property (weak, nonatomic) IBOutlet UILabel *versionlab;
@property (weak, nonatomic) IBOutlet UISwitch *themeSwitch;

@property (weak, nonatomic) IBOutlet UILabel *themeLab;
@property (weak, nonatomic) IBOutlet UITableViewCell *themeCell;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;
@property (weak, nonatomic) IBOutlet UIImageView *settingTopImage;
@property (weak, nonatomic) IBOutlet UIImageView *pushImagView;
@property (weak, nonatomic) IBOutlet UIImageView *shakeImgView;

@property (weak, nonatomic) IBOutlet UIImageView *voiceImageview;
@property (weak, nonatomic) IBOutlet UIImageView *switchSkinImgView;
@property (weak, nonatomic) IBOutlet UIImageView *serviceImgView;
@property (weak, nonatomic) IBOutlet UIImageView *aboutUsImgView;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;

@end

@implementation SettingViewController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    
    NSString *topimageName = [[CPTThemeConfig shareManager] IC_Me_SettingTopImageName];
    NSString *topIconName = [[CPTThemeConfig shareManager] IC_Me_SettingTopHeadIcon];
    NSString *pushImageName = [[CPTThemeConfig shareManager] SettingPushImageName];
    NSString *shakeImageName = [[CPTThemeConfig shareManager] SettingShakeImageName];
    NSString *voiceImageName = [[CPTThemeConfig shareManager] SettingVoiceImageName];
    NSString *serviceImageName = [[CPTThemeConfig shareManager] SettingServiceImageName];
    NSString *aboutUsImageName = [[CPTThemeConfig shareManager] SettingAboutUsImageName];
    NSString *switchSkinName = [[CPTThemeConfig shareManager] SettingSwitchSkinImageName];
    
    self.versionlab.textColor = [[CPTThemeConfig shareManager] CO_Me_TopLabelTitle];

    self.settingTopImage.image = IMAGE(topimageName);
    self.headIcon.image = IMAGE(topIconName);
    self.pushImagView.image = IMAGE(pushImageName);
    self.shakeImgView.image = IMAGE(shakeImageName);
    self.voiceImageview.image = IMAGE(voiceImageName);
    self.switchSkinImgView.image = IMAGE(switchSkinName);
    self.serviceImgView.image = IMAGE(serviceImageName);
    self.aboutUsImgView.image = IMAGE(aboutUsImageName);
    

    self.exitBtn.backgroundColor = [[CPTThemeConfig shareManager] confirmBtnBackgroundColor];
    [self.exitBtn setTitleColor:[[CPTThemeConfig shareManager] confirmBtnTextColor] forState:UIControlStateNormal];
    self.exitBtn.layer.masksToBounds = YES;
    self.exitBtn.layer.cornerRadius = self.exitBtn.height/2;
    
    BOOL isTheme = [[[NSUserDefaults standardUserDefaults] valueForKey:WKJTheme_ThemeType] boolValue];
    self.themeSwitch.on = isTheme;
    
    BOOL lottery_shake = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lottery_shake"]boolValue];
    self.shakeswitch.on = lottery_shake;
    BOOL lottery_voice = [[[NSUserDefaults standardUserDefaults] valueForKey:@"lottery_voice"]boolValue];
    self.voiceswitch.on = lottery_voice;
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    self.versionlab.text = [NSString stringWithFormat:@"当前版本：V%@",currentVersion];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 3 && ([AppDelegate shareapp].wkjScheme == Scheme_LotterHK || [AppDelegate shareapp].wkjScheme == Scheme_LotterEight)) {
        return 0;
    }
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (indexPath.row == 3) {
//
//        [WebTools postWithURL:@"/app/downloadUrlNews.json" params:@{@"id":@1} success:^(BaseData *data) {
//
//            NSString *url = data.data;
//
//            UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
//
//            pastboard.string = url;
//
//            [MBProgressHUD showSuccess:@"下载地址已复制到剪贴板"];
//
//        } failure:^(NSError *error) {
//
//        } showHUD:NO];
//
//
//    }
}

- (IBAction)shakeClick:(UISwitch *)sender {
    
    [[NSUserDefaults standardUserDefaults] setValue:@(sender.on) forKey:@"lottery_shake"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)voiceClick:(UISwitch *)sender {
    
    [[NSUserDefaults standardUserDefaults] setValue:@(sender.on) forKey:@"lottery_voice"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)themeClick:(UISwitch *)sender {
 
    [[NSUserDefaults standardUserDefaults] setValue:@(sender.on) forKey:WKJTheme_ThemeType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[AppDelegate shareapp] setThemeSkin];
    
    [[AppDelegate shareapp] clearRootVC];
    [[AppDelegate shareapp] setmainroot];
    
}


- (IBAction)loginoutClick:(id)sender {
    
    [[Person person]deleteCore];
    
//    [[ChatHelp shareHelper]logout];

    [[NSNotificationCenter defaultCenter]postNotificationName:@"LOGINOUT" object:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
