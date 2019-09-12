//
//  CartTypeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/27.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartTypeView.h"

@implementation CartTypeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(TagView *)playView {
    
    if (!_playView) {
        
        _playView = [[TagView alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80, 0)];
        _playView.delegate = self;
        [self addSubview:_playView];
        
        UILabel *lab = [Tools createLableWithFrame:CGRectZero andTitle:@"玩法" andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
        [self addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_playView).offset(20);
            make.left.equalTo(self);
            make.right.equalTo(_playView.mas_left);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self);
            make.bottom.equalTo(_playView);
            make.height.equalTo(@1);
        }];
    }
    return _playView;
}

-(TagView *)type1View {
    
    if (!_type1View) {
        
        _type1View = [[TagView alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80, 0)];
        _type1View.delegate = self;
        [self addSubview:_type1View];
        
        _type1lab = [Tools createLableWithFrame:CGRectZero andTitle:@"直选" andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
        [self addSubview:_type1lab];
        
        [_type1lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_type1View).offset(20);
            make.left.equalTo(self);
            make.right.equalTo(_type1View.mas_left);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self);
            make.bottom.equalTo(_type1View);
            make.height.equalTo(@1);
        }];
    }
    return _type1View;
}

-(TagView *)type2View {
    
    if (!_type2View) {
        
        _type2View = [[TagView alloc]initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80, 0)];
        _type2View.delegate = self;
        [self addSubview:_type2View];
        
        _type2lab = [Tools createLableWithFrame:CGRectZero andTitle:@"组选" andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:1];
        [self addSubview:_type2lab];
        
        [_type2lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_type2View).offset(20);
            make.left.equalTo(self);
            make.right.equalTo(_type2View.mas_left);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self);
            make.bottom.equalTo(_type2View);
            make.height.equalTo(@1);
        }];
    }
    return _type2View;
}

-(UIView *)sureBtnView {
    
    if (!_sureBtnView) {
        
        _sureBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 85)];
        _sureBtnView.backgroundColor = WHITE;
        [self addSubview:_sureBtnView];
        
        UIButton *sureBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"确定" andTitleColor:WHITE andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(sureClick) andType:UIButtonTypeCustom];
        sureBtn.layer.cornerRadius = 5;
        sureBtn.backgroundColor = BUTTONCOLOR;
        [_sureBtnView addSubview:sureBtn];
        
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(_sureBtnView).with.insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
    }
    
    return _sureBtnView;
}

-(UIControl *)overlayView {
    
    if (!_overlayView) {
        
        _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, self.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = 0.3;
    }
    return _overlayView;
}

-(void)layoutSubviews {
    
//    self.alpha = 0;
//    self.sureBtnView.alpha = 0;
    [UIView animateWithDuration:0.35 animations:^{
        
        self.playView.frame = CGRectMake(80, 0, SCREEN_WIDTH - 80, self.playView.bounds.size.height);
        
        if (self.type == 1){
            self.type1View.frame = CGRectMake(80, self.playView.height, SCREEN_WIDTH - 80, self.type1View.bounds.size.height);
            self.type2View.frame = CGRectMake(80, self.type1View.y+self.type1View.height, SCREEN_WIDTH - 80, self.type2View.bounds.size.height);
        }
        else if(self.type == 2 || self.type == 4) {
            
            self.type2View.hidden = YES;
            self.type2View.alpha = 0;
            self.type1View.frame = CGRectMake(80, self.playView.height, SCREEN_WIDTH - 80, self.type1View.bounds.size.height);
            self.type2View.frame = CGRectMake(80, self.type1View.y+self.type1View.height, SCREEN_WIDTH - 80, 0);
        }
        else if (self.type == 3) {
            
            self.type1View.hidden = YES;
            self.type1View.alpha = 0;
            self.type2View.hidden = YES;
            self.type2View.alpha = 0;
            self.type1View.frame = CGRectMake(80, self.playView.height, SCREEN_WIDTH - 80, 0);
            self.type2View.frame = CGRectMake(80, self.type1View.y+self.type1View.height, SCREEN_WIDTH - 80, 0);
        }
        
        self.sureBtnView.frame = CGRectMake(0, self.type2View.y+self.type2View.height, SCREEN_WIDTH, 85);
        
        self.frame = CGRectMake(0, self.frame.origin.y, SCREEN_WIDTH, self.sureBtnView.y + self.sureBtnView.height > (SCREEN_HEIGHT - NAV_HEIGHT - 100) ? (SCREEN_HEIGHT - NAV_HEIGHT - 100) : self.sureBtnView.y + self.sureBtnView.height);
        self.contentSize = CGSizeMake(SCREEN_WIDTH, self.sureBtnView.y + self.sureBtnView.height);
        
    }];
    
    
}

-(NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(void)sureClick {
    
    if (self.selectModel == nil) {
        
        [MBProgressHUD showError:@"请选分类"];
        
        return;
    }
    if (self.showTypeBlock) {
        
        self.showTypeBlock(self.selectModel);
    }
    
    self.height = self.bounds.size.height;
    
    [self dismiss];
}

-(void)handleSelectWith:(CartTypeModel *)typemodel WithView:(TagView *)view {
    
    if (view == self.playView) {
        
        if (self.type == 3) {
            
            self.selectModel = typemodel;
            
            return;
        }
        
        if (typemodel.type1Array.count == 0 && typemodel.type2Array.count == 0) {
            
            if (self.type == 4) { //六合彩二级分类
                
                [WebTools postWithURL:@"/lottery/queryTwoLevelPlay.json" params:@{@"categoryId":@(typemodel.categoryId),@"parentId":@(typemodel.ID)} success:^(BaseData *data) {
                    
                    NSArray *array = [CartTypeModel mj_objectArrayWithKeyValuesArray:data.data];
                    
                    [typemodel.type1Array removeAllObjects];
                    
                    [typemodel.type1Array addObjectsFromArray:array];
                    
                    CartTypeModel *classmodel = typemodel.type1Array.firstObject;
                    
                    classmodel.selected = YES;
                    
                    self.selectModel = classmodel;
                    
                    self.type1lab.text = @"分类";
                    
                    self.type1View.arr = typemodel.type1Array;
                    
                    [self layoutIfNeeded];
                    
                } failure:^(NSError *error) {
                    
                } showHUD:NO];
            }
            else{ //重庆时时彩和北京PK10直选和组选
                [WebTools postWithURL:@"/lottery/queryChildrenByParentId.json" params:@{@"categoryId":@(typemodel.categoryId),@"parentId":@(typemodel.ID)} success:^(BaseData *data) {
                    
                    int i = 0 ;
                    for (NSArray *array in data.data) {
                        
                        NSArray *arrlist = [CartTypeModel mj_objectArrayWithKeyValuesArray:array];
                        
                        if (i == 0) {
                            
                            [typemodel.type1Array removeAllObjects];
                            
                            [typemodel.type1Array addObjectsFromArray:arrlist];
                            
                            CartTypeModel *classmodel = typemodel.type1Array.firstObject;
                            
                            classmodel.selected = YES;
                            
                            self.selectModel = classmodel;
                        }
                        else{
                            
                            [typemodel.type2Array removeAllObjects];
                            
                            for (CartTypeModel *classmodel in arrlist) {
                                
                                classmodel.isgroup = YES;
                                
                                [typemodel.type2Array addObject:classmodel];
                            }
                            
                        }
                        i++;
                    }
                    
                    self.type1View.arr = typemodel.type1Array;
                    
                    self.type2View.arr = typemodel.type2Array;
                    
                    self.type1lab.text = typemodel.name;
                    
                    [self layoutIfNeeded];
                    
                } failure:^(NSError *error) {
                    
                } showHUD:NO];
            }
            
        }
        else{
            self.type1View.arr = typemodel.type1Array;
            
            self.type2View.arr = typemodel.type2Array;
            
            self.type1lab.text = self.type == 4 ? @"分类" : typemodel.name;
            
            [self layoutIfNeeded];
        }
    }
    else if (view == self.type1View) {
        
        for (UIButton *btn in self.type2View.subviews) {
            
            btn.backgroundColor = CLEAR;
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        
        self.selectModel = typemodel;
    }
    else if (view == self.type2View) {
        
        for (UIButton *btn in self.type1View.subviews) {
            
            btn.backgroundColor = CLEAR;
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
        
        self.selectModel = typemodel;
    }
}

//-(void)show:(UIView*)keyview Withtype:(NSInteger)type{
//
//    self.type = type;
//
//    if (type == 2){
//
//        [self getbiejinPK10Data];
//    }
//    else if (type == 3) {
//
//        [self getPCdandanData];
//    }
//    else if (type == 4) {
//
//        [self getSixData];
//    }
//
//    UIButton *btn = [self.playView viewWithTag:100];
//
//    [self.playView clickTo:btn];
//
//    [keyview addSubview:self.overlayView];
//    [self.overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [keyview addSubview:self];
//}

-(void)show:(UIView *)keyview Withtype:(NSInteger)type Withmodel:(NSArray<CartTypeModel *> *)typelist {
    
    self.type = type;
    
    self.selectModel = nil;
    
    self.playView.arr = typelist;
    
    for (CartTypeModel *model in typelist) {
        
        if (model.selected) {
            
            NSInteger index = [typelist indexOfObject:model];
            
            UIButton *btn = [self.playView viewWithTag:100+index];
            
            [self.playView clickTo:btn];
            
            for (CartTypeModel *classmodel in model.type1Array) {
                
                if (classmodel.selected) {
                    
                    NSInteger classindex = [model.type1Array indexOfObject:classmodel];
                    
                    UIButton *classbtn = [self.type1View viewWithTag:100+classindex];
                    
                    [self.type1View clickTo:classbtn];
                }
            }
            for (CartTypeModel *classmodel in model.type2Array) {
                
                if (classmodel.selected) {
                    
                    NSInteger classindex = [model.type2Array indexOfObject:classmodel];
                    
                    UIButton *classbtn = [self.type2View viewWithTag:100+classindex];
                    
                    [self.type2View clickTo:classbtn];
                }
            }
        }
    }
    
//    if (self.height == 0) {
//        
//        UIButton *btn = [self.playView viewWithTag:100];
//        
//        [self.playView clickTo:btn];
//    }
    
    [keyview addSubview:self.overlayView];
    [self.overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [keyview addSubview:self];
    
    [self layoutIfNeeded];
    
    self.alpha = 0;
    self.sureBtnView.alpha = 0;
    [UIView animateWithDuration:0.35 animations:^{
        
        self.alpha = 1;
        self.sureBtnView.alpha = 1;
    }];
}

-(void)dismiss{
    
    self.alpha = 1;
    self.sureBtnView.alpha = 1;
    [UIView animateWithDuration:0.35 animations:^{
        
        self.sureBtnView.alpha = 0;
        
        self.playView.frame = CGRectMake(80, 0, SCREEN_WIDTH - 80, 0);
        
        self.type1View.frame = CGRectMake(80, self.playView.height, SCREEN_WIDTH - 80, 0);
        
        self.type2View.frame = CGRectMake(80, self.type1View.y+self.type1View.height, SCREEN_WIDTH - 80 , 0);
        
        self.sureBtnView.frame = CGRectMake(0, self.type2View.y+self.type2View.height, SCREEN_WIDTH, 0);
        
        self.frame = CGRectMake(0, self.frame.origin.y, SCREEN_WIDTH, 0);
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        self.dismissBlock();
        
        [self removeFromSuperview];
        [self.overlayView removeFromSuperview];
        self.overlayView = nil;
    }];
    
}























































@end
