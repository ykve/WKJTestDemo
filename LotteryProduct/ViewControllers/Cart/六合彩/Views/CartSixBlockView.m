//
//  CartSixBlockView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartSixBlockView.h"
#import "CartSixNumberCell.h"
@implementation CartSixBlockView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UILabel *)titlelab {
    
    if (!_titlelab) {
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = BUTTONCOLOR;
        [self addSubview:line];
        
        _titlelab = [Tools createLableWithFrame:CGRectZero andTitle:nil andfont:FONT(15) andTitleColor:BUTTONCOLOR andBackgroundColor:CLEAR andTextAlignment:0];
        [self addSubview:_titlelab];
        
        UIButton *btn = [Tools createButtonWithFrame:CGRectZero andTitle:nil andTitleColor:CLEAR andBackgroundImage:nil andImage:IMAGE(@"PCdandanwenhao") andTarget:self andAction:@selector(cartinfoClick) andType:UIButtonTypeCustom];
        [self addSubview:btn];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self);
            make.top.equalTo(self).offset(12);
            make.size.mas_equalTo(CGSizeMake(2, 15));
        }];
        
        [_titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(line.mas_right).offset(12);
            make.centerY.equalTo(line);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_titlelab.mas_right).offset(12);
            make.centerY.equalTo(line);
        }];
    }
    return _titlelab;
}


-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 1;
        
        layout.minimumLineSpacing = 1;
        
        CGFloat itemWidth = (SCREEN_WIDTH - 1 * (3 + 1)) / 3;
        
        layout.itemSize = CGSizeMake(itemWidth, itemWidth * 0.65);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        
        [_collectionView registerClass:[CartSixNumberCell class] forCellWithReuseIdentifier:RJCellIdentifier];
        
        _collectionView.backgroundColor = WHITE;
        
        _collectionView.scrollEnabled = NO;
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        [self addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(40, 0, 0, 0));
        }];
    }
    return _collectionView;
}

-(void)setTiteleArray:(NSArray *)titeleArray {
    
    _titeleArray = titeleArray;
    
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.titeleArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.titeleArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CartSixNumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    cell.type = 2;
    
    CartSixModel *model = self.titeleArray[indexPath.section][indexPath.item];
    
    cell.title = model.number;
    
    cell.Oddslab.text = model.odds;
    
    cell.numberBtn.selected = model.select;
    
    cell.selectBlock = ^(UIButton *sender) {
        
        sender.selected = !sender.selected;
        
        model.select = sender.selected;
        
        if (self.refreshpriceBlock) {
            
            self.refreshpriceBlock();
        }
    };
    
    return cell;
}

-(void)cartinfoClick {
    
    if (self.cartInfoBlock) {
        
        self.cartInfoBlock();
    }
}
@end
