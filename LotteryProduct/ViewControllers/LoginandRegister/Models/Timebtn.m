//
//  Timebtn.m
//  BuLeiErLi
//
//  Created by 软碟技术 on 15/7/20.
//  Copyright (c) 2015年 软碟技术. All rights reserved.
//

#import "Timebtn.h"

@implementation Timebtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.enabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
               
                [self setTitle:[NSString stringWithFormat:@"%@ s",strTime] forState:UIControlStateNormal];
                self.titleLabel.adjustsFontSizeToFitWidth = YES;
                self.enabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

@end
