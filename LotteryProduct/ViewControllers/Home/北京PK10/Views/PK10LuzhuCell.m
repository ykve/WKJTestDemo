//
//  PK10LuzhuCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/25.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "PK10LuzhuCell.h"
#define itemWidth  30        //每个item的宽度
@implementation PK10LuzhuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
    
    [self setNeedsDisplay];
    
    
}

-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 0;
        
        layout.minimumLineSpacing = 0;
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = WHITE;
        //注册
        [_collectionView registerClass:[CollectionBaseCell class] forCellWithReuseIdentifier:RJCellIdentifier];
        [self.contentView addSubview:_collectionView];
    }
    
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    NSString *str = [self.dataArray objectAtIndex:indexPath.item];
    
    cell.textView.text = str;
    
    cell.textView.backgroundColor = indexPath.item %2 == 0 ? WHITE : [UIColor groupTableViewBackgroundColor];
    
    cell.textView.textColor = indexPath.item %2 == 0 ? kColor(34, 113, 201) : LINECOLOR;
    
    [cell setNeedsDisplay];
    
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(itemWidth, collectionView.bounds.size.height);
}

-(void)layoutSubviews {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView);
    }];
    
    [self.collectionView layoutIfNeeded];
    
   [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentSize.width - CGRectGetWidth(self.frame), 0) animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
