//
//  SixPropertyCell.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/11.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixPropertyCell.h"

@implementation SixPropertyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(UILabel *)titlelab {
    
    if (!_titlelab) {
        
        _titlelab = [Tools createLableWithFrame:CGRectZero andTitle:@"" andfont:FONT(13) andTitleColor:YAHEI andBackgroundColor:CLEAR andTextAlignment:0];
        
        [self.contentView addSubview:_titlelab];
    }
    return _titlelab;
}

-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 0;
        
        layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = WHITE;
        _collectionView.scrollEnabled = NO;
        //注册
        [_collectionView registerClass:[CollectionBaseCell class] forCellWithReuseIdentifier:RJCellIdentifier];
        [self.contentView addSubview:_collectionView];
    }
    
    return _collectionView;
}

-(UIView *)line {
    
    if (!_line) {
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_line];
    }
    return _line;
}

-(void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
}

-(void)setType:(NSInteger)type {
    
    _type = type;
    
    [self layoutIfNeeded];
}

-(void)layoutSubviews {
    
    if (self.type == 0) {
        
        [self.titlelab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.equalTo(self).offset(8);
        }];
        
        [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(30, 8, 8, 8));
        }];
    }else {
        
        [self.titlelab mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(8);
            make.centerY.equalTo(self);
        }];
        
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(8, 40, 8, 8));
        }];
    }
    
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    NSString *string = [self.dataArray objectAtIndex:indexPath.item];
    
    [cell.iconBtn setTitle:string forState:UIControlStateNormal];
    
    [cell.iconBtn setBackgroundImage:[Tools numbertoimage:string Withselect:NO] forState:UIControlStateNormal];
    
    cell.iconBtn.userInteractionEnabled = NO;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width/9, collectionView.bounds.size.width/9);
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
