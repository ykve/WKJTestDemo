//
//  ShowAlertView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/1.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ShowAlertView.h"
#import "TodaySetView.h"




@implementation ShowAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = WHITE;
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = 0.3;
    }
    
    return self;
}

-(void)buildsetView:(NSInteger)index Withsort:(NSInteger)sort With:(void (^)(NSInteger, NSInteger))setBlock {
    
    self.dismissBlock = setBlock;
    
    self.index = index;
    
    self.sort = sort;
    
    self.frame = CGRectMake(SCREEN_WIDTH/2-140, -210, 280, 210);
    
    UIView *head = [self setheadView:@"走势图设置" Withimage:@"弹窗设置"];
    [self addSubview:head];
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:@"期数：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(12);
        make.top.equalTo(head.mas_bottom).offset(25);
    }];
    
    NSArray *title = @[@"近30期",@"近50期",@"近100期",@"近120期"];
    UIButton *firstBtn = nil;
    for(int i = 0; i< title.count; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:title[i] andTitleColor:YAHEI andBackgroundImage:nil andImage:IMAGE(@"期数未选") andTarget:self andAction:@selector(selectversionsClick:) andType:UIButtonTypeCustom];
        [btn setImage:IMAGE(@"期数已选") forState:UIControlStateSelected];
        btn.tag = 100 + i;
        if (index == i) {
            
            btn.selected = YES;
        }
        if (i == 0) {
            
            firstBtn = btn;
        }
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (i == 0) {
                
                make.left.equalTo(lab.mas_right).offset(10);
                make.centerY.equalTo(lab);
                make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
            }
            else if (i == 1) {
                make.left.equalTo(firstBtn.mas_right).offset(8);
                make.centerY.equalTo(lab);
                make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
            }
            else if (i == 2) {
                
                make.left.equalTo(firstBtn);
                make.top.equalTo(firstBtn.mas_bottom).offset(8);
                make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
            }else {
                make.left.equalTo(firstBtn.mas_right).offset(8);
                make.top.equalTo(firstBtn.mas_bottom).offset(8);
                make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
            }
        }];
    }
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:@"排序：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab);
        make.top.equalTo(lab.mas_bottom).offset(80);
    }];
    
    NSArray *title2 = @[@"顶部最新",@"底部最新"];
    
    UIButton *lastbtn = nil;
    
    for(int i = 0; i<title2.count; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:title2[i] andTitleColor:YAHEI andBackgroundImage:nil andImage:IMAGE(@"期数未选") andTarget:self andAction:@selector(selectsortClick:) andType:UIButtonTypeCustom];
        [btn setImage:IMAGE(@"期数已选") forState:UIControlStateSelected];
        btn.tag = 200 + i;
        if (sort == i) {
            
            btn.selected = YES;
        }
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (lastbtn) {
                make.left.equalTo(lastbtn.mas_right).offset(8);
            }
            else {
                make.left.equalTo(lab2.mas_right).offset(10);
            }
            make.centerY.equalTo(lab2);
            
            make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
        }];
        
        lastbtn = btn;
    }
    
}

-(void)buildsetlineView {
    
    self.frame = CGRectMake(SCREEN_WIDTH/2-140, -210, 280, 270);
    
    UIView *head = [self setheadView:@"走势图设置" Withimage:@"弹窗设置"];
    [self addSubview:head];
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:@"期数：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(12);
        make.top.equalTo(head.mas_bottom).offset(25);
    }];
    
    NSArray *title = @[@"近30期",@"近50期",@"近100期",@"近200期"];
    UIButton *firstBtn = nil;
    for(int i = 0; i< title.count; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:title[i] andTitleColor:YAHEI andBackgroundImage:nil andImage:IMAGE(@"期数未选") andTarget:self andAction:@selector(selectversionsClick:) andType:UIButtonTypeCustom];
        [btn setImage:IMAGE(@"期数已选") forState:UIControlStateSelected];
        btn.tag = 100 + i;
        if (i == 0) {
            
            firstBtn = btn;
        }
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (i == 0) {
                
                make.left.equalTo(lab.mas_right).offset(10);
                make.centerY.equalTo(lab);
                make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
            }
            else if (i == 1) {
                make.left.equalTo(firstBtn.mas_right).offset(8);
                make.centerY.equalTo(lab);
                make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
            }
            else if (i == 2) {
                
                make.left.equalTo(firstBtn);
                make.top.equalTo(firstBtn.mas_bottom).offset(8);
                make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
            }else {
                make.left.equalTo(firstBtn.mas_right).offset(8);
                make.top.equalTo(firstBtn.mas_bottom).offset(8);
                make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
            }
        }];
    }
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:@"折线：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab);
        make.top.equalTo(lab.mas_bottom).offset(80);
    }];
    
    NSArray *title2 = @[@"显示折线",@"隐藏折线"];
    
    UIButton *lastbtn = nil;
    
    for(int i = 0; i<title2.count; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:title2[i] andTitleColor:YAHEI andBackgroundImage:nil andImage:IMAGE(@"期数未选") andTarget:self andAction:@selector(selecthiddenClick:) andType:UIButtonTypeCustom];
        [btn setImage:IMAGE(@"期数已选") forState:UIControlStateSelected];
        btn.tag = 200 + i;
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (lastbtn) {
                make.left.equalTo(lastbtn.mas_right).offset(8);
            }
            else {
                make.left.equalTo(lab2.mas_right).offset(10);
            }
            make.centerY.equalTo(lab2);
            
            make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
        }];
        
        lastbtn = btn;
    }
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"遗漏：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab);
        make.top.equalTo(lab2.mas_bottom).offset(40);
    }];
    
    NSArray *title3 = @[@"显示遗漏",@"隐藏遗漏"];
    
    UIButton *lastbtn3 = nil;
    
    for(int i = 0; i<title3.count; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:title3[i] andTitleColor:YAHEI andBackgroundImage:nil andImage:IMAGE(@"期数未选") andTarget:self andAction:@selector(selectmissClick:) andType:UIButtonTypeCustom];
        [btn setImage:IMAGE(@"期数已选") forState:UIControlStateSelected];
        btn.tag = 300 + i;
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (lastbtn3) {
                make.left.equalTo(lastbtn3.mas_right).offset(8);
            }
            else {
                make.left.equalTo(lab3.mas_right).offset(10);
            }
            make.centerY.equalTo(lab3);
            
            make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/3, 26));
        }];
        
        lastbtn3 = btn;
    }
}

-(void)builddateView:(void (^)(NSString *date))success {
    
    self.frame = CGRectMake(SCREEN_WIDTH/2-140, -210, 280, 210);
    UIView *head = [self setheadView:@"选择日期" Withimage:nil];
    [self addSubview:head];
    
    TimePickerView *picker = [TimePickerView share];
    picker.frame = CGRectMake(0, 35, self.frame.size.width, self.frame.size.height-35);
//    picker.showhourandmin = NO;
    if(!self.lastDate){
        self.lastDate = [Tools getlocaletime];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:self.lastDate];
    
    [picker showhourandmin:NO lastDate:date];
    [self addSubview:picker];
    
    picker.TimeBlock = ^(NSString *time) {
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //创建了日期对象
        NSDate *date1=[dateFormatter dateFromString:time];
        
        NSTimeInterval newtime=[date1 timeIntervalSince1970];
        
        NSInteger nowchuo  = [[Tools getlocaleChuo]integerValue];
        
        if (newtime > nowchuo) {
            
            [MBProgressHUD showError:@"选择时间不得大于当前时间"];
        }
        else{
            if (time == nil) {
                
                [self dismiss];
            }else {
                
                success(time);
                [self dismiss];
            }
        }

    };
    
}

-(void)buildexplainView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.3*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.3*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:@"设置：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:@"右侧的设置按钮点击可设置走势图的显示，有期数选择和排序选择。" andfont:FONT(14) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 2;
    [self addSubview:lab2];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(12);
        
        make.top.equalTo(head.mas_bottom).offset(20);
    }];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lab.mas_top);
        make.left.equalTo(lab.mas_right);
        make.right.equalTo(self).offset(-12);
        make.width.with.priorityLow();
    }];
    
    /*
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.75*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.75*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSArray *title = @[@"玩法：",@"设置：",@"选号记录：",@"选择日期："];
    NSArray *contnet = @[@"最左侧的玩法按钮点击可选择查看不同玩法的历史开奖信息。",@"最右侧的设置按钮点击可设置走势图的显示，有期数选择和排序选择。",@"点击该按钮可在走势图中显示历史期数中显示你购买过的号码。",@"点击该按钮选择查看某一日的历史开奖信息。"];
    
    UILabel *lastlab = nil;
    for (int i = 0; i< title.count; i++) {
        
        UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:title[i] andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
        [self addSubview:lab];
        
        UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:contnet[i] andfont:FONT(14) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
        lab2.numberOfLines = 2;
        [self addSubview:lab2];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(12);
            
            if (lastlab == nil) {
                
                make.top.equalTo(head.mas_bottom).offset(20);
            }
            else {
                make.top.equalTo(lastlab.mas_bottom).offset(35);
            }
        }];
        
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(lab.mas_top);
            make.left.equalTo(lab.mas_right);
            make.right.equalTo(self).offset(-12);
            make.width.with.priorityLow();
        }];
        
        lastlab = lab;
    }
    */
}

-(void)buildmissstatistcsView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*1.3*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*1.3*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"遗漏统计：统计当前日期整天对应号码的出现次数及遗漏（当前没开）次数。"];
    //设置文字颜色
    [str1 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 5)];
    [str1 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 5)];
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    lab1.attributedText = str1;
    lab1.numberOfLines = 0;
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(head.mas_bottom).offset(20);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
    }];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:@"大小遗漏：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab1.mas_bottom).offset(15);
    }];
    
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:@"1.连续遗漏：号码两面连续未出现的次数。如近20期第一球【大】连续5期未开出，则【大】的“连续遗漏”为5；"];
    //设置文字颜色
    [str3 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 7)];
    [str3 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 7)];
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    lab3.numberOfLines = 0;
    lab3.attributedText = str3;
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab2.mas_bottom).offset(20);
    }];
    
    NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc] initWithString:@"2.出现次数：指对应“连续遗漏”的出现次数。如近20期内第1-5、8-12期末开出【大】，则“连续遗漏5”的出现次数为2。"];
    //设置文字颜色
    [str4 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 7)];
    [str4 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 7)];
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab4];
    lab4.numberOfLines = 0;
    lab4.attributedText = str4;
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab3.mas_bottom).offset(10);
    }];
    
    UILabel *lab5 = [Tools createLableWithFrame:CGRectZero andTitle:@"单双遗漏：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab5];
    [lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab4.mas_bottom).offset(15);
    }];
    
    NSMutableAttributedString *str6 = [[NSMutableAttributedString alloc] initWithString:@"1.连续遗漏：号码两面连续未出现的次数。如近20期第一球【单】连续5期未开出，则【单】的“连续遗漏”为5；"];
    //设置文字颜色
    [str6 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 7)];
    [str6 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 7)];
    UILabel *lab6 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab6];
    lab6.numberOfLines = 0;
    lab6.attributedText = str6;
    [lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab5.mas_bottom).offset(15);
    }];
    
    NSMutableAttributedString *str7 = [[NSMutableAttributedString alloc] initWithString:@"2.出现次数：指对应“连续遗漏”的出现次数。如近20期内第1-5、8-12期末开出【单】，则“连续遗漏5”的出现次数为2。"];
    //设置文字颜色
    [str7 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 7)];
    [str7 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 7)];
    UILabel *lab7 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab7];
    lab7.numberOfLines = 0;
    lab7.attributedText = str7;
    [lab7 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab6.mas_bottom).offset(10);
    }];
}

-(void)buildmissbigorsmallView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.5*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.5*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSMutableAttributedString *str6 = [[NSMutableAttributedString alloc] initWithString:@"1.连续遗漏：号码两面连续未出现的次数。如近20期第一球【大】连续5期未开出，则【大】的“连续遗漏”为5；"];
    //设置文字颜色
    [str6 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 7)];
    [str6 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 7)];
    UILabel *lab6 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab6];
    lab6.numberOfLines = 0;
    lab6.attributedText = str6;
    [lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    NSMutableAttributedString *str7 = [[NSMutableAttributedString alloc] initWithString:@"2.出现次数：指对应“连续遗漏”的出现次数。如近20期内第1-5、8-12期末开出【大】，则“连续遗漏5”的出现次数为2。"];
    //设置文字颜色
    [str7 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 7)];
    [str7 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 7)];
    UILabel *lab7 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab7];
    lab7.numberOfLines = 0;
    lab7.attributedText = str7;
    [lab7 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab6.mas_bottom).offset(10);
    }];
}

-(void)buildmisssingleanddoubleView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.5*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.5*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSMutableAttributedString *str6 = [[NSMutableAttributedString alloc] initWithString:@"1.连续遗漏：号码两面连续未出现的次数。如近20期第一球【单】连续5期未开出，则【单】的“连续遗漏”为5；"];
    //设置文字颜色
    [str6 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 7)];
    [str6 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 7)];
    UILabel *lab6 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab6];
    lab6.numberOfLines = 0;
    lab6.attributedText = str6;
    [lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    NSMutableAttributedString *str7 = [[NSMutableAttributedString alloc] initWithString:@"2.出现次数：指对应“连续遗漏”的出现次数。如近20期内第1-5、8-12期末开出【单】，则“连续遗漏5”的出现次数为2。"];
    //设置文字颜色
    [str7 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 7)];
    [str7 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 7)];
    UILabel *lab7 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab7];
    lab7.numberOfLines = 0;
    lab7.attributedText = str7;
    [lab7 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab6.mas_bottom).offset(10);
    }];
}

-(void)buildmissdateView:(void (^)(UIButton *button))success {
    
    self.selectbuttonBlock = success;
    
    self.frame = CGRectMake(SCREEN_WIDTH/2-140, -210, 280, 125);
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView *head = [self setheadView:@"选择日期" Withimage:nil];
    [self addSubview:head];
    
    NSArray *array = @[@"最近一个月",@"最近三个月"];
    for(int i = 0; i< array.count; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectMake(0, 35+45*i, self.bounds.size.width, 44) andTitle:array[i] andTitleColor:YAHEI andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(selectmisstime:) andType:UIButtonTypeCustom];
        btn.tag = 101+i;
        btn.backgroundColor = WHITE;
        [self addSubview:btn];
    }
}

-(void)buildtodaysetWithtype:(NSInteger)type WithView:(void (^)(NSDictionary *))success {
    
    self.frame = CGRectMake(SCREEN_WIDTH/2-140, -210, 280, 271);
    
    UIView *head = [self setheadView:@"参数设置" Withimage:@"弹窗设置"];
    [self addSubview:head];
    
    TodaySetView *set = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([TodaySetView class]) owner:self options:nil]firstObject];
    set.type = type;
    set.frame = CGRectMake(0, 35, self.frame.size.width, 236);
    [self addSubview:set];
    set.todaysetBlock = ^(NSDictionary *dic) {
        
        success(dic);
        
        [self dismiss];
    };
}

-(void)buildtodayInfoView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.85*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.85*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"1.今日开奖统计：统计对应球号位置上出现的所有号码的次数，使用参数设置可自定义关注遗漏范围，请根据个人需要手动设置，各参数的数值范围：2-500。"];
    //设置文字颜色
    [str1 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 9)];
    [str1 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 9)];
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    lab1.numberOfLines = 0;
    lab1.attributedText = str1;
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"2.开奖号码次数统计：统计选择的日期内开出结果中的所有号码出现的次数。"];
    //设置文字颜色
    [str2 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 11)];
    [str2 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 11)];
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab2];
    lab2.numberOfLines = 0;
    lab2.attributedText = str2;
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(10);
    }];
    
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:@"3.三星玩法形态统计：统计选择的日期内开出结果中的出现组六形态、豹子形态、组三形态的各自次数。"];
    //设置文字颜色
    [str3 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 11)];
    [str3 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 11)];
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    lab3.numberOfLines = 0;
    lab3.attributedText = str3;
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab2.mas_bottom).offset(10);
    }];
    
    NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc] initWithString:@"4.二星玩法形态统计：统计选择的日期内开出结果中的出现对子形态、连号形态的各自次数。"];
    //设置文字颜色
    [str4 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 11)];
    [str4 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 11)];
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab4];
    lab4.numberOfLines = 0;
    lab4.attributedText = str4;
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab3.mas_bottom).offset(10);
    }];
}

-(void)buildPCtodayInfoView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.85*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.5*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"1.今日开奖统计：统计对应球号位置上出现的所有号码的次数，使用参数设置可自定义关注遗漏范围，请根据个人需要手动设置，各参数的数值范围：2-500。"];
    //设置文字颜色
    [str1 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 9)];
    [str1 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 9)];
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    lab1.numberOfLines = 0;
    lab1.attributedText = str1;
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:@"2.开奖号码次数统计：统计选择的日期内开出结果中的所有号码出现的次数。"];
    //设置文字颜色
    [str2 addAttribute:NSForegroundColorAttributeName value:BLACK range:NSMakeRange(0, 11)];
    [str2 addAttribute:NSFontAttributeName value:FONT(15) range:NSMakeRange(0, 11)];
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab2];
    lab2.numberOfLines = 0;
    lab2.attributedText = str2;
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(10);
    }];
}

-(void)buildformulaInfoView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.75*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.75*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"什么是杀号？" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:@"杀号意为该号码不推荐参考，建议剔除杀掉\n当开出结果与该杀号号码一致时，代表杀错，该期计划失败\n当开出结果与该杀号号码不一致时，代表杀对，该期计划成功" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 0;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(8);
    }];
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"公式：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab2.mas_bottom).offset(15);
    }];
    
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:@"代表此类杀号计划由算法师结合各类数学公式演算而成" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab4.numberOfLines = 0;
    [self addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab3.mas_right).offset(0);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab2.mas_bottom).offset(15);
        make.width.with.priorityLow();
    }];
    
    UILabel *lab5 = [Tools createLableWithFrame:CGRectZero andTitle:@"统计：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab5];
    [lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab4.mas_bottom).offset(15);
    }];
    
    UILabel *lab6 = [Tools createLableWithFrame:CGRectZero andTitle:@"点击统计按钮展示计划的统计信息，按住拖动可移动按钮位置。" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab6.numberOfLines = 0;
    [self addSubview:lab6];
    [lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab5.mas_right).offset(0);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab4.mas_bottom).offset(15);
        make.width.with.priorityLow();
    }];
}

-(void)buildsixversionsView {
    
    self.frame = CGRectMake(SCREEN_WIDTH/2-140, -173, 280, 173);
    UIView *head = [self setheadView:@"填写统计的期数" Withimage:nil];
    [self addSubview:head];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"期数：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.width.equalTo(@50);
    }];
    
    UITextField *field = [Tools creatFieldWithFrame:CGRectZero andPlaceholder:@"请输入统计的期数" andFont:FONT(15) andTextAlignment:0 andTextColor:YAHEI];
    field.keyboardType = UIKeyboardTypeNumberPad;
    field.layer.cornerRadius = 5;
    field.layer.borderWidth = 1;
    field.layer.borderColor = [UIColor colorWithHex:@"dddddd"].CGColor;
    field.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 30)];
    field.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:field];
    self.versionfield = field;
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab1.mas_right).offset(8);
        make.centerY.equalTo(lab1);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
    }];
    
    UIView *linex = [[UIView alloc]init];
    linex.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:linex];
    UIView *liney = [[UIView alloc]init];
    liney.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:liney];
    
    [linex mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-43);
        make.height.equalTo(@1);
    }];
    
    [liney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(linex.mas_bottom);
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(@1);
    }];
    
    UIButton *cancelBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"取消" andTitleColor:YAHEI andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(dismiss) andType:UIButtonTypeCustom];
    [self addSubview:cancelBtn];
    
    UIButton *sureBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"确定" andTitleColor:YAHEI andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(sureVersion) andType:UIButtonTypeCustom];
    [self addSubview:sureBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.equalTo(self);
        make.top.equalTo(linex.mas_bottom);
        make.right.equalTo(liney.mas_left);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(self);
        make.top.equalTo(linex.mas_bottom);
        make.left.equalTo(liney.mas_right);
    }];
}

-(void)buildsixhelpInfoView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.8*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.8*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"查询助手：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:@"选择条件可查询号码等条件的历史出现位置。目前提供的条件有：号码、生肖、五行、波色、家野、尾数。号码连线功能：进行号码条件查询时，自动将所查询的数字所出现的期数和位置用红线连起，当选择多个号码或生肖时，只显示选择结果不显示连线。" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 0;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(8);
    }];
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"如何使用：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab2.mas_bottom).offset(15);
    }];
    
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:@"点击查询助手右上方的选择条件按钮，进行条件选择，选择条件后点击“确定”后系统回自动帮助您筛选条件的内容" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab4.numberOfLines = 0;
    [self addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab3.mas_bottom).offset(8);
       
    }];
}

-(void)buildpickhelperInfoView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"挑码助手：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:@"您可根据大小、单双、波色、生肖、尾数、头数条件单独查询或综合查询，系统会根据您的选项条件自动选出特定的号码。" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 0;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(8);
    }];
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"使用说明：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab2.mas_bottom).offset(15);
    }];
    
    NSString *str = @"1.大小、单双两面玩法只能选择其中之一。\n\n2.对于不符合逻辑的选项条件，系统不会显示任何的号码结果，比如双-大-单。\n\n3.清空：将当前所有选项条件合显示结果清空。\n\n4.复制结果：可将当前选项结果复制到剪切板。\n\n5.分享结果：可将条件选项的结果分享给身边的亲朋好友。";
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:str andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab4.numberOfLines = 0;
    [self addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab3.mas_bottom).offset(8);
        
    }];
}

-(void)buildAIInfoView {
    
    if (kiPhone5) {
        self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*1.1*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*1.1*SCAL + 40);
    } else {
        self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*1.1*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*1.1*SCAL);
    }
    
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"什么是AI智能选号？" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:@"AI智能选号是系统根据一定的算法在您输入特定一些对您有涵义的数字后推算出的六合彩正码或特码。" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 0;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(8);
    }];
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"恋人幸运号：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab2.mas_bottom).offset(15);
    }];
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:@"选择你的生日和你对象的生日后系统自动计算本期特码。" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab4.numberOfLines = 0;
    [self addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab3.mas_right).offset(0);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab3);
        make.width.with.priorityLow();
    }];
    
    UILabel *lab5 = [Tools createLableWithFrame:CGRectZero andTitle:@"家人幸运号：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab5];
    [lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab4.mas_bottom).offset(15);
    }];
    UILabel *lab6 = [Tools createLableWithFrame:CGRectZero andTitle:@"选择你的生日和你家人的生日后系统自动计算本期幸运码。" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab6.numberOfLines = 0;
    [self addSubview:lab6];
    [lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab5.mas_right).offset(0);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab5);
        make.width.with.priorityLow();
    }];
    
    UILabel *lab7 = [Tools createLableWithFrame:CGRectZero andTitle:@"生日幸运号：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab7];
    [lab7 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab6.mas_bottom).offset(15);
    }];
    UILabel *lab8 = [Tools createLableWithFrame:CGRectZero andTitle:@"选择寿星日期后系统自动计算本期幸运码。" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab8.numberOfLines = 0;
    [self addSubview:lab8];
    [lab8 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab7.mas_right).offset(0);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab7);
        make.width.with.priorityLow();
    }];
    
    UILabel *lab9 = [Tools createLableWithFrame:CGRectZero andTitle:@"生肖卡牌：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab9];
    [lab9 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab8.mas_bottom).offset(15);
    }];
    UILabel *lab10 = [Tools createLableWithFrame:CGRectZero andTitle:@"12张牌，点击翻开三张，随机获得三个生肖号码。" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab10.numberOfLines = 0;
    [self addSubview:lab10];
    [lab10 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab9.mas_right).offset(0);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab9);
        make.width.with.priorityLow();
    }];
    
    UILabel *lab11 = [Tools createLableWithFrame:CGRectZero andTitle:@"摇一摇：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab11];
    [lab11 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab10.mas_bottom).offset(15);
    }];
    UILabel *lab12 = [Tools createLableWithFrame:CGRectZero andTitle:@"晃动手机，系统自动随机提供本期幸运号码。" andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab12.numberOfLines = 0;
    [self addSubview:lab12];
    [lab12 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab11.mas_right).offset(0);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab11);
        make.width.with.priorityLow();
    }];
}

-(void)buildPK10missInfoView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.5*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.5*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSString *str = @"1.统计冠军、亚军~第十名，在不同条件下号码的出现次数及遗漏（未出现）次数;\n2.当前遗漏中的负数代表截止当前连续出现的总次数；\n3.点击向上或向下的三角标识，可将对应标签进行正倒确序排列。";
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:str andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab.numberOfLines = 0;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(25);
        
    }];
}

-(void)buildPK10todaynumberInfoView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.5*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.5*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSString *str = @"1.统计冠军、亚军~第十名，各号码当日的开出次数及近期未开次数;\n\n2.使用参数设置可自定义关注遗漏范围，请根据个人需要手动设置。";
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:str andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab.numberOfLines = 0;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(25);
        
    }];
}

-(void)buildPK10HotandCoolInfoView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.6*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.6*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSString *str = @"1.统计近20/30/50期内冠军、亚军~第十名，各号码的出现次数；\n\n2.热码：出现频率、活跃的号码为热码；\n\n3.冷码：出现频率低甚至没有出现的号码为冷码；\n\n4.温码：介于冷热之间的号码。";
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:str andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab.numberOfLines = 0;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(25);
        
    }];
}

-(void)buildPK10HotandCoolDateViewWith:(NSInteger)index {
    
    self.frame = CGRectMake(SCREEN_WIDTH/2-140, -210, 280, 170);
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView *head = [self setheadView:@"选择统计的期数" Withimage:nil];
    [self addSubview:head];
    
    NSArray *array = @[@"最近20期",@"最近30期",@"最近50期"];
    for(int i = 0; i< array.count; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectMake(0, 35+45*i, self.bounds.size.width, 44) andTitle:array[i] andTitleColor:YAHEI andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(pk10hotandcooldateClick:) andType:UIButtonTypeCustom];
        btn.tag = 100+i;
        btn.backgroundColor = index == i ? kColor(255, 252, 242) : WHITE;
        [self addSubview:btn];
    }
}

-(void)buildPK10TwofacemissInfoView{
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.69*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.69*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSString *str = @"1.统计某段是啊进对应名次位置上大小/单双连续未出现的次数，通过分析“两面”可分析历史遗漏峰值。\n\n2.连续遗漏：大小单双两面连续未出现的次数。如近20期冠军【大】连续5期未开出，则【大】的“连续遗漏”为5。\n\n3.出现次数：指对应“连续遗漏”的出现次数。如近20期内第1-5、8-12期未开出【大】，则“连续遗漏5”的出现次数为2";
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:str andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab.numberOfLines = 0;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(25);
        
    }];
}

-(void)buildPK10TwofaceluzhuInfoView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.69*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.5*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    NSString *str = @"1.表格右侧一列为最新结果；\n\n2.当连续开出的同一结果中断时，则另起一列显示结果；\n\n";
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:str andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab.numberOfLines = 0;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(25);
        
    }];
}

-(void)buildPK10TwofacemissDateViewWith:(NSInteger)index{
    
    self.frame = CGRectMake(SCREEN_WIDTH/2-140, -210, 280, 126);
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView *head = [self setheadView:@"选择日期" Withimage:nil];
    [self addSubview:head];
    
    NSArray *array = @[@"最近一个月",@"最近三个月"];
    for(int i = 0; i< array.count; i++) {
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectMake(0, 35+45*i, self.bounds.size.width, 44) andTitle:array[i] andTitleColor:YAHEI andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(pk10hotandcooldateClick:) andType:UIButtonTypeCustom];
        btn.tag = 100+i;
        btn.backgroundColor = index == i ? kColor(255, 252, 242) : WHITE;
        [self addSubview:btn];
    }
}

-(void)buildPK10guanjunheluzhuInfoView{
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.75*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.75*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSString *str = @"1.表格右侧一列为最新结果；\n\n2.当连续开出的同一结果中断时，则另起一列显示结果；\n\n3.冠亚和单双：冠亚和值为单时，投注单的为中奖，为双时，投注双的视为中奖，其余视为不中奖；\n\n4.冠亚和大小：冠亚和值大于11时，投注大的为中奖，小于或等于11时，投注小的视为中奖，其余视为不中奖；";
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:str andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab.numberOfLines = 0;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(25);
        
    }];
}

-(void)buildPK10qianhouluzhuInfoView {
    
    self.frame = CGRectMake(15, -(SCREEN_WIDTH - 30)*0.55*SCAL, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)*0.55*SCAL);
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    
    NSString *str = @"1.表格右侧一列为最新结果；\n\n2.当连续开出的同一结果中断时，则另起一列显示结果；\n\n3.“前”标识号码开出在前5名，“后”表示号码开出在后5名。";
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:str andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab.numberOfLines = 0;
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(25);
        
    }];
}

-(void)buildCartchongqinInfoView:(NSInteger)type {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CartChongqinHelpData" ofType:@"plist"];
    NSDictionary *datatype = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *data = datatype[INTTOSTRING(type)];
    
    
    NSString *str1 = data[@"str1"];
    NSString *str2 = data[@"str2"];
    
    CGFloat str1_h = [Tools createLableHighWithString:str1 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    CGFloat str2_h = [Tools createLableHighWithString:str2 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    
    
    CGFloat h = 35 + 15 + 20 + 8 + str1_h + 15 + 20 + 8 + str2_h + 25;
    
    self.frame = CGRectMake(15, -h, SCREEN_WIDTH - 30, h);
    
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    
    [self addSubview:head];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"选号规则：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:str1 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 0;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(8);
    }];
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"中奖说明：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab2.mas_bottom).offset(15);
    }];
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:str2 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab4.numberOfLines = 0;
    [self addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab3);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab3.mas_bottom).offset(8);
        make.width.with.priorityLow();
    }];
    
    [self layoutIfNeeded];
    
}

-(void)buildCPTBuyInfoViewWithInfo:(NSString *)str1 eg:(NSString *)str2 {
    CGFloat str1_h = [Tools createLableHighWithString:str1 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    CGFloat str2_h = [Tools createLableHighWithString:str2 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    CGFloat h = 35 + 15 + 20 + 8 + str1_h + 15 + 20 + 8 + str2_h + 25;
    if ([str1 containsString:@"\n"]) {
        NSArray *array = [str1 componentsSeparatedByString:@"\n"];
        NSInteger count = [array count] - 1;
        h = h + 2 * count;
    }
    
    self.frame = CGRectMake(15, -h, SCREEN_WIDTH - 30, h);
    
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"玩法说明：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:str1 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 0;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(8);
    }];
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"投注示例：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab2.mas_bottom).offset(15);
    }];
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:str2 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab4.numberOfLines = 0;
    [self addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab3);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab3.mas_bottom).offset(8);
        make.width.with.priorityLow();
    }];
    [self layoutIfNeeded];
}
-(void)buildCPTBuyInfoViewWithStr1:(NSString *)str1 andStr2:(NSString *)str2 andStr3:(NSString *)str3{
    CGFloat str1_h = [Tools createLableHighWithString:str1 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    CGFloat str2_h = [Tools createLableHighWithString:str2 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    CGFloat str3_h = [Tools createLableHighWithString:str3 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
//    CGFloat spaceH = 10;
    CGFloat spaceLeft = 15;
    //    CGFloat h = 35 + 15 + 20 + 8 + str1_h + 15 + 20 + 8 + str2_h + 25 +str3_h;
    //    CGFloat h = 78 + str1_h + 68 + str2_h + 25 +str3_h;
    CGFloat h = str1_h + str2_h + str3_h +150;
    if ([str1 containsString:@"\n"]) {
        NSArray *array = [str1 componentsSeparatedByString:@"\n"];
        NSInteger count = [array count] - 1;
        h = h + 2 * count;
    }
    CGFloat contentHeight = h;
    if(h>SCREEN_HEIGHT-100){
        h = SCREEN_HEIGHT-100;
    }
    self.frame = CGRectMake(15, -h, SCREEN_WIDTH - 30, h);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height-30)];
    scrollView.contentSize = CGSizeMake(self.frame.size.width, contentHeight);
//    scrollView.backgroundColor = [UIColor cyanColor];
    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.scrollEnabled = YES;
    [self addSubview:scrollView];
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    [self addSubview:head];
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"简短说明：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [scrollView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(spaceLeft);
        make.top.equalTo(scrollView).offset(spaceLeft);
    }];

    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:str1 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 0;
    [scrollView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(spaceLeft);
        make.right.equalTo(self).offset(-30);
        make.top.equalTo(lab1.mas_bottom).offset(8);
    }];
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"玩法说明：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [scrollView addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(spaceLeft);
        make.top.equalTo(lab2.mas_bottom).offset(8);
    }];
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:str2 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab4.numberOfLines = 0;
    [scrollView addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab3);
        make.width.equalTo(scrollView).offset(-30);
        make.top.equalTo(lab3.mas_bottom).offset(8);
//        make.width.with.priorityLow();
    }];
    UILabel *lab5 = [Tools createLableWithFrame:CGRectZero andTitle:@"投注示例：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [scrollView addSubview:lab5];
    [lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab4);
        make.right.equalTo(self).offset(-spaceLeft);
        make.top.equalTo(lab4.mas_bottom).offset(8);
        make.width.with.priorityLow();
    }];
    UILabel *lab6 = [Tools createLableWithFrame:CGRectZero andTitle:str3 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab6.numberOfLines = 0;
    [scrollView addSubview:lab6];
    [lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lab5);
        make.width.equalTo(self).offset(-30);
        make.top.equalTo(lab5.mas_bottom).offset(8);
    }];
    [self layoutIfNeeded];
}

-(void)buildCartsixInfoView:(NSInteger)type {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CartSixHelpData" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSDictionary *data = [dic valueForKey:[NSString stringWithFormat:@"%ld",type]];
    
    NSString *str1 = data[@"str1"];
    NSString *str2 = data[@"str2"];
    
    CGFloat str1_h = [Tools createLableHighWithString:str1 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    CGFloat str2_h = [Tools createLableHighWithString:str2 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    
    
    CGFloat h = 35 + 15 + 20 + 8 + str1_h + 15 + 20 + 8 + str2_h + 25;
    
    if ([str1 containsString:@"\n"]) {
        
         NSArray *array = [str1 componentsSeparatedByString:@"\n"];
        NSInteger count = [array count] - 1;
        h = h + 10 * count;
    }
    self.frame = CGRectMake(15, -h, SCREEN_WIDTH - 30, h);
    
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    
    [self addSubview:head];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"玩法说明：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:str1 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 0;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(8);
    }];
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"投注示例：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab2.mas_bottom).offset(15);
    }];
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:str2 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab4.numberOfLines = 0;
    [self addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab3);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab3.mas_bottom).offset(8);
        make.width.with.priorityLow();
    }];
    
    [self layoutIfNeeded];
    
}

-(void)buildCartPCInfoView:(NSInteger)type {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CartPCHelpData" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSDictionary *data = [dic valueForKey:[NSString stringWithFormat:@"%ld",type]];
    
    NSString *str1 = data[@"str1"];
    NSString *str2 = data[@"str2"];
    
    CGFloat str1_h = [Tools createLableHighWithString:str1 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    CGFloat str2_h = [Tools createLableHighWithString:str2 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    
    CGFloat h = 35 + 15 + 20 + 8 + str1_h + 15 + 20 + 8 + str2_h + 25;
    
    if ([str1 containsString:@"\n"]) {
        
        NSArray *array = [str1 componentsSeparatedByString:@"\n"];
        NSInteger count = [array count] - 1;
        h = h + 10 * count;
    }
    self.frame = CGRectMake(15, -h, SCREEN_WIDTH - 30, h);
    
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    
    [self addSubview:head];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"玩法说明：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:str1 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 0;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(8);
    }];
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"投注示例：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab2.mas_bottom).offset(15);
    }];
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:str2 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab4.numberOfLines = 0;
    [self addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab3);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab3.mas_bottom).offset(8);
        make.width.with.priorityLow();
    }];
    
    [self layoutIfNeeded];
}

-(void)buildCartBeijinInfoView:(NSInteger)type{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CartBeijingHelpData" ofType:@"plist"];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSDictionary *data = [dic valueForKey:[NSString stringWithFormat:@"%ld",type]];
    
    NSString *str1 = data[@"str1"];
    NSString *str2 = data[@"str2"];
    
    CGFloat str1_h = [Tools createLableHighWithString:str1 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    CGFloat str2_h = [Tools createLableHighWithString:str2 andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    
    CGFloat h = 35 + 15 + 20 + 8 + str1_h + 15 + 20 + 8 + str2_h + 25;
    
    self.frame = CGRectMake(15, -h, SCREEN_WIDTH - 30, h);
    
    UIView *head = [self setheadView:@"帮助说明" Withimage:@"弹窗说明"];
    
    [self addSubview:head];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:@"玩法说明：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    
    UILabel *lab2 = [Tools createLableWithFrame:CGRectZero andTitle:str1 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab2.numberOfLines = 0;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab1.mas_bottom).offset(8);
    }];
    
    UILabel *lab3 = [Tools createLableWithFrame:CGRectZero andTitle:@"投注示例：" andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    [self addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.top.equalTo(lab2.mas_bottom).offset(15);
    }];
    UILabel *lab4 = [Tools createLableWithFrame:CGRectZero andTitle:str2 andfont:FONT(13) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab4.numberOfLines = 0;
    [self addSubview:lab4];
    [lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(lab3);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(lab3.mas_bottom).offset(8);
        make.width.with.priorityLow();
    }];
    
    [self layoutIfNeeded];
}

/**
 提现说明
 */
-(void)buildGetOutPriceWithtext:(NSString *)string{
    
    CGFloat str_h = [Tools createLableHighWithString:string andfontsize:13 andwithwidth:SCREEN_WIDTH - 60];
    
    CGFloat h = 35 + 15 + 20 + 8 + str_h + 25;
    
    self.frame = CGRectMake(15, -h, SCREEN_WIDTH - 30, h);
    
    UIView *head = [self setheadView:@"提现说明" Withimage:nil];
    
    [self addSubview:head];
    
    UILabel *lab1 = [Tools createLableWithFrame:CGRectZero andTitle:string andfont:FONT(15) andTitleColor:BLACK andBackgroundColor:CLEAR andTextAlignment:0];
    lab1.numberOfLines = 0;
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(head.mas_bottom).offset(15);
    }];
    [self layoutIfNeeded];
}

-(UIView *)setheadView:(NSString *)title Withimage:(NSString *)imagename {
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 35)];
    head.backgroundColor = [[CPTThemeConfig shareManager] tixianShuoMingColor];
    
    UIImageView *imgv = [[UIImageView alloc]init];
    [head addSubview:imgv];
    if (imagename) {
        
        UIImage *image = IMAGE(imagename);
        imgv.image = image;
        [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(head).offset(10);
            make.centerY.equalTo(head);
            make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
        }];
    }
    
    UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:title andfont:FONT(14) andTitleColor:WHITE andBackgroundColor:CLEAR andTextAlignment:0];
    [head addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(imgv.mas_right).offset(8);
        make.centerY.equalTo(head);
    }];
    
    UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"关闭弹窗") andTarget:self andAction:@selector(dismiss) andType:UIButtonTypeCustom];
    [head addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(head).offset(-10);
        make.centerY.equalTo(head);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    
    return head;
}

-(void)selectversionsClick:(UIButton *)sender {
    
    for (int i = 100 ; i< 104; i++) {
        
        UIButton *btn = [self viewWithTag:i];
        
        btn.selected = NO;
    }
    self.index = sender.tag-100;
    sender.selected = YES;
}

-(void)selectsortClick:(UIButton *)sender {
    
    UIButton *btn = [self viewWithTag:200];
    UIButton *btn2 = [self viewWithTag:201];
    btn.selected = NO;
    btn2.selected = NO;
    self.sort = sender.tag-200;
    sender.selected = YES;
}

-(void)selecthiddenClick:(UIButton *)sender {
    
    UIButton *btn = [self viewWithTag:200];
    UIButton *btn2 = [self viewWithTag:201];
    btn.selected = NO;
    btn2.selected = NO;
    
    sender.selected = YES;
}

-(void)selectmissClick:(UIButton *)sender {
    
    UIButton *btn = [self viewWithTag:300];
    UIButton *btn2 = [self viewWithTag:301];
    btn.selected = NO;
    btn2.selected = NO;
    
    sender.selected = YES;
}

-(void)selectmisstime:(UIButton *)sender {
    
    if (self.selectbuttonBlock) {
        
        self.selectbuttonBlock(sender);
    }
    
    [self dismiss];
}

-(void)pk10hotandcooldateClick:(UIButton *)sender {
    
    if (self.selectindexBlock) {
        
        self.selectindexBlock(sender.tag - 100);
    }
    
    [self dismiss];
}

-(void)show {
    
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    
    [keywindw addSubview:_overlayView];
    [keywindw addSubview:self];
    
    CGRect frame = self.frame;
    
    frame.origin.y = keywindw.center.y - frame.size.height/2;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = frame;
        
        [self layoutIfNeeded];
        
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)showWith:(UIView *)view {
    
    [view addSubview:_overlayView];
    [view addSubview:self];
    
    CGRect frame = self.frame;
    
    frame.origin.y = view.center.y - frame.size.height/2;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = frame;
        
        [self layoutIfNeeded];
        
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)dismiss {
    
    CGRect frame = self.frame;
    
    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if (self.dismissBlock) {
            
            self.dismissBlock(self.index, self.sort);
        }
        
        [_overlayView removeFromSuperview];
        
        [self removeFromSuperview];
    }];
}

-(void)sureVersion{
    
    if ([Tools isEmptyOrNull:self.versionfield.text]) {
        
        [MBProgressHUD showError:@"请输入期数"];
        
        return;
    }
    else if (self.versionfield.text.integerValue == 0) {
        
        [MBProgressHUD showError:@"请输入大于0的期数"];
        
        return;
    }
    else if (self.versionfield.text.integerValue > 200) {
        
        [MBProgressHUD showError:@"输入最大统计期数不要大于200"];
        
        return;
    }
    if (self.showalertBlock) {
        
        self.showalertBlock(self.versionfield.text);
    }
    [self dismiss];
}

- (void)buildLongDragonView:(NSArray *)array selectedItemAtIndexPathArray:(NSArray *)selectedItemAtIndexPathArray {
    
    self.frame = CGRectMake(10, -(SCREEN_WIDTH - 10*2)*1.1*SCAL, SCREEN_WIDTH - 10*2, SCREEN_HEIGHT*0.7);
    
    self.backgroundColor= [UIColor clearColor];
    
    UIView *backView = [[UIView alloc] init];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.bottom.right.mas_equalTo(-10);
    }];

    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"推送提示设置";
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(18);
        make.centerX.equalTo(backView.mas_centerX);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHex:@"#EBEBEB"];
    [backView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(49);
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [confirmBtn setImage:[UIImage imageNamed:@"dial_mute"] forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_LongDragon_PushSetting_BtnBack];
    confirmBtn.layer.cornerRadius = 3;
    confirmBtn.layer.masksToBounds = YES;
    [backView addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom).offset(-15);
        make.right.equalTo(backView.mas_right).offset(-30);
        make.left.equalTo(backView.mas_left).offset(30);
        make.height.mas_equalTo(@45);
    }];

    UIButton *closedBtn = [[UIButton alloc] init];
    [closedBtn setTitle:@"确认" forState:UIControlStateNormal];
    [closedBtn addTarget:self action:@selector(onLongClosedBtn) forControlEvents:UIControlEventTouchUpInside];
    [closedBtn setBackgroundImage:[UIImage imageNamed:@"ic_long_closed"] forState:UIControlStateNormal];
    [self addSubview:closedBtn];
    
    [closedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_right).offset(-6);
        make.centerY.equalTo(backView.mas_top).offset(6);
        make.size.mas_equalTo(28);
    }];
    
    
    VVLongCollectionView *longCollectionView = [[VVLongCollectionView alloc] initWithFrame:CGRectMake(10, 50, self.frame.size.width -10*2 - 10*2, self.frame.size.height -10*2 - 50 - (45+15+15))];

    longCollectionView.didSelectItemAtIndexPathBlock = ^(NSArray *indexPathsForSelectedItems){
        if (self.didSelectItemAtIndexPathBlock) {
            self.didSelectItemAtIndexPathBlock(indexPathsForSelectedItems);
        }
    };
    
    longCollectionView.selectedItemAtIndexPathArray = selectedItemAtIndexPathArray;
    longCollectionView.model = array;
    
    [backView addSubview:longCollectionView];
    _longCollectionView = longCollectionView;

}

- (void)confirmBtn {
    if (self.didConfirmBlock) {
        self.didConfirmBlock();
    }
    [self dismiss];
}
-(void)onLongClosedBtn {
    [self dismiss];
}

@end
