//
//  UserInfoViewController.m
//  LotteryProduct
//
//  Created by Jiang on 2018/6/15.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserEditNicknameViewController.h"
#import "UserEditSexViewController.h"
#import "NSDate+Category.h"

@interface UserInfoViewController ()
/// 头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
/// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nickname;
/// vip图标
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
/// 金额
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
/// 等级
@property (weak, nonatomic) IBOutlet UILabel *lvLabel;
/// 用户返点
@property (weak, nonatomic) IBOutlet UILabel *backpointLabel;
/// 真实姓名
@property (weak, nonatomic) IBOutlet UILabel *realnameLabel;
/// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nicknamelab;
/// 性别
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
/// 生日
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
/// 上次登录
@property (weak, nonatomic) IBOutlet UILabel *lasttimeLabel;
/// 上次登录地区
@property (weak, nonatomic) IBOutlet UILabel *lastareaLabel;
/// 上次访问IP
@property (weak, nonatomic) IBOutlet UILabel *lastIPLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) IBOutlet UIView *dataPickSupView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dataPickBottom;

@property (weak, nonatomic) IBOutlet UILabel *unitlab;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation UserInfoViewController

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户信息";
    
    self.nickname.textColor = [[CPTThemeConfig shareManager] accountInfoNicknameTextColor];
    self.unitlab.textColor = [[CPTThemeConfig shareManager] CO_MoneyTextColor];
    self.priceLabel.textColor = [[CPTThemeConfig shareManager] CO_MoneyTextColor];
    self.topView.backgroundColor = [[CPTThemeConfig shareManager] accountInfoTopViewBackgroundColor];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    self.priceLabel.hidden = [Person person].Information;
    self.unitlab.hidden = [Person person].Information;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self updateInfo];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 0;
    }
    if ([Person person].Information && indexPath.section == 1 && indexPath.row == 0) {
        
        return 0;
    }
    
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:// 0 等级 1 用户返点
        {
            
        }
            break;
        case 1:// 0 真实姓名 1 昵称 2.性别 3 生日
        {
            if (indexPath.row == 0) { // 真实姓名
                if ([Person person].realName.length) {
                    [MBProgressHUD showError:@"姓名只能设置一次哦"];
                    return;
                }
                
                UserEditNicknameViewController *editNicknameVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserEditNicknameViewController"];
                editNicknameVC.title = @"真实姓名";
                [self.navigationController pushViewController:editNicknameVC animated:YES];
                
            } else if (indexPath.row == 1) { // 昵称
                
                if ([Person person].nickname.length) {
                    
                    [MBProgressHUD showError:@"昵称只能修改一次哦"];
                    
                    return;
                }
                
                UserEditNicknameViewController *editNicknameVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserEditNicknameViewController"];
                [self.navigationController pushViewController:editNicknameVC animated:YES];
            } else if (indexPath.row == 2) { // 性别
                UserEditSexViewController *editSexVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserEditSexViewController"];
                
                [self.navigationController pushViewController:editSexVC animated:YES];
            } else if (indexPath.row == 3) { // 生日
                [self showDataPickView];
            }
            
        }
            break;
        case 2:// 0 上次登录 1 上次登录地区 2 上次访问IP
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)headTapAction:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    @weakify(self)
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[Person person] takePictureWithController:self WithBlock:^(UIImage *image) {
            @strongify(self)

            [self updataimage:image];
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[Person person] takePhotoWithController:self WithBlock:^(UIImage *image) {
            @strongify(self)

            [self updataimage:image];
        }];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showDataPickView {
    
    self.dataPickSupView.backgroundColor = [UIColor clearColor];
    
    self.dataPickSupView.frame = [UIScreen mainScreen].bounds;
    [self.navigationController.view addSubview:self.dataPickSupView];
    
    self.dataPickBottom.constant = -(200 + 44);
    [self.dataPickSupView layoutIfNeeded];
    
    self.dataPickBottom.constant = 0;
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)

        [self.dataPickSupView layoutIfNeeded];
        
        self.dataPickSupView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
}

- (void)hidenDataPickView {
    
    self.dataPickBottom.constant = -(200 + 44);
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)

        [self.dataPickSupView layoutIfNeeded];
        
        self.dataPickSupView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        @strongify(self)

        [self.dataPickSupView removeFromSuperview];
    }];
}

- (IBAction)hidenDataPickView:(id)sender {
    [self hidenDataPickView];
}

- (IBAction)finishAction:(id)sender {
    
    [self hidenDataPickView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    if ([[NSDate date] isEarlierThanDate:self.datePicker.date]) {
        
        [MBProgressHUD showError:@"选择日期不能大于当前日期"];
        
        return;
    }
    
    NSString *timestring = [dateFormatter stringFromDate: self.datePicker.date];
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/updateAccountInfo.json" params:@{@"birthday":timestring} success:^(BaseData *data) {
        @strongify(self)
        [MBProgressHUD showSuccess:data.info];
        
        [Person person].birthday = timestring;
        
        [self updateInfo];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)dateChange:(UIDatePicker *)date {
    
    NSLog(@"%@", date.date);
    
}

-(void)updateInfo {
    
    self.nickname.text = [NSString stringWithFormat:@"账号：%@",[Person person].account];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",[Person person].balance];
    [self.headImageView sd_setImageWithURL:IMAGEPATH([Person person].heads) placeholderImage:DEFAULTHEAD options:SDWebImageRefreshCached];
    self.nicknamelab.text = [Person person].nickname.length ? [Person person].nickname : @"未设置";
    self.realnameLabel.text = [Person person].realName.length ? [Person person].realName : @"未设置";
    self.lvLabel.text = [Person person].vip.length ? [Person person].vip : @"无";
    self.sexLabel.text = [Person person].sex.integerValue == 1 ? @"男" : @"女";
    self.birthdayLabel.text = [Person person].birthday.length ? [Person person].birthday : @"1970-01-01";
    self.lastIPLabel.text = [Person person].ip;
    self.lastareaLabel.text = [Person person].region;
    self.lasttimeLabel.text = [Person person].loginTime;
    self.vipImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"me_%@", [Person person].vip]];
}




-(void)updataimage:(UIImage *)image {
    
    @weakify(self)
    [WebTools rj_upImage:@[image] code:@"head" progress:^(NSProgress *progress) {
        
    } success:^(BaseData *data) {
        @strongify(self)

        [self updatahead:[data.data firstObject] Withhead:image];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)updatahead:(NSString *)headurl Withhead:(UIImage *)head {
    
    @weakify(self)
    [WebTools postWithURL:@"/memberInfo/updateAccountInfo.json" params:@{@"heads":headurl} success:^(BaseData *data) {
        @strongify(self)
        [Person person].heads = headurl;
        
        self.headImageView.image = head;
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

@end
