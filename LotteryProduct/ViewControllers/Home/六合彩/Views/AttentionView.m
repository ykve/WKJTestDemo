//
//  AttentionView.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/3.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "AttentionView.h"
#import "AttentionCollectionViewCell.h"

@interface AttentionView ()

@property (nonatomic, strong) UISwitch *deleteAttentionSwitch;

@property (nonatomic, strong)UIButton *CloseBtn;


@end

@implementation AttentionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self addSubview:self.topView];
    [self addSubview:self.collectionView];
//    [self.deleteAttentionSwitch addTarget:self action:@selector(swithDeleteModel:) forControlEvents:UIControlEventValueChanged];
    self.isDeleteModel = NO;
    
    return self;
}

#pragma mark 删除模式
- (void)swithDeleteModel:(UISwitch *)switcher{
    
    self.isDeleteModel = switcher.on ? YES : NO;
    
    [self.collectionView reloadData];
    
}
- (void)editAction:(UIButton *)btn{
    btn.selected = btn.selected ? NO : YES;
    self.isDeleteModel = btn.selected ? YES : NO;
    [self.collectionView reloadData];

}

- (void)closeAttentionView{

    if ([self.delegate respondsToSelector:@selector(closeCoverView)]) {
        
        self.isDeleteModel = NO;
        [self.delegate closeCoverView];
    }
    
}

#pragma mark 懒加载

- (UIButton *)CloseBtn{
    if (!_CloseBtn) {
        _CloseBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 35, 10, 35, 35)];
        [_CloseBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [_CloseBtn setImage:[[CPTThemeConfig shareManager] attentionViewCloseImage] forState:UIControlStateNormal];
        [_CloseBtn addTarget:self action:@selector(closeAttentionView) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _CloseBtn;
}

- (UISwitch *)deleteAttentionSwitch{
    if (!_deleteAttentionSwitch) {
        _deleteAttentionSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(10, 10, 50, 10)];
        _deleteAttentionSwitch.tintColor = [UIColor whiteColor];
    }
    return _deleteAttentionSwitch;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _topView.backgroundColor = [[CPTThemeConfig shareManager] xinShuiReconmentRedColor];

        UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 60, self.topView.height)];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setTitle:@"完成" forState:UIControlStateSelected];
        self.editBtn = editBtn;
        editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [editBtn setTitleColor:[[CPTThemeConfig shareManager] xinShuiReconmentGoldColor] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:editBtn];
        
        UILabel *attentionLbl = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 10, 100, 30)];
        attentionLbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        attentionLbl.text = @"关注";
        attentionLbl.textColor = WHITE;
        [attentionLbl setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        attentionLbl.textAlignment = NSTextAlignmentCenter;
        [_topView addSubview:attentionLbl];
        
        [_topView addSubview:self.CloseBtn];
        

    }
    return _topView;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 40)/5, (SCREEN_WIDTH - 40)/5 + 20);
        
        flowLayout.minimumLineSpacing = 10;
        
        flowLayout.minimumInteritemSpacing = 10;
        

        if ( IS_IPHONEX) {
            
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.topView.height, SCREEN_WIDTH, self.frame.size.height - self.topView.height) collectionViewLayout:flowLayout];

        }else{
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.topView.height, SCREEN_WIDTH, self.frame.size.height - 50) collectionViewLayout:flowLayout];
        }
        _collectionView.backgroundColor = [UIColor whiteColor];
//        _collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);

//        _collectionView.layer.cornerRadius = 5;
//        _collectionView.layer.masksToBounds = YES;
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AttentionCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:AttentionCollectionViewCellID];


    }
    
    return _collectionView;
}

@end
