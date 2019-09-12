//
//  FootballDetailHeaderView.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/27.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "FootballDetailHeaderView.h"

@implementation FootballDetailHeaderView
- (void)awakeFromNib{
    [super awakeFromNib];
    for (id subview in self.contentWebVeiw.subviews){
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]){
            ((UIScrollView *)subview).bounces = NO;
            ((UIScrollView *)subview).scrollEnabled = NO;
        }
    }
    
    [self.webBgView addSubview:self.contentWebVeiw];
    @weakify(self)
             [self.contentWebVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
                 @strongify(self)
                 make.top.left.right.bottom.equalTo(self.webBgView);
             }];
    
}
- (void)setDataWithModel:(FootballDetailModel *)model{
    NSArray *retArr = [model.number componentsSeparatedByString:@","];
    if(retArr.count>1){
        CGFloat space = (SCREEN_WIDTH-30)/10 -28;
        for(int i=0;i<retArr.count;i++){
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15+(28+space)*i, 11, 28, 28)];
            lab.layer.cornerRadius = 3;
            lab.layer.masksToBounds = YES;
            lab.textColor = [UIColor whiteColor];
            lab.font = [UIFont systemFontOfSize:13];
            lab.textAlignment = NSTextAlignmentCenter;
            NSString *num = retArr[i];
            if(num.integerValue == 0){
                lab.text = @"红";
            }else if(num.integerValue == 1){
                lab.text = @"黑";
            }else if(num.integerValue == 2){
                lab.text = @"1/2";
            }
            
            if([lab.text isEqualToString: @"红"]){
                lab.backgroundColor = [UIColor redColor];
            }else if ([lab.text isEqualToString:@"黑"]){
                lab.backgroundColor = [UIColor blackColor];
            }else if ([lab.text isEqualToString: @"1/2"]){
                lab.backgroundColor = [UIColor colorWithHex:@"f78826"];
            }
            [self.headView addSubview:lab];
        }
    }
//    if()
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size:15px;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "for(var p in  $img){\n"
                            " $img[p].style.width = '100%%';\n"
                            "$img[p].style.height ='auto'\n"
                            "}\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>", model.content];

//    [self.contentWebVeiw loadFileURL:[NSURL URLWithString:@"http://www.baidu.com"] allowingReadAccessToURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.contentWebVeiw loadHTMLString:htmlString baseURL:nil];
//    _titleLabel.attributedText = model.htmlTitle;
//    _contentLabel.attributedText = model.htmlContent;
}
- (WKWebView *)contentWebVeiw{
    if (!_contentWebVeiw) {
        _contentWebVeiw = [[WKWebView alloc] init];
        _contentWebVeiw.backgroundColor = [UIColor redColor];
                [_contentWebVeiw setUserInteractionEnabled:NO];
        
    }
    
    return _contentWebVeiw;
}


@end
