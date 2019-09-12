//
//  CPTBuy_DoubleColorCell.m
//  LotteryProduct
//
//  Created by pt c on 2019/3/12.
//  Copyright © 2019年 vsskyblue. All rights reserved.
//

#import "CPTBuy_DoubleColorCell.h"
#import "CPTBuy_DoubleColorBallCell.h"
@implementation CPTBuy_DoubleColorCell
{
    NSMutableArray *_allRedball;
    NSMutableArray *_allBlueball;
    NSMutableArray *_selectedRedArr;
    NSMutableArray *_selectedBlueArr;
}
- (void)prepareBallData{
    NSUInteger redNum = 0;
    NSInteger blueNum = 0;
    switch (_lotteryId) {
        case CPTBuyTicketType_Shuangseqiu://双色球
        {
            redNum = 33;
            blueNum = 16;
        }break;
        case CPTBuyTicketType_DaLetou://大乐透
        {
            redNum = 35;
            blueNum = 12;
        }break;
        case CPTBuyTicketType_QiLecai://七乐彩
        {
            redNum = 30;
            blueNum = 30;
        }break;
        default:
            break;
    }
    for(int i = 1;i<=redNum;i++){
        [_allRedball addObject:@"0"];
    }
    for(int i = 1;i<=blueNum;i++){
        [_allBlueball addObject:@"0"];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _allRedball = [NSMutableArray array];
    _allBlueball = [NSMutableArray array];
    // Initialization code
    _selectedRedArr = [NSMutableArray array];
    _selectedBlueArr = [NSMutableArray array];
    [_redCollectionView registerNib:[UINib nibWithNibName:@"CPTBuy_DoubleColorBallCell" bundle:nil] forCellWithReuseIdentifier:@"CPTBuy_DoubleColorBallCell"];
    [_blueCollectionView registerNib:[UINib nibWithNibName:@"CPTBuy_DoubleColorBallCell" bundle:nil] forCellWithReuseIdentifier:@"CPTBuy_DoubleColorBallCell"];
    if ([[AppDelegate shareapp] sKinThemeType] == SKinType_Theme_White) {
        self.backgroundColor = CLEAR;
        self.contentView.backgroundColor = CLEAR;
        self.redCollectionView.backgroundColor = CLEAR;
        self.blueCollectionView.backgroundColor = CLEAR;
        self.lineView.backgroundColor = [UIColor colorWithHex:@"D6D6D6"];
        _lab1.textColor = [UIColor colorWithHex:@"333333"];
        _lab2.textColor = [UIColor colorWithHex:@"333333"];
        
    }else{
        self.contentView.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanCellBgColor];
        self.redCollectionView.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanCellBgColor];
        self.blueCollectionView.backgroundColor = [[CPTThemeConfig shareManager] Buy_fantanCellBgColor];
    }
    
    
    
    
}
- (void)setLotteryId:(NSInteger)lotteryId{
    _lotteryId = lotteryId;
    MBLog(@"%f",_redCollectionWitdhScale.constant);
    MBLog(@"%f",_blueCollectionWidthScale.constant);
    [self prepareBallData];
    if(_lotteryId == CPTBuyTicketType_QiLecai){
        self.blueView.hidden = YES;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView.tag == 0){//红球
        switch (_lotteryId) {
            case CPTBuyTicketType_Shuangseqiu://双色球
            {
                return 33;
            }break;
            case CPTBuyTicketType_DaLetou://大乐透
            {
                return 35;
            }break;
            case CPTBuyTicketType_QiLecai://七乐彩
            {
                return 30;
            }break;
            default:
                break;
        }
    }else{
        switch (_lotteryId) {
            case CPTBuyTicketType_Shuangseqiu://双色球
            {
                return 16;
            }break;
            case CPTBuyTicketType_DaLetou://大乐透
            {
                return 12;
            }break;
            case CPTBuyTicketType_QiLecai://七乐彩
            {
                return 30;
            }break;
            default:
                break;
        }
     }
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (SCREEN_WIDTH-10)/7;
    return CGSizeMake(width, width);
}
- (CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(collectionView.tag == 0){//红球区
        CPTBuy_DoubleColorBallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPTBuy_DoubleColorBallCell" forIndexPath:indexPath];
        cell.didClick = ^(UIButton * btn) {
             NSInteger index = btn.titleLabel.text.integerValue - 1;
            if(btn.selected == YES){
                _allRedball[index] = @"1";
            }else{
                _allRedball[index] = @"0";
            }
            [self updateSelection];
        };
        NSString *status = _allRedball[indexPath.row];
        [cell setNumWith:indexPath.row+1 isRed:YES andSelect:status.integerValue==1?YES:NO];
        return cell;
    }else if (collectionView.tag == 1){//蓝球区
        CPTBuy_DoubleColorBallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CPTBuy_DoubleColorBallCell" forIndexPath:indexPath];
        cell.didClick = ^(UIButton * btn) {
            NSInteger index = btn.titleLabel.text.integerValue - 1;
            if(btn.selected == YES){
                _allBlueball[index] = @"1";
            }else{
                _allBlueball[index] = @"0";
            }
            [self updateSelection];
        };
        NSString *status = _allBlueball[indexPath.row];
        [cell setNumWith:indexPath.row+1 isRed:NO andSelect:status.integerValue==1?YES:NO];
        return cell;
    }
    return [UICollectionViewCell new];
}



- (void)clearAllWithRandom:(BOOL)isRandom{
    [_allRedball removeAllObjects];
    [_allBlueball removeAllObjects];
    [self prepareBallData];
    if(isRandom){//机选
        [self randomBalls];
    }else{
        [self updateSelection];
    }
    [_redCollectionView reloadData];
    [_blueCollectionView reloadData];
}

- (void)randomBalls{
    NSMutableArray *randomRedBalls = [NSMutableArray array];
    NSMutableArray *randomBlueBalls = [NSMutableArray array];
    NSInteger redNum;
    NSInteger blueNum;
    switch (self.lotteryId) {
        case CPTBuyTicketType_Shuangseqiu://双色球
        {
            redNum = 6;
            blueNum = 1;
        }break;
        case CPTBuyTicketType_DaLetou://大乐透
        {
            redNum = 5;
            blueNum = 2;
        }break;
        case CPTBuyTicketType_QiLecai://七乐彩
        {
            redNum = 7;
//            blueNum = 1;
            blueNum = 0;
        }break;
        default:
            redNum = 0;
            blueNum = 0;
            break;
    }
    for(int i=0;i<redNum;i++){
        NSString *num = [self getRandomRedNum];
        if(![randomRedBalls containsObject:num]){
            [randomRedBalls addObject:num];
        }else{
            i--;
        }
    }
    for (NSString *redNum in randomRedBalls) {
        _allRedball[redNum.integerValue-1] = @"1";
    }
    for(int i=0;i<blueNum;i++){
        NSString *blue = [self getRandomBlueNum];
        if(![randomBlueBalls containsObject:blue]){
            [randomBlueBalls addObject:blue];
        }else{
            i--;
        }
    }
    for (NSString *blueNum in randomBlueBalls) {
        _allBlueball[blueNum.integerValue-1] = @"1";
    }
//    刷新选中
    [self updateSelection];
}
- (void)updateSelection{
    NSMutableArray *redArr = [NSMutableArray array];
    for(int i = 0;i < _allRedball.count;i++){
        NSString *select = _allRedball[i];
        if(select.integerValue == 1){
            if(i+1 < 10){
                [redArr addObject:[NSString stringWithFormat:@"0%d",i+1]];
            }else{
                [redArr addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            
        }
    }
    NSMutableArray *blueArr = [NSMutableArray array];
    for(int i=0;i<_allBlueball.count;i++){
        NSString *select = _allBlueball[i];
        if(select.integerValue == 1){
            if(i+1 < 10){
                [blueArr addObject:[NSString stringWithFormat:@"0%d",i+1]];
            }else{
                [blueArr addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            
        }
    }
    if(self.didChangeSelection){
        self.didChangeSelection(redArr, blueArr);
    }
//    MBLog(@"red:%@",redArr);
//    MBLog(@"blue:%@",blueArr);
}
- (NSString *)getRandomRedNum{
    NSInteger num;
    switch (_lotteryId) {
        case CPTBuyTicketType_Shuangseqiu://双色球
        {
            num = 33;
        }break;
        case CPTBuyTicketType_DaLetou://大乐透
        {
            num = 35;
        }break;
        case CPTBuyTicketType_QiLecai://七乐彩
        {
            num = 30;
        }break;
            
        default:
            num = 0;
            break;
    }
    return [NSString stringWithFormat:@"%ld",random()%num+1];
}
- (NSString *)getRandomBlueNum{
    NSInteger num;
    switch (_lotteryId) {
        case  CPTBuyTicketType_Shuangseqiu://双色球
        {
            num = 16;
        }break;
        case CPTBuyTicketType_DaLetou://大乐透
        {
            num = 12;
        }break;
        case CPTBuyTicketType_QiLecai://七乐彩
        {
            num = 30;
        }break;
            
        default:
            num = 0;
            break;
    }
//    NSInteger num = _isShuangseqiu?16:12;
    return [NSString stringWithFormat:@"%ld",random()%num+1];
}


@end
