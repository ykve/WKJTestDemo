//
//  ListNoticeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ChatHongbaoTopView.h"

@interface ChatHongbaoTopView()

@property (strong, nonatomic) UIControl *overlayView;
@end

@implementation ChatHongbaoTopView

- (void)dealloc{
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = CLEAR;
 
}

-(void)showInView:(UIView *)view{
    [view addSubview:self];
    [UIView animateWithDuration:0.35 animations:^{
        self.center = CGPointMake(SCREEN_WIDTH/2, self.center.y);
    } completion:^(BOOL finished) {

    }];
}

-(void)dismiss{

    [UIView animateWithDuration:0.35 animations:^{
        self.center = CGPointMake(-SCREEN_WIDTH/2, self.center.y);
    } completion:^(BOOL finished) {

        [self removeFromSuperview];

    }];
}



- (IBAction)clickOkBtn:(UIButton *)sender {
    @weakify(self)
    [WebTools postWithURL:@"/chatPack/redPackDraw.json" params:@{@"redPackId":@(self.hbID)} success:^(BaseData *data) {
        @strongify(self)
        if(data.status.integerValue == 1){
            MBLog(@"%@",data.data);
            id some = data.data;
            if([some isKindOfClass:[NSString class]]){
                [MBProgressHUD showError:some?some:@"领取失败"];
//                [self dismiss];

            }else{
                NSDictionary *dic = (NSDictionary *)some;

                NSInteger status = [dic[@"type"] integerValue];
                if(status == 0){
                    if(self.clickOKBtn){
                        CGFloat mon = [dic[@"money"] floatValue];
                        self.clickOKBtn(mon);
                    }
                    [self dismiss];
                }else{
                    [MBProgressHUD showError:@"该红包已结束"];
                    [self dismiss];
                }
  
            }

        }
    } failure:^(NSError *error) {
        @strongify(self)
        [self dismiss];
    }];
}





@end
