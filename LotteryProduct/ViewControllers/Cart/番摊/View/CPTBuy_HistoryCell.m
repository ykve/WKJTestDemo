//
//  CPTBuy_HistoryCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/3.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "CPTBuy_HistoryCell.h"
#import "NiuWinLabel.h"
@implementation CPTBuy_HistoryCell
{
    NSArray *_dataArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
//    _dataArr = [NSMutableArray array];
    [_collectionView registerNib:[UINib nibWithNibName:@"RedOrBlueBallCell" bundle:nil] forCellWithReuseIdentifier:@"RedOrBlueBallCell"];

}
- (void)setColorModelWithIndex:(NSInteger)index{
    _dateL.textColor = [[CPTThemeConfig shareManager] Fantan_historycellColor1];
    _lineView.backgroundColor = [[CPTThemeConfig shareManager] Fantan_historycellColor2];
    _dotView.backgroundColor = [[CPTThemeConfig shareManager] Fantan_historycellColor3];
    self.contentView.backgroundColor = index%2==0?[[CPTThemeConfig shareManager] Buy_HeadView_historyV_Cell1_C]:[[CPTThemeConfig shareManager] Buy_HeadView_historyV_Cell2_C];
    
}
- (void)setDataWithModel:(PCInfoNewModel *)model andIndex:(NSInteger)index{
    [self setColorModelWithIndex:index];
    if(self.categoryId == CPTBuyCategoryId_NN){
        self.collectionViewCenter.constant = -10;
    }
//    NSString *ss = [NSString stringWithFormat:@"%@",model.issue];
    _dateL.text = model.issue;
//    MBLog(@"%@",model.number);
    NSMutableArray *retArr = [NSMutableArray array];
    if([model.number  containsString:@"+"]){
        NSArray *temp = [model.number componentsSeparatedByString:@"+"];
        if(temp.count){
            for(int i=0;i<temp.count;i++){
                NSString *str = temp[i];
                NSArray *arr = [str componentsSeparatedByString:@","];
                [retArr addObjectsFromArray:arr];
                
            }
            _dataArr = [NSArray arrayWithArray:retArr];
        }
    }else{
        NSArray *nums = [model.number componentsSeparatedByString:@","];
        _dataArr = [NSArray arrayWithArray:nums];
    }
//    NSArray *nums = [model.number componentsSeparatedByString:@","];
//    NSArray *array;
//    NSString *last = [nums lastObject];
//    if([last containsString:@"+"]){
//        NSArray *arr1 = [nums subarrayWithRange:NSMakeRange(0, nums.count-1)];
//        NSMutableArray *retArr = [NSMutableArray arrayWithArray:arr1];
//        NSArray *last2 = [last componentsSeparatedByString:@"+"];
//        array = [retArr arrayByAddingObjectsFromArray:last2];
//        _dataArr = [NSArray arrayWithArray:array];
//    }else{
//        _dataArr = [NSArray arrayWithArray:nums];
//    }
    [_collectionView reloadData];
    NSArray *names = [model.niuWinner componentsSeparatedByString:@","];
    
    for (UIView *v in _niuWinBgView.subviews) {
        [v removeFromSuperview];
    }
    for(int i=0;i< names.count;i++){
        NiuWinLabel *lab = [[NiuWinLabel alloc] initWithFrame:CGRectMake(34*i, 0, 32, 20)];
        lab.text = names[i];
        [_niuWinBgView addSubview:lab];
    }
//    _winLabel.text = [model.niuWinner stringByReplacingOccurrencesOfString:@"," withString:@" "];;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RedOrBlueBallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RedOrBlueBallCell" forIndexPath:indexPath];
    cell.isHistory = YES;
    NSString *num = _dataArr[indexPath.row];
    BOOL isRed = NO;
    if(_categoryId == CPTBuyCategoryId_NN){
        isRed = YES;
        cell.isNN = YES;
    }else{
        if(self.type == CPTBuyTicketType_Shuangseqiu){
            isRed = indexPath.row<6?YES:NO;
        }else if(self.type == CPTBuyTicketType_DaLetou){
            isRed = indexPath.row<5?YES:NO;
        }else if(self.type == CPTBuyTicketType_QiLecai){
            isRed = indexPath.row<7?YES:NO;
        }
    }
    
    [cell setNum:num isRed:isRed opening:NO];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(IS_IPHONE_5){
        return CGSizeMake(30, 45);
    }
    if(_type == CPTBuyTicketType_DaLetou||_type == CPTBuyTicketType_Shuangseqiu){
        CGFloat width = (SCREEN_WIDTH-105)/7;
        return CGSizeMake(width, width);
    }else if(_type == CPTBuyTicketType_QiLecai){
        CGFloat width = (SCREEN_WIDTH-105)/8;
        return CGSizeMake(width, width);
    }else if (_type == CPTBuyTicketType_NiuNiu_JiShu||_type == CPTBuyTicketType_NiuNiu_AoZhou){
        CGFloat width = (SCREEN_WIDTH-105)/10;
        return CGSizeMake(width, width);
    }
    return CGSizeMake(35, 45);
}
- (CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

@end
