//
//  BandingPhoneCtrl.h
//  TwiKerProduct
//
//  Created by vsskyblue on 2018/4/28.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "RootCtrl.h"

@interface BandingPhoneCtrl : RootCtrl

@property (nonatomic, assign) BOOL next;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *testcore;

@property (nonatomic, copy) void (^loginBlock)(BOOL result,BaseData *banddata);

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) UMSocialUserInfoResponse *resp;
@property (nonatomic, assign) BOOL isfromThird;

@end
