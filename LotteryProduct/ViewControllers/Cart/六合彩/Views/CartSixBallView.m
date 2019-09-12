//
//  CartSixBallView.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/7/5.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "CartSixBallView.h"
#import "CartSixNumberCell.h"
@implementation CartSixBallView

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

-(UISegmentedControl *)segment {
    
    if (!_segment) {
        
        _segment = [[UISegmentedControl alloc]initWithItems:@[@"全",@"大",@"小",@"奇",@"偶",@"清"]];
        _segment.selectedSegmentIndex = -1;
        _segment.layer.cornerRadius = 10;
        _segment.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _segment.layer.borderWidth = 1;
        _segment.clipsToBounds = YES;
        _segment.tintColor = LINECOLOR;
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateSelected];
        
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}forState:UIControlStateNormal];
        
        [_segment setDividerImage:[Tools createImageWithColor:[UIColor lightGrayColor] Withsize:CGSizeMake(1, 20)] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        _segment.apportionsSegmentWidthsByContent = NO;
        [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_segment];
        [_segment mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self).offset(-12);
            make.centerY.equalTo(self.titlelab);
            make.size.mas_equalTo(CGSizeMake(200, 20));
        }];
    }
    return _segment;
}

-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 1;
        
        layout.minimumLineSpacing = 1;
        
        CGFloat itemWidth = (SCREEN_WIDTH - 1 * (4 + 1)) / 4;
        
        layout.itemSize = CGSizeMake(itemWidth, itemWidth * 0.8);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        
        [_collectionView registerClass:[CartSixNumberCell class] forCellWithReuseIdentifier:RJCellIdentifier];
        
        _collectionView.scrollEnabled = NO;
        
        _collectionView.backgroundColor = WHITE;
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        [self addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(40, 0, 0, 0));
        }];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CartSixNumberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    CartSixModel *model = [self.array objectAtIndex:indexPath.item];
    
    cell.type = 1;
    
    cell.title = model.number;
    
    cell.Oddslab.text = model.odds;
    
    cell.numberBtn.selected = model.select;
    
    cell.selectBlock = ^(UIButton *sender) {
        
        if ([self canselect:sender]) {
            
            sender.selected = !sender.selected;
            
            self.segment.selectedSegmentIndex = -1;
            
            model.select = sender.selected;
            
            if (self.refreshpriceBlock) {
                
                self.refreshpriceBlock();
            }
        }
        
    };
    
    return cell;
}

-(BOOL)canselect:(UIButton *)sender{
    /*
     20：五不中 ------342
     21：六不中--------347
     22：七不中--------348
     23：八不中---------349
     24：九不中---------350
     25：十不中---------351
     */
    if (self.selectModel.ID >= 342 && self.selectModel.ID <= 351) {
        
        NSInteger count = 0;
        
        for (CartSixModel *model in self.array) {
            
            if (model.select) {
                count ++;
            }
        }
        
        if (self.selectModel.ID == 342 && count == 8 && sender.selected == NO) {
            
            [MBProgressHUD showError:@"只允许选5-8个号码"];
            return NO;
        }
        if (self.selectModel.ID == 347 && count == 9 && sender.selected == NO) {
            [MBProgressHUD showError:@"只允许选6-9个号码"];
            return NO;
        }
        if (self.selectModel.ID == 348 && count == 10 && sender.selected == NO) {
            [MBProgressHUD showError:@"只允许选7-10个号码"];
            return NO;
        }
        if (self.selectModel.ID == 349 && count == 11 && sender.selected == NO) {
            [MBProgressHUD showError:@"只允许选8-11个号码"];
            return NO;
        }
        if (self.selectModel.ID == 350 && count == 12 && sender.selected == NO) {
            [MBProgressHUD showError:@"只允许选9-12个号码"];
            return NO;
        }
        if (self.selectModel.ID == 351 && count == 13 && sender.selected == NO) {
            [MBProgressHUD showError:@"只允许选10-13个号码"];
            return NO;
        }
    }
    return YES;
}


-(void)segmentClick:(UISegmentedControl *)sender {
    
    for (CartSixModel *model in self.array) {
        
        model.select = NO;
    }
    if (sender.selectedSegmentIndex == 0) {
        
        for (CartSixModel *model in self.array) {
            
            model.select = YES;
        }
    }
    else if (sender.selectedSegmentIndex == 1) {
        
        for (CartSixModel *model in self.array) {
            
            if (model.number.integerValue >= 25) {
                
                model.select = YES;
            }
        }
    }
    else if (sender.selectedSegmentIndex == 2) {
        
        for (CartSixModel *model in self.array) {
            
            if (model.number.integerValue < 25) {
                
                model.select = YES;
            }
        }
    }
    else if (sender.selectedSegmentIndex == 3) {
        
        for (CartSixModel *model in self.array) {
            
            if (model.number.integerValue & 1) {
                
                model.select = YES;
            }
        }
    }
    else if (sender.selectedSegmentIndex == 4) {
        
        for (CartSixModel *model in self.array) {
            
            if ((model.number.integerValue & 1) == NO) {
                
                model.select = YES;
            }
        }
    }
    else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            sender.selectedSegmentIndex = -1;
        });
    }
    
    if (self.refreshpriceBlock) {
        
        self.refreshpriceBlock();
    }
    
    [self.collectionView reloadData];
}

-(void)setArray:(NSArray *)array {
    
    _array = array;
    
    [self.collectionView reloadData];
}

-(void)cartinfoClick {
    
    if (self.cartInfoBlock) {
        
        self.cartInfoBlock();
    }
}

@end
