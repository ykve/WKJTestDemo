//
//  Person.m
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/16.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import "Person.h"
#import "AppDelegate.h"
@implementation Person

static Person *person=nil;
+(instancetype)person{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person=[[Person alloc]init];
        
    });
    return person;
}

-(void)setupWithDic:(NSDictionary *)dic {
    if(!dic){
        return;
    }
    if ([dic valueForKey:@"uid"]) {
        
        person.uid = [[dic valueForKey:@"uid"]stringValue];
    }
    if ([dic valueForKey:@"checkRename"]) {
        person.checkRename = [[dic valueForKey:@"checkRename"]boolValue];
    }
    if ([dic valueForKey:@"token"]) {
        
        person.token = [dic valueForKey:@"token"];
    }
    if ([dic valueForKey:@"heads"]) {
        
        person.heads = [dic valueForKey:@"heads"];
    }
    if ([dic valueForKey:@"name"]) {
        
        person.name = [dic valueForKey:@"name"];
    }
    if ([dic valueForKey:@"account"]) {
        
        person.account = [dic valueForKey:@"account"];
    }
    if ([dic valueForKey:@"region"]) {
        
        person.region = [dic valueForKey:@"region"];
    }
    if ([dic valueForKey:@"realName"]) {
        
        person.realName = [dic valueForKey:@"realName"];
    }
    if ([dic valueForKey:@"nickname"]) {
        
        person.nickname = [dic valueForKey:@"nickname"];
    }
    if ([dic valueForKey:@"birthday"]) {
        
        person.birthday = [dic valueForKey:@"birthday"];
    }
    if ([dic valueForKey:@"vip"]) {
        
        person.vip = [dic valueForKey:@"vip"];
    }
    if ([dic valueForKey:@"loginTime"]) {
        
        person.loginTime = [dic valueForKey:@"loginTime"];
    }
    if ([dic valueForKey:@"sex"]) {
        
        person.sex = [dic valueForKey:@"sex"];
    }
    if ([dic valueForKey:@"ip"]) {
        
        person.ip = [dic valueForKey:@"ip"];
    }
    if ([dic valueForKey:@"balance"]) {
        
        person.balance = [[dic valueForKey:@"balance"] doubleValue];
    }
    if ([dic valueForKey:@"payPassword"]) {
        
        person.payPassword = [dic valueForKey:@"payPassword"];
    }
    if ([dic valueForKey:@"withdrawalAmount"]) {
        
        person.withdrawalAmount = [[dic valueForKey:@"withdrawalAmount"]floatValue];
    }
    if ([dic valueForKey:@"promotionCode"]) {
        
        person.promotionCode = [dic valueForKey:@"promotionCode"];
    }
    if ([dic valueForKey:@"payLevelId"]) {
        id levelid = [dic valueForKey:@"payLevelId"] ;
        if([levelid isKindOfClass:[NSString class]]){
            person.payLevelId = levelid;
        }else{
            person.payLevelId = [levelid stringValue];
        }
    }
}


-(void)save {
    
    NSMutableDictionary *dic = [person mj_keyValues];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:dic forKey:PERSONKEY];
    
    [userDefault synchronize];
}

-(void)deleteCore {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if ([userDefault valueForKey:PERSONKEY]) {
        
        [userDefault removeObjectForKey:PERSONKEY];
        
        [userDefault synchronize];
        
        person.uid = nil;
        person.token = nil;
        person.name = nil;
        person.heads = nil;
        
//        [[ChatHelp shareHelper]logout];
        
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
            
        } seq:1];
      
    }
}

-(void)myAccount {
    
    [WebTools postWithURL:@"/memberInfo/myAccount.json" params:nil success:^(BaseData *data) {
        
        [[Person person] setupWithDic:data.data];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBalance" object:nil];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}


- (void)checkIsNeedRMoney:(CheckMoneyBlock)block isNeedHUD:(BOOL)isNeedHUD{
    if([[AppDelegate shareapp] wkjScheme] == Scheme_LitterFish){
        if(block){
            block(0.0);
        }
        return;
    }
    NSDictionary *dic = @{@"userId":[Person person].uid?[Person person].uid:@"",@"account":[Person person].account?[Person person].account:@""};
    
    [WebTools postWithURL:@"/external/exit.json" params:dic success:^(BaseData *data) {
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        NSNumber * state = data.data;//说明：0或1  0代表此用户第三方账号无金币转出。1代表从第三方平台转出成功，CPT账号有余额变动（调用下方获取用户余额接口）
        person.balance = [state doubleValue];
        if(block){
            block(person.balance);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBalance" object:nil];

    } failure:^(NSError *error) {
        
    } showHUD:isNeedHUD];
}

-(void)upimageWithcount:(NSInteger)count WithController:(UIViewController *)vc success:(void (^)(NSArray<UIImage *> *))success {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.cropRect = CGRectMake(0, (SCREEN_HEIGHT-NAV_HEIGHT)/2-SCREEN_WIDTH/2, SCREEN_WIDTH, SCREEN_WIDTH);
    imagePickerVc.maxImagesCount = count;
    [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
        
        [vc setNeedsStatusBarAppearanceUpdate];
        
        success(photos);
    }];
    
    [imagePickerVc setImagePickerControllerDidCancelHandle:^(){
        [vc setNeedsStatusBarAppearanceUpdate];
    }];
    
    [vc presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)takePhotoWithController:(UIViewController *)vc WithBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock {
    
    self.takePhotoCompleteBlock = takePhotoCompleteBlock;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        if (SYS_IOS_VEERSION >= 8) {
            vc.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        [vc presentViewController:picker animated:YES completion:NULL];
    }
}

-(void)takePictureWithController:(UIViewController *)vc WithBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock {
    
    self.takePhotoCompleteBlock = takePhotoCompleteBlock;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (SYS_IOS_VEERSION >= 8) {
            vc.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        [vc presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark - imagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        if (self.takePhotoCompleteBlock) {
            self.takePhotoCompleteBlock(image);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Runtime
- (TakePhotoCompleteBlock)takePhotoCompleteBlock
{
    return objc_getAssociatedObject(self, @selector(takePhotoCompleteBlock));
}

-(void)setTakePhotoCompleteBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock
{
    objc_setAssociatedObject(self, @selector(takePhotoCompleteBlock), takePhotoCompleteBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(BOOL)Information {
    return NO;

    if ([[Tools getBundleID] isEqualToString:@"com.softgarden.lotterybuy"]){
        return NO;
    }
    else if([[Tools getBundleID] isEqualToString:@"com.softgarden.lotteryInfoEight"]){
        return NO;
    }else if ([AppDelegate shareapp].wkjScheme == Scheme_LotterHK){
        return NO;
    }
    else{
        return NO;
    }
}


@end

