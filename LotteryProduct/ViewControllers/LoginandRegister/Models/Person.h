//
//  Person.h
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/16.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseData.h"


typedef void (^TakePhotoCompleteBlock) (UIImage *image);
typedef void (^CheckMoneyBlock) (double money);

@interface Person : NSObject< UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * heads;
@property (nonatomic , copy) NSString              * token;
/**
 账号
 */
@property (nonatomic , copy) NSString              * account;
/**
 上次登录地区
 */
@property (nonatomic , copy) NSString              * region;
/**
 真实姓名
 */
@property (nonatomic , copy) NSString              * realName;
/**
 昵称
 */
@property (nonatomic , copy) NSString              * nickname;
/**
 生日
 */
@property (nonatomic , copy) NSString              * birthday;
/**
 VIP等级
 */
@property (nonatomic , copy) NSString              * vip;
/**
 上次登录时间
 */
@property (nonatomic , copy) NSString              * loginTime;
/**
 性别(0:女, 1:男)
 */
@property (nonatomic , copy) NSString              * sex;
/**
 上次登录ip
 */
@property (nonatomic , copy) NSString              * ip;
/**
 余额(单位:分)
 */
@property (nonatomic , assign) CGFloat              balance;

/**
 支付密码
 */
@property (nonatomic , copy) NSString               *payPassword;
/**
 邀请码
 */
@property (nonatomic , copy) NSString               *promotionCode;
/**
 可提现金额
 */
@property (nonatomic , assign) CGFloat                  withdrawalAmount;

/**
 *是否需要修改昵称
 */
@property (nonatomic , assign) BOOL                  checkRename;

@property (nonatomic , assign) BOOL                  showlogin;
/**
 YES:仅wifi才加载圈子图片
 */
@property (nonatomic , assign) BOOL                  onlywifi;
/// 用户充值层级
@property (nonatomic , copy) NSString               *payLevelId;


@property (nonatomic, copy) TakePhotoCompleteBlock takePhotoCompleteBlock;

@property (nonatomic, copy) NSString *neturl;

@property (nonatomic, strong) NSDictionary *netparmas;

@property (nonatomic, copy) void (^successBlock) (BaseData *data);

@property (nonatomic, copy) void (^failureBlock) (NSError *error);

@property (nonatomic, assign) BOOL show;

@property (nonatomic, strong) NSUserDefaults *userDefault;
+(instancetype)person;

-(void)setupWithDic:(NSDictionary*)dic;

-(void)save;

-(void)deleteCore;

-(void)myAccount;

-(void)upimageWithcount:(NSInteger)count WithController:(UIViewController *)vc success:(void (^)(NSArray<UIImage *> *photos))success;

-(void)takePictureWithController:(UIViewController *)vc WithBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock;

-(void)takePhotoWithController:(UIViewController *)vc WithBlock:(TakePhotoCompleteBlock)takePhotoCompleteBlock;


-(BOOL)Information;
- (void)checkIsNeedRMoney:(CheckMoneyBlock)block isNeedHUD:(BOOL)isNeedHUD;

@end
