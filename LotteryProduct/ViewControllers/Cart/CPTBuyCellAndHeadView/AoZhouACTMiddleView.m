//
//  AoZhouACTMiddleView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/5/3.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "AoZhouACTMiddleView.h"
#import "AoZhouNewsLongHuCollectionViewCell.h"
#import "UIImage+color.h"

@interface AoZhouACTMiddleView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIScrollView *scrollView;


@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIButton *lastBtn;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberBtns;

@property (weak, nonatomic) IBOutlet UIButton *changeModel;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (nonatomic, strong) UILabel *lastLbl;
//记录长龙个数
@property (nonatomic, assign)int longNum;
//记录长龙的最小 X
@property (nonatomic, assign)CGFloat longMinX;
//记录"和"前面的一个结果
@property (nonatomic, copy) NSString *preHeStr;
//记录最大的 x 值
@property (nonatomic, assign)CGFloat maxXValue;
//记录上一个长龙所有 label
@property (nonatomic, strong)NSMutableArray *lastChangLongLblArray;
@property (nonatomic, strong)NSMutableArray *currentChangLongLblArray;

@property (nonatomic, assign)CGFloat twoChangLongPoint;
//记录当前长龙最低下第一个 label
@property (nonatomic, strong)UILabel *changLongBottomLbl;

@property (weak, nonatomic) IBOutlet UIButton *bigOrSmallBtn;
@property (weak, nonatomic) IBOutlet UIButton *danOrShuangBtn;
@property (weak, nonatomic) IBOutlet UIButton *wuXingBtn;

@property (nonatomic, copy) NSString *bigOrSmallStr;
@property (nonatomic, copy) NSString *danShuangStr;
@property (nonatomic, copy) NSString *wuxingStr;


@property (nonatomic, assign)int num;


@end

@implementation AoZhouACTMiddleView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bigOrSmallBtn.selected = YES;
    self.lastBtn = self.bigOrSmallBtn;
    self.twoChangLongPoint = 0;
    self.topView.backgroundColor = [[CPTThemeConfig shareManager] AoZhouScrollviewBackgroundColor];//[UIColor colorWithHex:@"1D1E23"];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AoZhouNewsLongHuCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AoZhouNewsLongHuCollectionViewCellID"];
    self.changeModel.backgroundColor = [[CPTThemeConfig shareManager] AoZhouLotteryBtnNormalBackgroundColor];
    [self.changeModel setTitleColor:[[CPTThemeConfig shareManager] AoZhouLotterySwitchBtnTitleColor] forState:UIControlStateNormal];
    [self.changeModel setImage:IMAGE([[CPTThemeConfig shareManager] AoZhouLotterySwitchBtnImage]) forState:UIControlStateNormal];
    self.changeModel.layer.masksToBounds = YES;
    self.changeModel.layer.cornerRadius = 3;
    self.line.backgroundColor = [[CPTThemeConfig shareManager] AoZhouLotterySeperatorLineColor];

    for (UIButton *btn in self.numberBtns) {
        [btn setTitleColor:[[CPTThemeConfig shareManager] AoZhouLotteryBtnTitleNormalColor] forState:UIControlStateNormal];
        [btn setTitleColor:WHITE forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[[CPTThemeConfig shareManager] AoZhouMiddleBtnSelectBackgroundColor] size:btn.size] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[[CPTThemeConfig shareManager] AoZhouMiddleBtnNormalBackgroundColor] size:btn.size] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3;
    }

    self.num = 50;
    [self addSubview:self.collectionView];
    @weakify(self)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
//    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwip)];
//    [rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [self.collectionView addGestureRecognizer:rightRecognizer];
    
//    UISwipeGestureRecognizer *leftrRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwip)];
//    [leftrRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [self.collectionView addGestureRecognizer:leftrRecognizer];
    
    self.resultStr = @"";
    self.bigOrSmallStr = @"";
    self.danShuangStr = @"";
    self.wuxingStr = @"";
    
    [self initdataBigOrSmall];
    [self initdataWuXing];
    [self initdataDanShuang];
    
}
//大小
- (void)initdataBigOrSmall{
    
    @weakify(self)
    [WebTools postWithURL:@"/ausactSg/bigOrSmall.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        NSArray *dataArray = data.data;
        
        for (NSDictionary *dic in dataArray) {
            self.bigOrSmallStr = [NSString stringWithFormat:@"%@%@", self.bigOrSmallStr, dic[@"number"]];
        }
        self.bigOrSmallStr = [Tools deleteBlank:self.bigOrSmallStr];
        self.resultStr = [Tools deleteBlankAndEnter:self.bigOrSmallStr];
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

//单双
- (void)initdataDanShuang{
    
    @weakify(self)
    [WebTools postWithURL:@"/ausactSg/singleAndDouble.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        NSArray *dataArray = data.data;
        
        if (dataArray.count > 0) {
            self.danShuangStr = @"";
        }else{
            return;
        }
        
        for (NSDictionary *dic in dataArray) {
            self.danShuangStr = [NSString stringWithFormat:@"%@%@", self.danShuangStr, dic[@"number"]];
        }
        self.danShuangStr = [Tools deleteBlank:self.danShuangStr];
//        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

//单双
- (void)initdataWuXing{
    
    @weakify(self)
    [WebTools postWithURL:@"/ausactSg/fiveElements.json" params:nil success:^(BaseData *data) {
        @strongify(self)
        if (![data.status isEqualToString:@"1"]) {
            return ;
        }
        NSArray *dataArray = data.data;
        
        if (dataArray.count > 0) {
            self.wuxingStr = @"";
        }else{
            return;
        }
        
        for (NSDictionary *dic in dataArray) {
            self.wuxingStr = [NSString stringWithFormat:@"%@%@", self.wuxingStr, dic[@"number"]];
        }
        self.wuxingStr = [Tools deleteBlank:self.wuxingStr];
//        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

//- (void)rightSwip{
//
//    [self.collectionView reloadData];
//}
//
//- (void)leftSwip{
//
//    [self.collectionView reloadData];
//
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    CGPoint point = [scrollView.panGestureRecognizer translationInView:self.collectionView];
//
//    if (self.collectionView.hidden == NO) {
//        if (point.x > 120) {
//            MBLog(@"右边");
//            [self.collectionView reloadData];
//        } else if(point.x < - 120) {
//            MBLog(@"左边");
//            [self.collectionView reloadData];
//        }
//    }else{
//
//    }
//
//}

- (IBAction)buttonClick:(UIButton *)sender {//10: 大小  20 单双 30 五行 40 切换
    
    if (sender.tag ==  10 || sender.tag ==  20 || sender.tag ==  30) {
        self.lastBtn.selected = NO;
        sender.selected = YES;
        self.selectBtn = sender;
        
        if (sender.tag == 10) {
            self.resultStr = self.bigOrSmallStr;
        } else if(sender.tag == 20){
            self.resultStr = self.danShuangStr;
        }else if(sender.tag == 30){
            self.resultStr = self.wuxingStr;
        }
        self.lastBtn = sender;
        
        if (self.collectionView.hidden == YES) {
            self.maxXValue = 0;
            [self creatItems];
            
        }else{
            [self.collectionView reloadData];
        }
    }else if(sender.tag == 40){
        self.changeModel.selected = sender.selected ? NO : YES;
        if (self.changeModel.selected) {
            self.collectionView.hidden = YES;
            self.scrollView.hidden = NO;
            [self addSubview:self.scrollView];
            
//            if (self.scrollView.subviews.count < 10) {
                [self creatItems];
//            }
        }else{

            self.collectionView.hidden = NO;
            self.scrollView.hidden = YES;
            [self.collectionView reloadData];
        }
        
    }
    
}

- (void)creatItems{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < self.resultStr.length; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 2;
        label.textColor = WHITE;
        label.font = FONT(10);
        label.textAlignment = NSTextAlignmentCenter;
        NSString *str = [self.resultStr substringWithRange:NSMakeRange(i, 1)];
        NSString *lasttStr ;
        if (i >= 1) {
            lasttStr = [self.resultStr substringWithRange:NSMakeRange(i - 1, 1)];
        }
        NSString *lastTwoStr;
        if (i >= 2) {
            lastTwoStr = [self.resultStr substringWithRange:NSMakeRange(i - 2, 1)];
        }
        if (self.bigOrSmallBtn.selected) {
            if ([str isEqualToString:@"和"] && ![lasttStr isEqualToString:@"和"]) {
                self.preHeStr = lasttStr;
            }
        }

        label.text = str;
        
        if ([str isEqualToString:@"大"]) {
            label.backgroundColor = [UIColor colorWithHex:@"E82A40"];
        }else if([str isEqualToString:@"小"]){
            label.backgroundColor = [UIColor colorWithHex:@"1A6BFF"];
        }else if([str isEqualToString:@"和"]){
            label.backgroundColor = [UIColor colorWithHex:@"1D8D18"];
        }else if([str isEqualToString:@"金"]){
            label.backgroundColor = [UIColor colorWithHex:@"C77F1B"];
        }else if([str isEqualToString:@"木"]){
            label.backgroundColor = [UIColor colorWithHex:@"267852"];
        }else if([str isEqualToString:@"水"]){
            label.backgroundColor = [UIColor colorWithHex:@"18698C"];
        }else if([str isEqualToString:@"火"]){
            label.backgroundColor = [UIColor colorWithHex:@"9B0F11"];
        }else if([str isEqualToString:@"土"]){
            label.backgroundColor = [UIColor colorWithHex:@"7F5729"];
        }else if([str isEqualToString:@"单"]){
            label.backgroundColor = [UIColor colorWithHex:@"A20A79"];
        }else if([str isEqualToString:@"双"]){
            label.backgroundColor = [UIColor colorWithHex:@"BE7A03"];
        }

        CGFloat margin = 5;
        CGFloat w = 19;
        CGFloat h = w;
        CGFloat x = 0;
        CGFloat y = 0;
        if (i == 0) {
            label.frame = CGRectMake(x, y, w, h);
        }else{
            
            BOOL continueBool;
            if (self.bigOrSmallBtn.selected) {
                continueBool = [str isEqualToString:lasttStr] || [str isEqualToString:@"和"] || ([lasttStr isEqualToString:@"和"] && [str isEqualToString:self.preHeStr]);
            }else{
                continueBool = [str isEqualToString:lasttStr];
            }
            
            if (continueBool) {
                //记录连续相同的结果个数
                self.longNum += 1;
                if (self.longNum <= 6) {
                    self.longMinX = self.lastLbl.x;
                    x = self.lastLbl.x;
                    label.frame = CGRectMake(x, CGRectGetMaxY(self.lastLbl.frame) + margin, w, h);
                    if (self.longNum == 6) {//记录长龙最底下的第一个 label,用于之后进行 x 值的比较
                        self.changLongBottomLbl = label;
                    }
                }else{
                    //将长龙底下部分加入到数组
                    [self.currentChangLongLblArray addObject:label];
                    x = CGRectGetMaxX(self.lastLbl.frame) + margin;
                    label.frame = CGRectMake(x, self.lastLbl.y, w, h);
                }
                if (x > self.maxXValue) {
                    self.maxXValue = x;
                }
            }else{

                if (self.longNum >= 6) {
                    if (self.lastChangLongLblArray.count != 0) {
                        for (int a = 0; a < self.lastChangLongLblArray.count; a++) {
                            UILabel *lbl = self.lastChangLongLblArray[a];
                            if (lbl.x >= self.changLongBottomLbl.x) {
                                [lbl removeFromSuperview];
                            }
                        }
                    }
                    
                    [self.lastChangLongLblArray removeAllObjects];
                    [self.lastChangLongLblArray addObjectsFromArray:self.currentChangLongLblArray];
                    [self.currentChangLongLblArray removeAllObjects];
                }
                y = 0;
                if (self.longNum > 6) {
                    x = self.longMinX + w + margin;
                }else{
                    x = CGRectGetMaxX(self.lastLbl.frame) + margin;
                }
                if (x > self.maxXValue) {
                    self.maxXValue = x;
                }
                label.frame = CGRectMake(x, y, w, h);
                //相同开奖结果清空
                self.longNum = 1;
            }
          
        }
        
        self.scrollView.contentSize = CGSizeMake(self.maxXValue + w + margin, 0);
        
        self.lastLbl = label;
        [self.scrollView addSubview:label];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [Tools deleteBlank:self.resultStr].length;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AoZhouNewsLongHuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AoZhouNewsLongHuCollectionViewCellID" forIndexPath:indexPath];
    NSString *str = [self.resultStr substringWithRange:NSMakeRange(indexPath.row, 1)];
    cell.backgroundColor = CLEAR;
    
    cell.titleLbl.textColor = WHITE;
    if ([str isEqualToString:@"大"]) {
        cell.backgroundColor = [UIColor colorWithHex:@"E82A40"];
    }else if([str isEqualToString:@"小"]){
        cell.backgroundColor = [UIColor colorWithHex:@"1A6BFF"];
    }else if([str isEqualToString:@"和"]){
        cell.backgroundColor = [UIColor colorWithHex:@"1D8D18"];
    }else if([str isEqualToString:@"金"]){
        cell.backgroundColor = [UIColor colorWithHex:@"C77F1B"];
    }else if([str isEqualToString:@"木"]){
        cell.backgroundColor = [UIColor colorWithHex:@"267852"];
    }else if([str isEqualToString:@"水"]){
        cell.backgroundColor = [UIColor colorWithHex:@"18698C"];
    }else if([str isEqualToString:@"火"]){
        cell.backgroundColor = [UIColor colorWithHex:@"9B0F11"];
    }else if([str isEqualToString:@"土"]){
        cell.backgroundColor = [UIColor colorWithHex:@"7F5729"];
    }else if([str isEqualToString:@"单"]){
        cell.backgroundColor = [UIColor colorWithHex:@"A20A79"];
    }else if([str isEqualToString:@"双"]){
        cell.backgroundColor = [UIColor colorWithHex:@"BE7A03"];
    }
    
    cell.titleLbl.text = str;
    return cell;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.itemSize = CGSizeMake(19, 19);
        
        flowLayout.minimumLineSpacing = 5;
        
        flowLayout.minimumInteritemSpacing = 5;
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.x, CGRectGetMaxY(self.topView.frame), self.width, self.height - self.topView.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [[CPTThemeConfig shareManager] Buy_LeftView_BackgroundC];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.width, self.height - self.topView.height - 20)];
        _scrollView.delegate = self;
        
    }
    return _scrollView;
}

- (NSMutableArray *)lastChangLongLblArray{
    if (!_lastChangLongLblArray) {
        _lastChangLongLblArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _lastChangLongLblArray;
}

- (NSMutableArray *)currentChangLongLblArray{
    if (!_currentChangLongLblArray) {
        _currentChangLongLblArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _currentChangLongLblArray;
}

@end
