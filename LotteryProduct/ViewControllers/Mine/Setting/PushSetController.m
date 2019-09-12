//
//  PushSetController.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/14.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PushSetController.h"

@interface PushSetController ()

@property (weak, nonatomic) IBOutlet UISwitch *winswitch;

@property (weak, nonatomic) IBOutlet UISwitch *chongqinswitch;

@property (weak, nonatomic) IBOutlet UISwitch *liuheswitch;

@property (weak, nonatomic) IBOutlet UISwitch *beijinswitch;

@property (weak, nonatomic) IBOutlet UISwitch *feitinswitch;

@property (weak, nonatomic) IBOutlet UISwitch *xinjiangswitch;

@property (weak, nonatomic) IBOutlet UISwitch *tenxunswitch;

@property (weak, nonatomic) IBOutlet UISwitch *pcdandanswitch;


@property (strong, nonatomic) NSDictionary *windic;
@end

@implementation PushSetController

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [JPUSHService setDebugMode];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setWithbool:self.liuheswitch Withkey:@"kj_xglhc"];

    if ([Person person].Information == NO) {
     
        @weakify(self)
        [WebTools postWithURL:@"/circle/getPostSettingList" params:@{@"classify":@"push"} success:^(BaseData *data) {
            @strongify(self)
            NSArray *array = data.data;
            NSDictionary *dic = array.firstObject;
            self.windic = dic;
            _winswitch.on = [dic[@"onOff"]boolValue];
            
        } failure:^(NSError *error) {
            
        } showHUD:NO];
    }
    
    BOOL chongqin = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_cqssc"] boolValue];
    self.chongqinswitch.on = chongqin;
    
    BOOL liuhe = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_xglhc"] boolValue];
    self.liuheswitch.on = liuhe;
    
    BOOL beijin = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_bjpks"] boolValue];
    self.beijinswitch.on = beijin;
    
    BOOL feitin = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_xyft"] boolValue];
    self.feitinswitch.on = feitin;
    
    BOOL xinjiang = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_xjssc"] boolValue];
    self.xinjiangswitch.on = xinjiang;
    
    BOOL tengxun = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_txffc"] boolValue];
    self.tenxunswitch.on = tengxun;
    
    BOOL pcdandan = [[[NSUserDefaults standardUserDefaults] valueForKey:@"kj_pcegg"] boolValue];
    self.pcdandanswitch.on = pcdandan;
    
}

- (IBAction)winswitchClick:(UISwitch *)sender {
    
    NSNumber *status = sender.on == YES ? @1 : @0;
    
    [WebTools postWithURL:@"/circle/postSetting" params:@{@"settingId":self.windic? self.windic[@"settingId"]:@"0",@"onOff":status} success:^(BaseData *data) {
        
        if (sender.on) {
            
            [JPUSHService setAlias:[Person person].uid completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
            } seq:1];
        }
        else{
            [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                
                
            } seq:1];
        }
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

- (IBAction)chongqinclick:(UISwitch *)sender {
    
    [self setWithbool:sender Withkey:@"kj_cqssc"];
}

- (IBAction)liuheclick:(UISwitch *)sender {
    
    [self setWithbool:sender Withkey:@"kj_xglhc"];
}

- (IBAction)beijinpk10click:(UISwitch *)sender {
    
    [self setWithbool:sender Withkey:@"kj_bjpks"];
}

- (IBAction)xinyunfeitingclick:(UISwitch *)sender {
    
    [self setWithbool:sender Withkey:@"kj_xyft"];
}

- (IBAction)xinjiangclick:(UISwitch *)sender {
    
    [self setWithbool:sender Withkey:@"kj_xjssc"];
}

- (IBAction)tengxunclick:(UISwitch *)sender {
 
    [self setWithbool:sender Withkey:@"kj_txffc"];
}

- (IBAction)pclick:(UISwitch *)sender {
    
    [self setWithbool:sender Withkey:@"kj_pcegg"];
}

-(void)setWithbool:(UISwitch *)sender Withkey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setValue:@(sender.on) forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] valueForKey:key];
    
    if (sender.on) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            
            [JPUSHService setTags:[NSSet setWithObject:key] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                
//                [MBProgressHUD showMessage:[NSString stringWithFormat:@"%ld", (long)iResCode]];
                
            } seq:1];
        });

    }else{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          
            [JPUSHService deleteTags:[NSSet setWithObject:key] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                
//                [MBProgressHUD showMessage:[NSString stringWithFormat:@"%ld", (long)iResCode]];
                
            } seq:1];
        });
    }
//
//    [JPUSHService validTag:@"1" completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq, BOOL isBind) {
//        NSLog(@"%ld", iResCode);
//    } seq:1];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 && [Person person].Information == YES) {
        
        return 0;
    }
    
    return 50;
}

@end
