//
//  TagView.m
//  CustomTag
//
//  Created by za4tech on 2017/12/15.
//  Copyright © 2017年 Junior. All rights reserved.
//

#import "TagView.h"
#define SCREEN_WIDTH      self.bounds.size.width
@implementation TagView

-(void)setArr:(NSArray<CartTypeModel *> *)arr{
    
    _arr = arr;
    CGFloat marginX = 12;
    CGFloat marginY = 8;
    CGFloat height = 35;
    UIButton * markBtn;
    
    for (UIButton *btn in self.subviews) {
        
        [btn removeFromSuperview];
    }
    for (int i = 0; i < _arr.count; i++) {
        
        CGFloat width =  0;
        
        CartTypeModel *model = _arr[i];
        
        width = [self calculateString:model.name Width:13] + 20;
        
        UIButton *tagBtn = [self viewWithTag:100 + i];
        
        if (tagBtn == nil) {
            
            tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            tagBtn.tag = 100 + i;
            
            [self addSubview:tagBtn];
        }
        
        if (!markBtn) {
            tagBtn.frame = CGRectMake(marginX, marginY, width, height);
        }else{
            if (markBtn.frame.origin.x + markBtn.frame.size.width + marginX + width + marginX > SCREEN_WIDTH) {
                
                tagBtn.frame = CGRectMake(marginX, markBtn.frame.origin.y + markBtn.frame.size.height + marginY, width, height);
            }else{
                tagBtn.frame = CGRectMake(markBtn.frame.origin.x + markBtn.frame.size.width + marginX, markBtn.frame.origin.y, width, height);
            }
        }
        [tagBtn setTitle:model.name forState:UIControlStateNormal];
        
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [tagBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [self makeCornerRadius:5 borderColor:[UIColor lightGrayColor] layer:tagBtn.layer borderWidth:.8];
        
        markBtn = tagBtn;
        
        [tagBtn addTarget:self action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];

        if (model.selected) {
            
            [self clickTo:tagBtn];
        }
    }
    CGRect rect = self.frame;
    rect.size.height = markBtn.frame.origin.y + markBtn.frame.size.height + marginY;
    self.frame = rect;
}


-(void)clickTo:(UIButton *)sender
{
    for (UIButton *btn in self.subviews) {
        
        btn.backgroundColor = CLEAR;
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        CartTypeModel *model = [self.arr objectAtIndex:btn.tag-100];
        
        model.selected = NO;
    }
    
    [sender setTitleColor:WHITE forState:UIControlStateNormal];
    
    sender.backgroundColor = kColor(245, 67, 18);
    
    CartTypeModel *model = [self.arr objectAtIndex:sender.tag-100];
    
    model.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(handleSelectWith:WithView:)]) {
        
        [self.delegate handleSelectWith:model WithView:self];
    }
}



-(void)makeCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor layer:(CALayer *)layer borderWidth:(CGFloat)borderWidth
{
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;
    layer.borderColor = borderColor.CGColor;
    layer.borderWidth = borderWidth;
}

-(CGFloat)calculateString:(NSString *)str Width:(NSInteger)font
{
    CGSize size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}

@end
