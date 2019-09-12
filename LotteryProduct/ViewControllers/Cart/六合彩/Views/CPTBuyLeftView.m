
//
//  CPTBuyLeftView.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuyLeftView.h"
#import "CPTBuyLeftButton.h"

@interface CPTBuyLeftView(){
    UIScrollView *_scrollView;
}
@end

@implementation CPTBuyLeftView
- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
    _btnArray = nil;
    _scrollView = nil;
}

- (instancetype)init{
    self = [super init];
    if(self){
        _btnArray = [NSMutableArray array];
        _scrollView = [[UIScrollView alloc] init];
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIView * line = [[UIView alloc] init];
        line.backgroundColor  = [[CPTThemeConfig shareManager] Buy_CollectionViewLine_C];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.width.offset(0.5);
            make.bottom.equalTo(self);
        }];
        if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
            [_scrollView.layer insertSublayer:jbbj(self.bounds) atIndex:0];
        }else{
            _scrollView.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
        }
    }
    return self;
}


//@[@"特码",@"两面",@"正码",@"正码1-6",@"正特",@"连特",@"半波",@"尾数",@"不中",@"平特",@"特肖",@"六肖",@"连肖",@"连尾",@"1-6龙虎",@"五行"]
- (void)configUIByData:(NSArray<CPTSixPlayTypeModel *> *)playTypeArray{
    UIButton * tmp;
    for(NSInteger i=0;i<playTypeArray.count;i++){
        CPTSixPlayTypeModel * playTypeModel = playTypeArray[i];
        CPTBuyLeftButton * button = [CPTBuyLeftButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = Font(16);
        [button configUI];
        [_scrollView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i==0){
                make.top.offset(10.);
                [button showUnSelPoint];
                [button setSelected:YES];
            }else{
                make.top.equalTo(tmp.mas_bottom).offset(2.);
            }
            make.left.offset(0);
            make.height.offset(38.);
            make.width.offset(80.);
        }];
        [button setTitle:playTypeModel.playType forState:UIControlStateNormal];
        [button setTitleColor:[[CPTThemeConfig shareManager] Buy_LeftView_Btn_TitleUnSelC] forState:UIControlStateNormal];
        [button setTitleColor:[[CPTThemeConfig shareManager] Buy_LeftView_Btn_TitleSelC] forState:UIControlStateSelected];
        [button setBackgroundImage:[[CPTThemeConfig shareManager] Buy_LeftView_Btn_BackgroundUnSel] forState:UIControlStateNormal];
        [button setBackgroundImage:[[CPTThemeConfig shareManager] Buy_LeftView_Btn_BackgroundSel] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
//        button.rightModels = playTypeModel.subTypes;
        button.model = playTypeModel;
        [_btnArray addObject:button];
        tmp = button;
    }
    _scrollView.contentSize = CGSizeMake(0,playTypeArray.count*(38+2)+10);
}

- (void)clickBtn:(CPTBuyLeftButton *)btn{
    BOOL isSel = btn.isSelected;
    if(isSel){
        return;
    }
    [btn setSelected:YES];
    for(CPTBuyLeftButton * b in _btnArray){
        if(btn != b){
            [b setSelected:NO];
        }
        [b checkPointState];
    }
    [btn.pointView setHidden:NO];
    if(self.delegate){
        [self.delegate clickLeftButtonView:btn];
    }
}

- (CPTBuyLeftButton *)selectButtonByIndex:(NSString *)playType{
    for(CPTBuyLeftButton * btn in _btnArray){
        if([btn.model.playType isEqualToString:playType]){
            return btn;
        }
    }
    return nil;
}

- (void)clearAll{
    for(CPTBuyLeftButton * b in _btnArray){
        [b clearSelectModels];
        [b hiddenPoint];
    }
}

@end
