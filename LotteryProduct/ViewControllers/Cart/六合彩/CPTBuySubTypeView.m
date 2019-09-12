
//
//  CPTBuyLeftView.m
//  LotteryProduct
//
//  Created by Jason Lee on 2019/2/1.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuySubTypeView.h"
#import "CPTBuyLeftButton.h"

@interface CPTBuySubTypeView(){
    UIScrollView *_scrollView;
}
@end

@implementation CPTBuySubTypeView
- (void)dealloc{
    _btnArray = nil;
    _scrollView = nil;
}

- (instancetype)init{
    self = [super init];
    if(self){
        _btnArray = [NSMutableArray array];
        UIView * line = [[UIView alloc] init];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_Dark){//
            line.backgroundColor = [UIColor colorWithHex:@"43464f"];
        }else if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
//            line.alpha = 0.4;
            line.backgroundColor = [UIColor colorWithHex:@"D6D6D6"];
        }
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.offset(8);
            make.top.offset(36.5);
            make.height.offset(0.5);
        }];
        _scrollView = [[UIScrollView alloc] init];
        [self addSubview:_scrollView];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = CLEAR;//[[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
         if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
            self.backgroundColor =  WHITE;
        }
    }
    return self;
}


//@[@"特码",@"两面",@"正码",@"正码1-6",@"正特",@"连特",@"半波",@"尾数",@"不中",@"平特",@"特肖",@"六肖",@"连肖",@"连尾",@"1-6龙虎",@"五行"]
- (void)configUIByData:(NSArray<CPTSixPlayTypeModel *> *)playTypeArray{
    [_btnArray removeAllObjects];
    for(UIView * v in _scrollView.subviews){
        if([v isKindOfClass:[CPTBuyLeftButton class]]){
            [v removeFromSuperview];
        }
    }
    UIButton * tmp;
    CGFloat tmpW =0.0;
    for(NSInteger i=0;i<playTypeArray.count;i++){
        CPTSixPlayTypeModel * playTypeModel = playTypeArray[i];
        CPTBuyLeftButton * button = [CPTBuyLeftButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize: 16.0];
        [button configUI];
        CGFloat w = [Tools createLableWidthWithString:playTypeModel.playType andfontsize:16 andwithhigh:27];
        [_scrollView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i==0){
                make.left.offset(4.);
//                [button showUnSelPoint];
                [button setSelected:YES];
            }else{
                make.left.equalTo(tmp.mas_right).offset(2.);
            }
            make.top.offset(10.);
            make.height.offset(27.);
            make.width.offset(w+20);
        }];
        tmpW = w+20+tmpW;
        [button setTitle:playTypeModel.playType forState:UIControlStateNormal];
        [button setTitleColor:[[CPTThemeConfig shareManager] Buy_LeftView_Btn_TitleUnSelC] forState:UIControlStateNormal];
        [button setTitleColor:[[CPTThemeConfig shareManager] Buy_LeftView_Btn_TitleSelC] forState:UIControlStateSelected];
        if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_Dark){//
            [button setBackgroundImage:IMAGE(@"buy_right_btn_sel") forState:UIControlStateNormal];
            [button setBackgroundImage:IMAGE(@"buy_right_btn_unSel") forState:UIControlStateSelected];
        }else if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
            [button setBackgroundImage:IMAGE(@"fy_buy_right_btn_unSel") forState:UIControlStateNormal];
            [button setBackgroundImage:IMAGE(@"fy_buy_right_btn_sel") forState:UIControlStateSelected];
        }
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //        button.rightModels = playTypeModel.subTypes;
        button.model = playTypeModel;
        [_btnArray addObject:button];
        tmp = button;
    }
    _scrollView.contentSize = CGSizeMake(tmpW+8+20,0);
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
    }
    if(self.delegate){
        [self.delegate clickBuySubTypeView:btn];
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

@end
