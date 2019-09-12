//
//  SixArticleDetailHeaderView.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/30.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "SixArticleDetailHeaderView.h"
#import <WebKit/WebKit.h>

@interface SixArticleDetailHeaderView ()
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daShenRightMargin;
@property (weak, nonatomic) IBOutlet UILabel *fansLbl;
@property (nonatomic, strong) WKWebViewConfiguration *webConfig;
@property (weak, nonatomic) IBOutlet UIView *replyViseableView;
@property (weak, nonatomic) IBOutlet UIImageView *lockImage;

@property (weak, nonatomic) IBOutlet UIButton *remarkBtn;
@property (weak, nonatomic) IBOutlet UILabel *hideLbl;

@end

@implementation SixArticleDetailHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.qrCodeImgViewHeight.constant = 0;
    self.iconImgView.layer.masksToBounds = YES;
    self.iconImgView.layer.cornerRadius = 13;
    self.titleLbl.textColor = [UIColor blackColor];
    self.titleLbl.font =[UIFont systemFontOfSize:17];
    self.replyViseableView.hidden = YES;
    
    self.replyViseableView.backgroundColor = [UIColor colorWithHex:@"222830"];
    self.hideLbl.textColor = [UIColor colorWithHex:@"8C6167"];
    self.remarkBtn.backgroundColor = [UIColor colorWithHex:@"0076A3"];
    self.remarkBtn.layer.masksToBounds = YES;
    self.remarkBtn.layer.cornerRadius = 2;
    
    self.editBtn.backgroundColor = MAINCOLOR;
    [self.editBtn setTitleColor:BASECOLOR forState:UIControlStateNormal];
    self.editBtn.layer.masksToBounds = YES;
    self.editBtn.layer.cornerRadius = 5;
    //    self.titleLbl.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;
    //    self.titleLbl.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
    for (id subview in self.contentWebVeiw.subviews){
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]){
            ((UIScrollView *)subview).bounces = NO;
            ((UIScrollView *)subview).scrollEnabled = NO;
        }
    }
    
    [self.WKWebViewBackView addSubview:self.contentWebVeiw];
    [self.followBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.followBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [self.followBtn setTitleColor:WHITE forState:UIControlStateNormal];
    [self.followBtn setTitleColor:[[CPTThemeConfig shareManager] xinshuiFollowBtnBackground] forState:UIControlStateSelected];
    self.followBtn.backgroundColor = [[CPTThemeConfig shareManager] xinshuiFollowBtnBackground];
    
    self.followBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.followBtn.layer.cornerRadius = 5;
    self.followBtn.layer.masksToBounds = YES;
    
    [self.followBtn addTarget:self action:@selector(didClickAttentionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.remarkLbl.textColor = [UIColor colorWithHex:@"4D4D4D"];
    self.remarkBackView.backgroundColor = [UIColor colorWithHex:@"EFEEF3"];


}
- (IBAction)clickEditBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(skipToEditVc)]) {
        [self.delegate skipToEditVc];
    }
}

- (void)didClickAttentionBtn:(UIButton *)btn {
    
    if (!self.model) {
        return;
    }
    
    if ([btn.titleLabel.text isEqualToString:@"编辑"]) {
        if ([self.delegate respondsToSelector:@selector(skipToEditVc)]) {
            [self.delegate skipToEditVc];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(attentionSomeone:)]) {
            [self.delegate attentionSomeone:btn];
        }
    }
    
}

- (IBAction)clickRemarkBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(replyArticle)]) {
        [self.delegate replyArticle];
    }
}


- (void)setModel:(RecommendDetailModel *)model {
    _model = model;
   
    [self.iconImgView sd_setImageWithURL:IMAGEPATH(model.heads) placeholderImage:IMAGE(@"touxiang")];
    
    if ([model.parentMemberId isEqualToString:[[Person person] uid]]) {
        [self.followBtn setTitle:@"编辑" forState:UIControlStateNormal];
    } else {
        [self.followBtn setTitle:@"关注" forState:UIControlStateNormal];
        [self.followBtn setTitle:@"已关注" forState:UIControlStateSelected];
    }
    self.nicknameLbl.text = [NSString stringWithFormat:@"%@",model.referrer];
    self.fansLbl.text = [NSString stringWithFormat:@"%ld粉丝", (long)model.fansNumber];
    
    if ([model.type isEqualToString:@"大神"]) {
        
        self.touxianImgView.image = IMAGE(@"大神");
    }
    else if ([model.type isEqualToString:@"大师"]) {
        
        self.touxianImgView.image = IMAGE(@"大师");
    }
    else if ([model.type isEqualToString:@"彩帝"]) {
        
        self.touxianImgView.image = IMAGE(@"彩帝");
    }
    else if ([model.type isEqualToString:@"高手"]) {
        
        self.touxianImgView.image = IMAGE(@"高手");
    }else{
         self.touxianImgView.image = IMAGE(@"");
        self.dashenImgWidth.constant = 0;
    }
    
    if ([model.locked isEqualToString:@"1"] && [model.isOwn isEqualToString:@"1"]) {
        self.editBtn.backgroundColor = [UIColor lightGrayColor];
        self.editBtn.enabled = NO;
        [self.editBtn setTitle:@"已锁帖" forState:UIControlStateNormal];
        [self.editBtn setTitleColor:WHITE forState:UIControlStateNormal];
        self.editBtn.backgroundColor = [[CPTThemeConfig shareManager] xinshuiFollowBtnBackground];
        self.editBtn.hidden = NO;

    }else if ([model.locked isEqualToString:@"0"] && [model.isOwn isEqualToString:@"1"]){
        self.editBtn.backgroundColor = [[CPTThemeConfig shareManager] xinshuiFollowBtnBackground];
        [self.editBtn setTitleColor:WHITE forState:UIControlStateNormal];
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        self.editBtn.hidden = NO;
    }else{
        self.editBtn.hidden = YES;
    }
    
    
    if ([model.isOwn isEqualToString:@"1"]) {
        self.followBtn.hidden = YES;
    }else{
        self.followBtn.hidden = NO;
    }
    
//    NSMutableAttributedString *titleStr= [[NSMutableAttributedString alloc] initWithData:[model.title dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    
//    
//    [titleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17 weight:UIFontWeightHeavy] range:NSMakeRange(0, titleStr.length)];
    
//    self.titleLbl.attributedText = titleStr;
    self.titleLbl.text = model.title;
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-size:40px;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "for(var p in  $img){\n"
                            " $img[p].style.width = '110%%';\n"
                            "$img[p].style.height ='auto'\n"
                            "}\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>", model.content];
    
    if (model.replyViewFlag) {
        self.contentWebVeiw.hidden = YES;
        self.replyViseableView.hidden = NO;
    }else{
        self.contentWebVeiw.hidden = NO;
        self.replyViseableView.hidden = YES;
        [self.contentWebVeiw loadHTMLString:htmlString baseURL:nil];
    }
}

- (WKWebView *)contentWebVeiw{
    if (!_contentWebVeiw) {
        _contentWebVeiw = [[WKWebView alloc] initWithFrame:self.WKWebViewBackView.bounds];
//        [_contentWebVeiw setUserInteractionEnabled:NO];

    }
    
    return _contentWebVeiw;
}


@end
