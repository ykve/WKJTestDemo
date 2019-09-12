//
//  PublishArticleViewController.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/4.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "PublishArticleViewController.h"
#import "EmotionCollectionViewCell.h"
#import "NSString+IsBlankString.h"
#import <IQKeyboardManager.h>
#import "SixArticleDetailViewController.h"



@interface PublishArticleViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UITextViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *colorsBackView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIView *textviewBackView;

@property (weak, nonatomic) IBOutlet UIButton *color1;
@property (weak, nonatomic) IBOutlet UIButton *color2;
@property (weak, nonatomic) IBOutlet UIButton *color3;
@property (weak, nonatomic) IBOutlet UIButton *color4;
@property (weak, nonatomic) IBOutlet UIButton *color5;
@property (weak, nonatomic) IBOutlet UIButton *color6;
@property (weak, nonatomic) IBOutlet UIButton *color7;
@property (weak, nonatomic) IBOutlet UIButton *color8;

@property (weak, nonatomic) IBOutlet UIButton *lastAllContentBtn;
@property (weak, nonatomic) IBOutlet UIButton *lastTitleBtn;
@property (weak, nonatomic) IBOutlet UIButton *lastOnlyContentBtn;
/*  头像  */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/*  昵称  */
@property (weak, nonatomic) IBOutlet UILabel *nicknameLbl;
/*  新帖发送  */
@property (weak, nonatomic) IBOutlet UIButton  *publishNewArticle;

@property (weak, nonatomic) IBOutlet UIButton *cancelBatn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelBtnHeight;

//表情模型数组
@property (nonatomic, strong) NSMutableArray *emotionModelArray;

/*  记录表情字符  */
@property (nonatomic, copy) NSString *emotionString;

@property (nonatomic,weak) UIButton *lastColorBtn;

@property (nonatomic,weak) UIButton *currentColorBtn;

//选中文字范围
@property(nonatomic) NSRange selectedRange;
/*  正文选中颜色  */
@property (nonatomic, strong) UIColor *selectColor;
/*  标题选中颜色  */
@property (nonatomic, strong) UIColor *titleSelectColor;

/*  记录正文富文本  */
@property (nonatomic, strong) NSMutableAttributedString *attrString;
/*  记录标题富文本  */
//@property (nonatomic, strong) NSMutableAttributedString *titleAttrString;
@property (nonatomic, strong) NSString *articleTitleString;

/*  记录光标位置  */
@property (nonatomic,assign) NSInteger mousePosition;

@property (nonatomic, assign)NSInteger lastPosition;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *publishBtnToBottomHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelBtnToBottomHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *publishBtnHeight;

@property (nonatomic, assign)BOOL isClickAction;

@property (nonatomic, strong) UIColor *lastColor;
//改变的内容字段
@property (nonatomic, copy) NSString *contentChangeStr;
//改变的标题字段
@property (nonatomic, copy) NSString *titleChangeStr;



@end

@implementation PublishArticleViewController

#pragma mark 生命周期

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    if (![self.controlerName isEqualToString:@"new"]) {
        
        NSMutableAttributedString *content =  [[NSMutableAttributedString alloc] initWithData:[self.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        
        self.attrString = content;
        self.textView.attributedText = content;
        self.titleTextField.text = self.articleTitleString;
        //1 加载上期正文与标题 2 加载上期标题 3 加载上期正文
        [self loadLastData:1];
        
    }
    self.view.backgroundColor = [[CPTThemeConfig shareManager] SixRecommendVC_View_BackgroundC];

}
- (void)viewWillAppear:(BOOL)animated{//启用监听
    
    if (IS_IPHONEX) {
        self.cancelBatn.titleEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
        self.publishNewArticle.titleEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
        self.publishBtnToBottomHeight.constant = -45;
        self.cancelBtnToBottomHight.constant = -45;
        self.publishBtnHeight.constant = 65;
        self.cancelBtnHeight.constant = 65;
    }
    
    [self registerForKeyboardNotifications];
}
- (void)viewWillDisappear:(BOOL)animated{//关闭监听
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)registerForKeyboardNotifications{//使用NSNotificationCenter 鍵盤出現時
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWillShown:(NSNotification*)aNotification{
    
    NSDictionary *info = [aNotification userInfo];
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGSize keyboardSize = [value CGRectValue].size;
    
    [UIView animateWithDuration:duration animations:^{//将输入框位置提高
        
        if (IS_IPHONEX) {
            self.colorsBackView.frame = CGRectMake(20, SCREEN_HEIGHT - keyboardSize.height - 10 , self.textView.frame.size.width, 30);
        }else {
            self.colorsBackView.frame = CGRectMake(20, SCREEN_HEIGHT - keyboardSize.height - 30 , self.textView.frame.size.width, 30);
        }
    }];
    
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification *)notification{
    
    @weakify(self)
    [UIView animateWithDuration:1.0 animations:^{//将输入框位置提高
        @strongify(self)
        if ( IS_IPHONEX) {
            
            self.colorsBackView.frame = CGRectMake(20, SCREEN_HEIGHT - self.publishNewArticle.frame.size.height - 30, self.textView.frame.size.width, 30);
            
        }else{
            
            self.colorsBackView.frame = CGRectMake(20, SCREEN_HEIGHT - self.publishNewArticle.frame.size.height - 30 - 20, self.textView.frame.size.width, 30);
            
        }
    }];
}

#pragma mark 选择加载上期数据
- (IBAction)LoadLastContent:(UIButton *)sender {
    
    if (sender.tag == 100) {//加载上期内容以及标题
        
        [self loadLastData:1];
        
    }else if(sender.tag == 200){//加载上期标题
        
        [self loadLastData:2];
        
    }else if(sender.tag == 300){//加载上期正文
        
        [self loadLastData:3];
        
    }else if(sender.tag == 1001){//新帖发送
        
        [self sendNewArticle];
        
    }else if(sender.tag == 1002){//取消
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

#pragma mark 获取上个帖子的数据
- (void)loadLastData : (NSInteger)num{
    
    NSDictionary *para;
    NSString *url;
    
    if ([self.controlerName isEqualToString:@"new"]) {
        para = nil;
        url = @"/lhcSg/getNextLhcXsCommend.json";
    }else{
        
        para = @{@"id" : [NSString stringWithFormat:@"%ld", (long)self.ID]};
//        url = @"/lhcSg/getOneXsCommend.json";
        url = @"/xsTj/getOneXsCommend.json";

        
    }
    
    @weakify(self)
    [WebTools postWithURL:url params:para success:^(BaseData *data) {
        @strongify(self)
        if ([data.status isEqualToString:@"1"]) {
            
            NSDictionary *dataDic = data.data;
            
            if ([data.data isKindOfClass:[NSString class]]) {
                if ([data.data isEqualToString:@""]) {
                    [MBProgressHUD showMessage:@"没有上期数据"];
                    return ;
                }
            }
            
            if ([data.data isKindOfClass:[NSDictionary class]]) {
                if (dataDic.count == 0) {
                    [MBProgressHUD showMessage:@"没有上期数据"];
                    return ;
                }
            }
           
            NSMutableAttributedString *content=  [[NSMutableAttributedString alloc] initWithData:[ data.data[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
            
            [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(0, content.length)];

//            NSString *editTitleStr0 = data.data[@"title"];
////
//            NSMutableAttributedString *title=  [[NSMutableAttributedString alloc] initWithData:[editTitleStr0 dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
////
//            [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0f] range:NSMakeRange(0, title.length)];

            self.attrString = content;
//            self.titleAttrString = title;
            self.articleTitleString = data.data[@"title"];
            
            if (num == 1) {
                self.textView.attributedText = content;
                self.titleTextField.text = self.articleTitleString;
            }else if (num == 2){

                self.titleTextField.text = self.articleTitleString;
                self.textView.text = @"";
            }else if (num == 3){
                self.textView.attributedText = content;
                self.titleTextField.text = @"";
            }
        }
    } failure:^(NSError *error) {

        [MBProgressHUD showError:[NSString stringWithFormat:@"%@", error]];
    }];
}

- (BOOL)isBlankWithString:(NSString *)string{
    NSString *tempStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//清空空格
    
    NSString *terminStr = [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//清楚回车
    
    if (terminStr.length == 0) {
        return YES;
    }else{
        return NO;
    }
    
}

#pragma mark 新帖发送
- (void)sendNewArticle{
    
    if([self.titleTextField.text isEqualToString:@""] || [self isBlankWithString:self.titleTextField.text]) {
        
        [MBProgressHUD showMessage:@"标题不能为空"];
        
        return;
    }
    
    if([self.textView.text isEqualToString:@""] || [self isBlankWithString:self.textView.text]) {
        
        [MBProgressHUD showMessage:@"内容不能为空"];
        
        return;
    }
    
    NSArray *lines = [self.titleTextField.text componentsSeparatedByString:@"\n"];
    
    if (lines.count > 1) {
        [MBProgressHUD showMessage:@"标题不能换行!"];
        return;
    }

    
    [self.attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(0, self.attrString.length)];
    
    NSString *attrContentStr =  [NSString attriToStrWithAttri:self.attrString];
    
    NSString *contentStr1 = [attrContentStr componentsSeparatedByString:@"<style"][1];
    
    NSString *contentStr2 = [NSString stringWithFormat:@"<div><style%@", contentStr1];
    
    NSString *contentStr3 = [contentStr2 componentsSeparatedByString:@"</style>"][0];
    NSString *contentStr4 = [NSString stringWithFormat:@"%@</style >", contentStr3];
    
    NSString *contentStr5 = [contentStr1 componentsSeparatedByString:@"<body>"][1];
    NSString *contentStr6 = [contentStr5 componentsSeparatedByString:@"</body>"][0];
    
    NSString *contentStr9 = [NSString stringWithFormat:@"%@%@</div>",contentStr4, contentStr6];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSString *url ;
    
    if ([self.controlerName isEqualToString:@"new"]) {//新帖发送
        NSDictionary *dic = @{@"content": contentStr9, @"title" : self.articleTitleString};
        
        dict = (NSMutableDictionary *)dic;
        url = @"/lhcSg/addRecommendByAPP.json";
        
        [self.publishNewArticle setUserInteractionEnabled:NO];
        
        @weakify(self)
        [WebTools postWithURL:url params:dict success:^(BaseData *data) {
            
            @strongify(self)
            if ([data.status isEqualToString:@"1"]) {
//                [MBProgressHUD showSuccess:@"发帖成功"];
                
                [self.publishNewArticle setUserInteractionEnabled:YES];

                SixArticleDetailViewController *detail = [[SixArticleDetailViewController alloc]init];
                
                NSString *articleID = data.data;
                
                detail.ID = [articleID integerValue];
                
                detail.isToRootVc = YES;
                
                [self.navigationController pushViewController:detail animated:YES];
                

            }
        } failure:^(NSError *error) {
            @strongify(self)
            [self.publishNewArticle setUserInteractionEnabled:YES];

        }];
        
        
    }else{//修改原贴
        NSDictionary *dic = @{@"content": contentStr9, @"title" : self.articleTitleString, @"id":[NSString stringWithFormat:@"%ld", (long)self.ID]};
        
        
        dict = (NSMutableDictionary *)dic;
        url = @"/lhcSg/updateRecommendByAPP.json";

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改帖子需要重新审核,确定修改吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
      @weakify(self)
        // 2.创建并添加按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self)

            [self.publishNewArticle setUserInteractionEnabled:NO];
            [WebTools postWithURL:url params:dict success:^(BaseData *data) {
                @strongify(self)
                if ([data.status isEqualToString:@"1"]) {
                    
                    [MBProgressHUD showSuccess:@"发帖成功"];
                    
                    [self.publishNewArticle setUserInteractionEnabled:YES];
                    
                    SixArticleDetailViewController *detail = [[SixArticleDetailViewController alloc]init];
                    
                    detail.ID = self.ID;
                    detail.isToRootVc = YES;

                    //   detail.isAttention = model.alreadyFllow;
                    
                    //    detail.isShowHistoryBtn = YES;
                    
                    [self.navigationController pushViewController:detail animated:YES];                }
            } failure:^(NSError *error) {
                @strongify(self)
                [self.publishNewArticle setUserInteractionEnabled:YES];
//                [MBProgressHUD showError:[NSString stringWithFormat:@"%@", error]];
            }];
            
        }];
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:okAction];           // A
        [alertController addAction:cancelAction];       // B
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
}

- (void)chooseTextColor:(UIButton *)sender isClickAction:(BOOL)isClickAction{
    
    if (isClickAction) {
        
        sender.selected = sender.selected ? NO : YES;
        
        sender.layer.borderColor = [BASECOLOR CGColor];
        
        sender.layer.borderWidth = 4;
        
        self.lastColorBtn.layer.borderColor = [[UIColor clearColor] CGColor];
        
        self.lastColorBtn.layer.borderWidth = 0;
        
    }
    
//    UIColor *currentColor = sender.backgroundColor;
    self.selectColor = sender.backgroundColor;

    if ([self.titleTextField isFirstResponder]) {//标题
        
        self.titleSelectColor = self.color1.backgroundColor;
        
    } else if ([self.textView isFirstResponder]){
        
        UITextRange *textRange = self.textView.selectedTextRange;
        
        NSInteger location = [self.textView offsetFromPosition:self.textView.beginningOfDocument toPosition:textRange.start];
        NSInteger length = [self.textView offsetFromPosition:textRange.start toPosition:textRange.end];
        
        NSRange range = NSMakeRange(location, length);
        
        NSMutableAttributedString *attrString = [self.textView.attributedText mutableCopy];
        
        
//        NSRange range2 = NSMakeRange(location - self.contentChangeStr.length , self.contentChangeStr.length);
//
//        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:range2];
        
        if (isClickAction) {
            
//            [attrString addAttribute:NSForegroundColorAttributeName value:self.selectColor range:range];

        }else{
            [attrString addAttribute:NSForegroundColorAttributeName value:self.selectColor range:NSMakeRange(location - self.contentChangeStr.length, self.contentChangeStr.length)];
        
        }
        
        self.attrString = attrString;
        
        self.textView.attributedText = attrString;
        
        self.textView.selectedRange = range;

    }
    
    
    
    self.lastColorBtn = sender;
    self.lastColor = sender.backgroundColor;
    
}

#pragma mark 选择颜色
- (IBAction)chooseTextColor:(UIButton *)sender {
  
    [self chooseTextColor:sender isClickAction:YES];
  
}

#pragma mark textViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    self.textView.font = [UIFont systemFontOfSize:15];
    self.titleTextField.font = [UIFont systemFontOfSize:16];
    
    if (textView.tag == 11) {
        self.titleTextField.placeholder = @"";
    }else{
        self.textView.placeholder = @"";
    }

    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if (textView.tag == 12 && [textView.text isEqualToString:@""]) {
        self.textView.placeholder = @"2000个字以内,选中文字即可编辑颜色";
    }
    if (textView.tag == 11 && [textView.text isEqualToString:@""]) {
        self.titleTextField.placeholder = @"标题:最多可输入50个汉字";
    }
    
    self.isClickAction = YES;
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if (textView.tag == 12) {
        
        self.contentChangeStr = text;
        
    }else{
        
        if ([text isEqualToString:@"\n"]) {
            [MBProgressHUD showError:@"标题不允许换行"];
            return NO;
        }
        
        self.titleChangeStr = text;
    }
    
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.tag == 12) {
        
        if (textView.text.length == 0) {
            self.textView.placeholder = @"2000个字以内,选中文字即可编辑颜色";
        }else{
            self.textView.placeholder = @"";
        }
        
        if (self.textView.text.length >= 4000) {
            
            textView.text = [textView.text substringToIndex:4000];
            
            [MBProgressHUD showMessage:@"最多只能输入2000个汉字"];
            
            return;
        }
        
        [self chooseTextColor:self.lastColorBtn isClickAction:NO];

    }else{
        
        if (textView.text.length == 0) {
            self.titleTextField.placeholder = @"标题:最多可输入50个字符";
        }else{
            self.titleTextField.placeholder = @"";
        }

        if (textView.text.length >= 50) {
            
            textView.text = [textView.text substringToIndex:50];
            
            [MBProgressHUD showMessage:@"标题:最多可输入50个字符"];
            return;
        }

        
        self.articleTitleString = textView.text;
    }
    
}

- (BOOL)isChinese:(NSString *)text
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:text];
}

- (void)setupBackBtn{
    
    @weakify(self)
    self.leftBlock = ^(UIButton *sender) {
        @strongify(self)
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定取消编辑?"
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        // 2.创建并添加按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    };
}


#pragma mark 设置UI
- (void)setupUI{
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    if ([self.controlerName isEqualToString:@"new"]) {
        [self.publishNewArticle setTitle:@"新帖发送" forState:UIControlStateNormal];
    }else{
        [self.publishNewArticle setTitle:@"修改本期" forState:UIControlStateNormal];
    }
    self.scrollView.contentSize = CGSizeMake(0, 1000);
    self.nicknameLbl.text = [Person person].nickname;
    self.titleTextField.layer.cornerRadius = 8;
    self.titleTextField.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 8;
    self.textView.layer.masksToBounds = YES;
    self.textviewBackView.layer.cornerRadius = 8;
    self.textviewBackView.layer.masksToBounds = YES;

    self.lastColorBtn = self.color1;
    self.color1.selected = YES;
    
    self.color1.layer.borderColor = [BASECOLOR CGColor];
    self.color1.layer.borderWidth = 4;
    
    [self.iconImageView sd_setImageWithURL:IMAGEPATH([Person person].heads) placeholderImage:IMAGE(@"touxiang")];
    
    [self setupBtns];
    
    [self setupTextView];
    
    [self setupBackBtn];
    
}

- (void)setupTextView{
    
    self.titlestring = @"心水编辑";
    
    self.textView.placeholder = @"2000个字以内,选中文字即可编辑颜色";
    self.textView.placeholderColor = [UIColor lightGrayColor];
    self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.textView.layer.borderWidth = 1;
    self.textView.delegate = self;
    self.titleTextField.delegate = self;
    
    self.titleTextField.placeholder = @"标题:最多可输入50个汉字";
    self.titleTextField.placeholderColor = [UIColor lightGrayColor];
    self.titleTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.titleTextField.layer.borderWidth = 1;
    self.textView.font = [UIFont systemFontOfSize:14];
    self.titleTextField.font = [UIFont systemFontOfSize:14];
    
    //初始化富文本
    self.attrString = [[NSMutableAttributedString alloc] initWithString:@"" attributes:
                       @{NSForegroundColorAttributeName:[UIColor blackColor]
                         }];
    //初始化富文本
//    self.titleAttrString = [[NSMutableAttributedString alloc] initWithString:@"" attributes:
//                            @{NSForegroundColorAttributeName:[UIColor blackColor]
//                              }];
}


- (void)setupBtns{
    self.color1.backgroundColor = [UIColor blackColor];
    self.color2.backgroundColor = SIXColor(236, 82, 129);
    self.color3.backgroundColor = SIXColor(211, 54, 48);
    self.color4.backgroundColor = SIXColor(65, 148, 136);
    self.color5.backgroundColor = SIXColor(77, 152, 56);
    self.color6.backgroundColor = SIXColor(151, 192, 92);
    self.color7.backgroundColor = SIXColor(241, 156, 56);
    self.color8.backgroundColor = SIXColor(65, 83, 175);
    self.color1.layer.cornerRadius = 2;
    self.color1.layer.masksToBounds = YES;
    self.color2.layer.cornerRadius = 2;
    self.color2.layer.masksToBounds = YES;
    self.color3.layer.cornerRadius = 2;
    self.color3.layer.masksToBounds = YES;
    self.color4.layer.cornerRadius = 2;
    self.color4.layer.masksToBounds = YES;
    self.color5.layer.cornerRadius = 2;
    self.color5.layer.masksToBounds = YES;
    self.color6.layer.cornerRadius = 2;
    self.color6.layer.masksToBounds = YES;
    self.color7.layer.cornerRadius = 2;
    self.color7.layer.masksToBounds = YES;
    self.color8.layer.cornerRadius = 2;
    self.color8.layer.masksToBounds = YES;

    self.lastAllContentBtn.backgroundColor = WHITE;
    [self.lastAllContentBtn setTitleColor:[[CPTThemeConfig shareManager] grayColor333] forState:UIControlStateNormal];
    self.lastAllContentBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.lastAllContentBtn.layer.borderWidth = 1;
    
    self.lastTitleBtn.backgroundColor = WHITE;
    [self.lastTitleBtn setTitleColor:[[CPTThemeConfig shareManager] grayColor333] forState:UIControlStateNormal];
    self.lastTitleBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.lastTitleBtn.layer.borderWidth = 1;
    
    self.lastOnlyContentBtn.backgroundColor = WHITE;
    [self.lastOnlyContentBtn setTitleColor:[[CPTThemeConfig shareManager] grayColor333] forState:UIControlStateNormal];
    self.lastOnlyContentBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.lastOnlyContentBtn.layer.borderWidth = 1;
    
    self.selectColor = self.color1.backgroundColor;
    
    self.publishNewArticle.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];//MAINCOLOR;
    [self.publishNewArticle setTitleColor:[[CPTThemeConfig shareManager] xinshuiBottomViewTitleColor] forState:UIControlStateNormal];
    self.cancelBatn.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];//MAINCOLOR;
    [self.cancelBatn setTitleColor:[[CPTThemeConfig shareManager] xinshuiBottomViewTitleColor] forState:UIControlStateNormal];
    
}


#pragma mark 懒加载
- (NSMutableArray *)emotionModelArray{
    if (!_emotionModelArray) {
        _emotionModelArray = [NSMutableArray arrayWithCapacity:10];
    }
    
    return _emotionModelArray;
}

@end
