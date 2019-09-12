//
//  PostCirCleCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/10/12.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PostCirCleCtrl.h"
#import "ThumbnailView.h"
#import "NavigationVCViewController.h"
@interface PostCirCleCtrl ()<delimgvDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)IQTextView *textView;
@property (nonatomic, strong)NSMutableArray *imgvArray;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIView *addPictrueView;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UILabel *rulelab;
/// 发布限制
@property (nonatomic, assign) BOOL onceMark;
@end

@implementation PostCirCleCtrl

- (void)dealloc
{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _onceMark = NO;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.backgroundColor = WHITE;
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollEnabled = YES;
//    self.scrollView.contentSize = CGSizeMake(0, 1500);
//    self.scrollView.canCancelContentTouches = NO;
    [self.view addSubview:self.scrollView];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishClick) ];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[Tools createButtonWithFrame:CGRectZero andTitle:@"发布" andTitleColor:[[CPTThemeConfig shareManager] CO_NavigationBar_Title] andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(publishClick) andType:UIButtonTypeCustom]];
    
    [self layoutSubviews];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    NavigationVCViewController *nav = (NavigationVCViewController *)self.navigationController;
    
    [nav removepang];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    NavigationVCViewController *nav = (NavigationVCViewController *)self.navigationController;
    
    [nav addpang];
}



-(NSMutableArray *)imgvArray {
    
    if (!_imgvArray) {
        
        _imgvArray = [[NSMutableArray alloc]init];
    }
    return _imgvArray;
}
-(IQTextView *)textView {
    
    if (!_textView) {
        
        _textView = [[IQTextView alloc]init];
        _textView.placeholder = self.reportDic == nil ? @"写点什么，优质内容可以获优先推荐" : @"输入举报内容明细";
        _textView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [self.scrollView addSubview:_textView];
    }
    return _textView;
}

-(UIView *)addPictrueView {
    
    if (!_addPictrueView) {
        
        _addPictrueView = [[UIView alloc]init];
        _addPictrueView.backgroundColor = WHITE;
        
        UIView *linev = [[UIView alloc]init];
        linev.backgroundColor = [UIColor colorWithHex:@"eeeeee"];
        
        UIButton *picBtn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"addpic") andTarget:self andAction:@selector(addPicClick:) andType:UIButtonTypeCustom];
        
        UIButton *ruleBtn = [Tools createButtonWithFrame:CGRectZero andTitle:@"圈规" andTitleColor:[UIColor blackColor] andBackgroundImage:nil andImage:nil andTarget:self andAction:@selector(ruleClick:) andType:UIButtonTypeCustom];
        
        [self.scrollView addSubview:_addPictrueView];
        [_addPictrueView addSubview:linev];
        [_addPictrueView addSubview:picBtn];
        [_addPictrueView addSubview:ruleBtn];
        
        [linev mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.top.equalTo(_addPictrueView);
            make.height.equalTo(@1);
        }];
        [picBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_addPictrueView).offset(15);
            make.centerY.equalTo(_addPictrueView);
        }];
        [ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(_addPictrueView).offset(-15);
            make.centerY.equalTo(_addPictrueView);
        }];
        
    }
    return _addPictrueView;
}

-(UILabel *)rulelab {
    
    if (!_rulelab) {
        
        NSString *rulestr = @"圈子禁止以下内容：\n1、涉及政治军事、色情淫秽、封建迷信、暴力教唆、地域宗教种族歧视等损害公众利益，危害论坛安全的话题。\n2、与论坛主题无关或恶意灌水、刷屏的。\n3、侮辱或诽谤他人，有人身攻击行为的。\n4、未经许可的商业宣传或广告信息（含QQ群、MSN群外部群组等）。\n5、含有相关法律法规禁止的其他内容的。\n如有违规，论坛版主有权力进行转、关、删帖处理，情节严重者将被取消阅读资格。";
        
        _rulelab = [Tools createLableWithFrame:CGRectZero andTitle:rulestr andfont:FONT(15) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
        [self.scrollView addSubview:_rulelab];
        _rulelab.numberOfLines = 0;
        [_rulelab sizeToFit];
    }
    return _rulelab;
}
-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 0;
        
        layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = WHITE;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        //注册
        [_collectionView registerClass:[ThumbnailView class] forCellWithReuseIdentifier:RJCellIdentifier];
        [self.scrollView addSubview:_collectionView];
    }
    
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imgvArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ThumbnailView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    UIImage *img = [self.imgvArray objectAtIndex:indexPath.item];
    
    cell.iconimgv.image = img;
    
    cell.index = indexPath.item;
    
    cell.delegate = self;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 5*10)/4, (SCREEN_WIDTH - 5*10)/4);
}

-(void)layoutSubviews {
    @weakify(self)
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.top.right.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.equalTo(@150);
    }];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.textView);
        make.top.equalTo(self.textView.mas_bottom);
        make.height.equalTo(@((self.imgvArray.count + 3)/4 * (SCREEN_WIDTH - 5*10)/4 + 20));
    }];
    
    [self.addPictrueView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.equalTo(self.scrollView);
        make.top.equalTo(self.collectionView.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    [self.rulelab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(_addPictrueView).offset(15);
        make.right.equalTo(_addPictrueView).offset(-15);
        make.top.equalTo(_addPictrueView.mas_bottom).offset(8);
        make.height.mas_equalTo(self.rulelab.mas_height);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.edges.mas_equalTo(self.view);
        // 让scrollview的contentSize随着内容的增多而变化
        make.bottom.mas_equalTo(self.rulelab.mas_bottom).offset(20);
    }];
}

-(void)delegeimageWithindex:(NSInteger)index With:(UIView *)Thumbnail {
    
    [self.imgvArray removeObjectAtIndex:index];
    
    [self.collectionView reloadData];
    
    [self layoutSubviews];
}

-(void)addPicClick:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    @weakify(self)
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        [[Person person] upimageWithcount:9-self.imgvArray.count WithController:self success:^(NSArray<UIImage *> *photos) {
            @strongify(self)
            [self.imgvArray addObjectsFromArray:photos];
            
            [self.collectionView reloadData];
            
            [self layoutSubviews];
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        [[Person person] takePhotoWithController:self WithBlock:^(UIImage *image) {
            @strongify(self)
            [self.imgvArray addObject:image];
            
            [self.collectionView reloadData];
            
            [self layoutSubviews];
        }];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)updataimage:(NSArray<UIImage *> *)images success:(void (^)(NSArray *imgurls))success {
    @weakify(self)
    [WebTools rj_upImage:images code:self.reportDic != nil ? @"report" : @"bbs" progress:^(NSProgress *progress) {
    } success:^(BaseData *data) {
        success(data.data);
    } failure:^(NSError *error) {
        @strongify(self)
        self.onceMark = NO;
    }];
}

-(void)ruleClick:(UIButton *)sender {
    
    
}

-(void)publishClick{
    
    
    if ([Tools isEmptyOrNull:self.textView.text]) {
        [MBProgressHUD showError:@"请输入内容"];
        return;
    }
    
    [self.view endEditing:YES];
    
    if (self.imgvArray.count > 0) {
        
        if (self.onceMark) {
            return;
        }
        self.onceMark = YES;
        @weakify(self)
        [self updataimage:self.imgvArray success:^(NSArray *imgurls) {
            self.onceMark = NO;
            NSMutableString *mstring = [[NSMutableString alloc]init];
            
            for (NSString *str in imgurls) {
                if (mstring.length) {
                    [mstring appendString:@","];
                }
                [mstring appendString:str];
            }
            @strongify(self)
            if (self.reportDic) {
                [self reportWithimage:mstring];
            } else{
                [self postWithimages:mstring];
            }
            
        }];
    } else {
       
        if (self.reportDic) {
            [self reportWithimage:nil];
        } else {
            [MBProgressHUD showError:@"请上传图片"];
        }
        
    }
}

-(void)postWithimages:(NSString *)images {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.textView.text forKey:@"content"];
    [dic setValue:images forKey:@"image"];
    
    @weakify(self)
    [WebTools postWithURL:@"/circle/createPost" params:dic success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)
            if (self.updatacircleBlock) {
                
                self.updatacircleBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } failure:^(NSError *error) {
        
        
    }];
}

-(void)reportWithimage:(NSString *)images {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@(self.memberId) forKey:@"memberId"];
    [dic setValue:self.reportDic[@"id"] forKey:@"typeId"];
    [dic setValue:self.textView.text forKey:@"comment"];
    [dic setValue:images forKey:@"proofImage"];
    @weakify(self)
    [WebTools postWithURL:@"/circle/reportPost" params:dic success:^(BaseData *data) {
        
        [MBProgressHUD showSuccess:data.info finish:^{
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
