//
//  LYYTextView.m
//  baisibudejie
//
//  Created by Xiaoyue on 16/6/6.
//  Copyright © 2016年 李运洋. All rights reserved.
//

#import "LYYTextView.h"

@implementation LYYTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        //监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:nil];
        
        //设置默认颜色
        
        self.placeholderColor = [UIColor grayColor];
        
        self.font = [UIFont systemFontOfSize:14];
        //一直可以往下拖拽
        self.alwaysBounceVertical = YES;
        
        
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)textDidChanged
{
    [self setNeedsDisplay];
}



/**
 *  绘制占位文字(每次调用draw之前 会把之前的擦掉);
 */
- (void)drawRect:(CGRect)rect {
   
    //如果有文字就直接返回 不会只占位文字
    if (self.hasText) return;
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2*rect.origin.x;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    [self.placeholder drawInRect:rect withAttributes:attrs];
    
    

}

//setter 方法

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
    
    
}

@end
