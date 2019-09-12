//
//  ListNoticeView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/12/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "ListNoticeView.h"
#import "AppDelegate.h"
#import "MessageModel.h"

@interface ListNoticeView()
@property(weak,nonatomic)IBOutlet UIImageView* imageView;
@property(weak,nonatomic)IBOutlet UIView* backView;
@property(assign,nonatomic) NSInteger index;

//@property (nonatomic,weak) UILabel *contentLbl;



@property (strong, nonatomic) UIControl *overlayView;

@end

@implementation ListNoticeView

-(void)awakeFromNib {
    
    [super awakeFromNib];
    self.index = 0;
    self.backgroundColor = CLEAR;
//    self.backView.backgroundColor = [UIColor colorWithHex:@"000000" Withalpha:0.7];
    self.imageView.center = self.center;
//    self.titleLabel.center = CGPointMake(self.center.x, self.center.y-281/2+25);
//    self.layer.cornerRadius = 8;
//    self.layer.masksToBounds = YES;
    _overlayView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overlayView.backgroundColor =[UIColor colorWithHex:@"000000" Withalpha:0.7];
        
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = CLEAR;
    self.titleLabel.font = FONT(18);
    self.titleLabel.textColor = WHITE;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_top).offset(50.);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
//    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x+35., self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+15, 160, 105)];
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = CLEAR;
//    self.textView.textAlignment = NSTextAlignmentCenter;
    self.textView.textColor = WHITE;
    
    self.textView.font = FONT(12);
    [self addSubview:self.textView];
    [self.textView setEditable:NO];
    
//   UILabel *contentLbl = [[UILabel alloc] initWithFrame:self.textView.bounds];
//    [self addSubview:contentLbl];
//    self.contentLbl = contentLbl;
//    self.contentLbl.backgroundColor = [UIColor redColor];
    
//    self.textView.backgroundColor = [UIColor blueColor];
    
//    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self.textView);
//    }];

//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(15.);
//        make.width.offset(160.);
//    }];


//    if (SCREEN_WIDTH < 375) {
//        
//        self.title_height.constant = 45;
//    }
//    else {
//        self.title_height.constant = 67;
//    }
}

-(void)uiSet{
 

}

//- (void)contentSizeToFit{
//    //先判断一下有没有文字（没文字就没必要设置居中了）
//    if([self.textView.text length]>0)
//    {
//        //textView的contentSize属性
//        CGSize contentSize = self.textView.contentSize;
//        //textView的内边距属性
//        UIEdgeInsets offset;
//        CGSize newSize = contentSize;
//
//        //如果文字内容高度没有超过textView的高度
//        if(contentSize.height <= self.textView.frame.size.height)
//        {
//            //textView的高度减去文字高度除以2就是Y方向的偏移量，也就是textView的上内边距
//            CGFloat offsetY = (self.textView.frame.size.height - contentSize.height)/2;
//            offset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
//        }
//        else          //如果文字高度超出textView的高度
//        {
//            newSize = self.textView.frame.size;
//            offset = UIEdgeInsetsZero;
//            CGFloat fontSize = 18;
//
//            //通过一个while循环，设置textView的文字大小，使内容不超过整个textView的高度（这个根据需要可以自己设置）
//            while (contentSize.height > self.textView.frame.size.height)
//            {
//                [self.textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:fontSize--]];
//                contentSize = self.textView.contentSize;
//            }
//            newSize = contentSize;
//        }
//
//        //根据前面计算设置textView的ContentSize和Y方向偏移量
//        [self.textView setContentSize:newSize];
//        [self.textView setContentInset:offset];
//
//    }
//}


//+(UpdateVersionView *)update{
//
//    UpdateVersionView *version = [[[NSBundle mainBundle]loadNibNamed:@"UpdateVersionView" owner:self options:nil]firstObject];
//
//
//    version.frame = CGRectMake(30, -(SCREEN_WIDTH - 60) * 1.714, (SCREEN_WIDTH - 60), (SCREEN_WIDTH - 60)*1.714);
//
//    return version;
//}

-(void)show{
    if(self.index>=self.models.count){return;}
//    [[AppDelegate shareapp].window addSubview:self];
    UIWindow *keywindw = [UIApplication sharedApplication].keyWindow;
    self.alpha = 0.7;

    [keywindw addSubview:self.overlayView];
    [keywindw addSubview:self];

//    CGRect frame = self.frame;
    MessageModel * m = self.models[self.index];
    self.textView.text = m.message;
    self.titleLabel.text = m.title;
    self.textView.textAlignment = NSTextAlignmentLeft;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.5;// 字体的行间距

    //    paragraphStyle.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName : WHITE

                                 };
    self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.textView.text attributes:attributes];

//    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//
//        paragraphStyle1.lineSpacing = 2;  // 段落高度
    
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:m.message];
    
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, str.length)];
//    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, str.length)];
//    [str addAttribute:NSForegroundColorAttributeName value:WHITE range:NSMakeRange(0, str.length)];
//
//
//    self.contentLbl.attributedText = str;
//    self.contentLbl.numberOfLines = 0;

//    frame.origin.y = keywindw.center.y - frame.size.height/2;
//
    [UIView animateWithDuration:0.35 animations:^{
//
//        self.frame = frame;
//
////        [self layoutIfNeeded];
//
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        if(self.index==0){
            self.textView.frame = CGRectMake(self.titleLabel.frame.origin.x+30.,self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+10, 160, 180);
            self.textView.centerX = self.titleLabel.centerX;
        }
        self.index = self.index +1;

    }];
}

-(void)dismiss{

//    CGRect frame = self.frame;
//
//    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
//
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0.0;
//
//        self.frame = frame;
//
////        [self layoutIfNeeded];
//
    } completion:^(BOOL finished) {

        [self removeFromSuperview];
        [self.overlayView removeFromSuperview];
        [self show];
//        [self.overlayView removeFromSuperview];
    }];
}


- (IBAction)cancel:(UIButton *)sender {
    
    [self dismiss];
}

- (IBAction)updateView:(id)sender {
    
//    if (self.updateBlock) {
//
//        self.updateBlock();
//    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
