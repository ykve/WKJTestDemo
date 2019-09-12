


//
//  CPTInfoManager.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/7/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTInfoManager.h"
#import "CPTInfoModel.h"

@implementation CPTInfoManager
static CPTInfoManager *manager;
+ (id)shareManager
{
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            manager = [[self alloc] init];
        });
    }
    return manager;
}

- (instancetype)init{
    self = [super init];
    if(self){
        
        
    }
    return self;
}

-(void)checkModelCallBack:(void (^)(CPTInfoModel *model,BOOL isSuccess))success {
    if(self.model){
        success(self->_model,YES);
        return;
    }
    @weakify(self)
    [WebTools postWithURL:@"/app/downloadUrlNews.json" params:@{@"id":@(1)} success:^(BaseData *data) {
        @strongify(self)
        CPTInfoModel * tmpModel = [CPTInfoModel mj_objectWithKeyValues:data.data];
        if(tmpModel.aboutUs){
            self.model = tmpModel;
            if(success){
                success(self.model,YES);
            }
        }
    } failure:^(NSError *error) {
        if(success){
            @strongify(self)
            success(self.model,NO);
        }
    }showHUD:NO];
}

@end
