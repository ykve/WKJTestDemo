//
//  TouPiaoContentView.m
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/21.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "TouPiaoContentView.h"
#import "TouPiaoContentCollectionViewCell.h"
#import "TouPiaoModel.h"
#import "IGKbetModel.h"
//#import "PCInfoNewModel."

#define kShnegXiaoLineNum 4

@interface TouPiaoContentView ()<UICollectionViewDelegate ,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,weak) UIView *topView;

@property (nonatomic,weak) UILabel *titleLbl;

@property (nonatomic, copy) NSString *submitStr;

@property (nonatomic, strong)NSIndexPath *lastIndexPath;

@property (nonatomic, strong)NSArray *temArray;


@end

@implementation TouPiaoContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildSubViews];
        
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self buildSubViews];
}

- (void)buildSubViews{
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 30, 50)];
    topView.backgroundColor = [[CPTThemeConfig shareManager] CO_Nav_Bar_CustViewBack];
    self.topView = topView;
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake((topView.width - 200)/2, 10, 200, 30)];
    titleLbl.text = @"--期";
    titleLbl.textColor = [[CPTThemeConfig shareManager] xinShuiReconmentGoldColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:18];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    self.titleLbl = titleLbl;
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(topView.width - 50, 0, 50, topView.height)];
    [closeBtn setImage:IMAGE(@"lhtk_tc_gbiocn") forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeContentView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.width - 152)/2, CGRectGetMaxY(self.collectionView.frame) + 10, 152, 35)];
    
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = submitBtn.height/2;
    submitBtn.backgroundColor = [[CPTThemeConfig shareManager] CO_LHTK_SubmitBtnBack];

    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:submitBtn];
    
    [self addSubview:self.collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TouPiaoContentCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:TouPiaoContentCollectionViewCellID];
    
    [topView addSubview:closeBtn];
    [topView addSubview:titleLbl];
    [self addSubview:topView];
}

- (void)submit : (UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(submitTouPiao:)]) {
        [self.delegate submitTouPiao:self.submitStr];
    }
    self.submitStr = @"";
    
}


- (void)setToupiaoList:(NSMutableArray *)toupiaoList{
    //    [self.toupiaoList removeAllObjects];
    _toupiaoList = toupiaoList;
    self.temArray =  [NSArray arrayWithArray:toupiaoList];
    
    [self.collectionView reloadData];
}

- (void)setIssue:(NSString *)issue{
    _issue = issue;
//    self.titleLbl.text = issue;
    [[CPTOpenLotteryManager shareManager] checkModelByIds:@[@(CPTBuyTicketType_LiuHeCai)] callBack:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
        NSString *nextIssue = data.lhc.nextIssue;
        self.titleLbl.text = nextIssue;
    }];
    
//    [[CPTOpenLotteryManager shareManager] checkModel:^(IGKbetModel * _Nonnull data, BOOL isSuccess) {
//        NSString *nextIssue = data.lhc.nextIssue;
//        self.titleLbl.text = nextIssue;
//    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.temArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TouPiaoContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TouPiaoContentCollectionViewCellID forIndexPath:indexPath];
    
    TouPiaoModel *model = self.temArray[indexPath.row];
    cell.icon.selected = NO;
    [cell.icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal];
    [cell.icon sd_setBackgroundImageWithURL:[NSURL URLWithString:model.selectIcon] forState:UIControlStateSelected];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@票", model.name, model.voteNum]];
    
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(0, model.name.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] grayColor333] range:NSMakeRange(0, model.name.length)];
    
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0f] range:NSMakeRange(model.name.length + 1, model.voteNum.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[[CPTThemeConfig shareManager] grayColor999] range:NSMakeRange(model.name.length + 1, model.voteNum.length + 1)];
    cell.titleLbl.attributedText = attrStr;
    
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TouPiaoContentCollectionViewCell *cell = (TouPiaoContentCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    TouPiaoContentCollectionViewCell *lastCell = (TouPiaoContentCollectionViewCell *)[collectionView cellForItemAtIndexPath:self.lastIndexPath];
    
    TouPiaoModel *model = self.toupiaoList[indexPath.row];
    
    lastCell.icon.selected = NO;
    
    cell.icon.selected = YES;
    
    self.submitStr = model.ID;;
    
    self.lastIndexPath = indexPath;
    
}


- (void)closeContentView{
    
    TouPiaoContentCollectionViewCell *lastCell = (TouPiaoContentCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.lastIndexPath];
    
    lastCell.icon.selected = NO;
    
    self.submitStr = @"";
    
    if ([self.delegate respondsToSelector:@selector(removeTouPiaoContentView)]) {
        [self.delegate removeTouPiaoContentView];
    }
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 60 - 30)/4, 110);
        
        flowLayout.minimumLineSpacing = 0;
        
        flowLayout.minimumInteritemSpacing = 0;
        
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.topView.frame), self.topView.width - 20, (flowLayout.itemSize.height) * 3 + flowLayout.minimumLineSpacing * 2) collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    
    return _collectionView;
}

//- (NSMutableArray *)dataList{
//    if (!self.dataList) {
//        self.dataList = [NSMutableArray arrayWithCapacity:3];
//    }
//    return self.dataList;
//}

@end
