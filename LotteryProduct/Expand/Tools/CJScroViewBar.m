//
//  CJScroViewBar.m
//  GetSawProduct
//
//  Created by vsskyblue on 2017/11/7.
//  Copyright © 2017年 vsskyblue. All rights reserved.
//

#import "CJScroViewBar.h"

@interface CJScroViewBar(){
    NSArray *tempArray;
}
@property(nonatomic, strong)    NSMutableArray<UIButton *> *itemsArray;

@end

@implementation CJScroViewBar


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.itemsArray = [NSMutableArray array];
        [self loadUI];

    }
    return self;
}

- (void)loadUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

- (void)setData:(NSArray *)titles NormalColor:(UIColor *)normal_color SelectColor:(UIColor *)select_color Font:(UIFont *)font{
    
    tempArray = titles;
    
    CGFloat _width = 0;
    
    CGFloat _orignx = 0;
    
//    CGFloat _width = Bound_Width / titles.count;
    
    for (int i=0; i<titles.count; i++) {
        
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSString *title = [titles objectAtIndex:i];
        
        NSDictionary *attributes = @{NSFontAttributeName : font};
        
        CGSize textSize = [title sizeWithAttributes:attributes];
        
        CGFloat currentOriginX = _orignx;
        
        
        UIView *line = [[UIView alloc] init];
        
        
        
        if (tempArray.count >= 5) {
            
//             _width = textSize.width + 20;
            _width = self.bounds.size.width / 4.5;

            item.frame = CGRectMake(_width*i, 0, _width, CGRectGetHeight(self.frame));
        }
        else{
            
            _width = self.bounds.size.width / titles.count;
            
            if (_isXinshui) {
                item.frame = CGRectMake(currentOriginX, 5, _width, CGRectGetHeight(self.frame)-3);
            }else{
                item.frame = CGRectMake(currentOriginX, 0, _width, CGRectGetHeight(self.frame));

            }
            
            item.titleLabel.adjustsFontSizeToFitWidth = YES;
            
            item.titleLabel.numberOfLines = 2;
            
            if (self.isXinshui) {
                line.frame = CGRectMake(item.width - 1, 15, 1, item.height - 30);
                [item addSubview:line];
                line.backgroundColor = [UIColor lightGrayColor];
            }
        }
        
        _orignx = currentOriginX + _width;
        
//        item.frame = CGRectMake(i * _width, 0, _width, CGRectGetHeight(self.frame));
        [item setTitle:titles[i] forState:UIControlStateNormal];
        [item setTitleColor:normal_color forState:UIControlStateNormal];
        [item setTitleColor:select_color forState:UIControlStateSelected];
        item.titleLabel.font = font;
        item.tag = i + 10;
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        
        if (i == 0) {
            self.lineView = [[UIView alloc]init];

            item.selected = YES;
            self.selectedBtn = item;
            if(self.isCart){
                self.lineView = [[UIView alloc]initWithFrame:CGRectMake((item.bounds.size.width - textSize.width/2), CGRectGetHeight(self.frame) - 3, textSize.width, 3)];

            }else{
                self.lineView = [[UIView alloc]initWithFrame:CGRectMake((item.bounds.size.width - textSize.width/2), CGRectGetHeight(self.frame) - 3, textSize.width/2, 3)];
            }
//            if (self.isXinshui) {
            self.lineView.frame = CGRectMake((item.bounds.size.width - textSize.width/2)/2, CGRectGetHeight(self.frame) - 3, textSize.width * 1.5, 3);
//            }else{
//                self.lineView.frame = CGRectMake((item.bounds.size.width - textSize.width/2)/2, CGRectGetHeight(self.frame) - 3, textSize.width/2, 3);
//            }
            if (self.isEqualTextWidth) {
                self.lineView = [[UIView alloc]initWithFrame:CGRectMake((item.bounds.size.width - textSize.width/2), CGRectGetHeight(self.frame) - 3, textSize.width, 3)];
            }
            self.lineView.layer.cornerRadius = 1.5;
            self.lineView.backgroundColor = self.lineColor ? self.lineColor : BASECOLOR;
            self.lineView.layer.masksToBounds = YES;
            
            [self addSubview:self.lineView];
            [self.itemsArray addObject:item];
        }
        else if (i == tempArray.count - 1){
            
//            self.contentSize = CGSizeMake(_orignx, 0);
        }
    }
    
    if (tempArray.count >= 5) {
        self.contentSize = CGSizeMake(_orignx, 0);
    }
    
    if(self.isHongbao){
        UIButton * btn = self.itemsArray[0];
        [self hongbao:btn];
    }
    
}


- (void)clickItem:(UIButton *)tempBtn{
    
    self.selectedBtn.selected = NO;
    self.selectedBtn.backgroundColor = CLEAR;
    tempBtn.selected = YES;
    self.selectedBtn = tempBtn;

//    if(!self.isCart && !self.isXinshui){
//        self.selectedBtn.backgroundColor = [[CPTThemeConfig shareManager] gongshiShaHaoFormuBtnBackgroundColor];
//    }
    self.selectindex = tempBtn.tag - 10;
    CGFloat x = self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width/2 - self.lineView.frame.size.width/2;
    [UIView animateWithDuration:0.1 animations:^{
        CGRect frame = self.lineView.frame;
        frame.origin.x = x;
        self.lineView.frame = frame;
        
        if (x > self.bounds.size.width - self.selectedBtn.bounds.size.width *2){
            
            CGFloat indexCenterOffsetX;
            if (self.selectindex == (tempArray.count -1)) {
                indexCenterOffsetX = self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width - self.frame.size.width;
            } else {
                indexCenterOffsetX = self.selectedBtn.frame.origin.x + self.selectedBtn.frame.size.width - (self.frame.size.width - self.selectedBtn.frame.size.width);
            }
            [self setContentOffset:CGPointMake(indexCenterOffsetX, 0) animated:YES];
        }
        else{
            [self setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        [self bringSubviewToFront:self.lineView];

    }];
    if(self.isHongbao){
        [self hongbao:tempBtn];
    }
    if (self.indexBlock != nil) {
        self.indexBlock(tempArray[tempBtn.tag-10],tempBtn.tag-10);
    }
    
}

- (void)hongbao:(UIButton *)btn{
    if([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White){
        [btn setBackgroundColor:[UIColor hexStringToColor:@"FF8610"]];
        [btn setTitleColor:[UIColor hexStringToColor:@"666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:UIControlStateSelected];

        for(UIButton * item in self.itemsArray){
            if(btn != item){
                [item setBackgroundColor:[UIColor hexStringToColor:@"DDDDDD"]];
                [item setTitleColor:[UIColor hexStringToColor:@"666666"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:UIControlStateSelected];
            }
        }
    }else{
        [btn setBackgroundColor:[UIColor hexStringToColor:@"AC1E2D"]];
        [btn setTitleColor:[UIColor hexStringToColor:@"FFFFFF"] forState:UIControlStateNormal];
        
        for(UIButton * item in self.itemsArray){
            if(btn != item){
                [item setBackgroundColor:[UIColor hexStringToColor:@"DDDDDD"]];
                [item setTitleColor:[UIColor hexStringToColor:@"666666"] forState:UIControlStateNormal];
            }
        }
    }

}

/***********************【属性】***********************/

- (void)setLineColor:(UIColor *)lineColor{
    
    _lineColor = lineColor;
    
    self.lineView.backgroundColor = lineColor;
}

- (void)setLineHeight:(CGFloat)lineHeight{
    CGRect frame = self.lineView.frame;
    frame.size.height = lineHeight;
    frame.origin.y = CGRectGetHeight(self.frame) - lineHeight - 1;
    self.lineView.frame = frame;
}

- (void)setLineCornerRadius:(CGFloat)lineCornerRadius{
    self.lineView.layer.cornerRadius = lineCornerRadius;
}

/***********************【回调】***********************/

- (void)getViewIndex:(IndexBlock)block{
    
    self.indexBlock = block;
}

- (void)setViewIndex:(NSInteger)index{
    
    if (index < 0) {
        
        index = 0;
    }
    
    if (index > tempArray.count - 1) {
        
        index = tempArray.count - 1;
    }
    
    [self setAnimation:index];
}

/***********************【其他】***********************/

- (void)setAnimation:(NSInteger)index{
    
    UIButton *tempBtn = (UIButton *)[self viewWithTag:index+10];
    
    [self clickItem:tempBtn];
}


@end
