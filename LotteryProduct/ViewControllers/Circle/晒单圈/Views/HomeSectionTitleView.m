//
//  HomeSectionTitleView.m
//  ClawGame
//
//  Created by Jiang on 2018/3/1.
//  Copyright © 2018年 softgarden. All rights reserved.
//

#import "HomeSectionTitleView.h"
//#import "ColumnModel.h"
#import "YZDisplayTitleLabel.h"

@interface HomeSectionTitleView()

/** 所以标题数组 */
@property (nonatomic, strong) NSMutableArray *titleLabels;

/** 所以标题宽度数组 */
@property (nonatomic, strong) NSMutableArray *titleWidths;

/** <#Description#> */
@property (assign, nonatomic) CGFloat titleMargin;

@end

@implementation HomeSectionTitleView

- (void)setDataSoure:(NSArray<ColumnModel *> *)dataSoure {
    _dataSoure = dataSoure;
    
    [self addSubview:self.titleScrollView];
    self.titleMargin = 0;
    [self setUpTitleWidth];
    [self setUpAllTitle];
}

// 计算所有标题宽度
- (void)setUpTitleWidth
{
    // 判断是否能占据整个屏幕
//    NSUInteger count = self.dataSoure.count;
    
    NSArray *titles = @[@"最新发表",@"我的关注",@"回复我的"];//[self.dataSoure valueForKeyPath:@"columnName"];
    
    CGFloat totalWidth = 0;
    
    // 计算所有标题的宽度
    for (NSString *title in titles) {
        
        if ([title isKindOfClass:[NSNull class]]) {
            // 抛异常
            NSException *excp = [NSException exceptionWithName:@"YZDisplayViewControllerException" reason:@"没有设置Controller.title属性，应该把子标题保存到对应子控制器中" userInfo:nil];
            [excp raise];
            
        }
        
        CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        CGFloat width = titleBounds.size.width + 30;
        
        [self.titleWidths addObject:@(width)];
        
        totalWidth += width;
    }
    
    //    if (totalWidth > YZScreenW) {
    
    self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
}

// 设置所有标题
- (void)setUpAllTitle
{
    // 遍历所有的子控制器
    NSUInteger count = 3;//self.dataSoure.count;
    
    // 添加所有的标题
    CGFloat labelW = 0;
    CGFloat labelH = 40;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    for (int i = 0; i < count; i++) {
        
        // ColumnModel *model = self.dataSoure[i];
        
        UILabel *label = [[YZDisplayTitleLabel alloc] init];
        
        label.tag = i;
        
        // 设置按钮的文字颜色
        label.textColor = [UIColor colorWithHex:@"666666"];
        
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor whiteColor];
        
        // 设置按钮标题
        label.text = @"12oij3o";//model.columnName;

        labelW = [self.titleWidths[i] floatValue];
        
        // 设置按钮位置
        UILabel *lastLabel = [self.titleLabels lastObject];
        
        labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        label.userInteractionEnabled = YES;
        
        // 监听标题的点击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        // 保存到数组
        [self.titleLabels addObject:label];
        
        [_titleScrollView addSubview:label];
        
        if (i == _selectIndex) {
            [self titleClick:tap];
        }
    }
    
    // 设置标题滚动视图的内容范围
    UILabel *lastLabel = self.titleLabels.lastObject;
    _titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
//    _contentScrollView.contentSize = CGSizeMake(count * YZScreenW, 0);
    
}

#pragma mark - 标题点击处理
- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    
    if (self.titleLabels.count) {
        
        UILabel *label = self.titleLabels[selectIndex];
        
        if (_selectIndex >= self.titleLabels.count) {
            @throw [NSException exceptionWithName:@"YZ_ERROR" reason:@"选中控制器的角标越界" userInfo:nil];
        }
        
        [self titleClick:[label.gestureRecognizers firstObject]];
    }
}

// 标题按钮点击
- (void)titleClick:(UITapGestureRecognizer *)tap
{
    // 记录是否点击标题
    _isClickTitle = YES;
    
    // 获取对应标题label
    UILabel *label = (UILabel *)tap.view;
    
    // 获取当前角标
    NSInteger i = label.tag;
    _selectIndex = i;
    // 选中label
    [self selectLabel:label];
    
    // 内容滚动视图滚动到对应位置
    CGFloat offsetX = i * [UIScreen mainScreen].bounds.size.width;
    
    if (self.block) {
        self.block(i);
    }
//    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 记录上一次偏移量,因为点击的时候不会调用scrollView代理记录，因此需要主动记录
    _lastOffsetX = offsetX;
    
    
    
    _selIndex = i;
    
    // 点击事件处理完成
    _isClickTitle = NO;
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"REFRESHATTENTION" object:nil];

}

- (void)selectLabel:(UILabel *)label
{
    
    for (YZDisplayTitleLabel *labelView in self.titleLabels) {
        
        if (label == labelView) continue;
        
        labelView.textColor = [UIColor colorWithHex:@"666666"];
        labelView.font = [UIFont systemFontOfSize:15];
        labelView.backgroundColor = [UIColor whiteColor];
    }
    
    // 标题缩放
    
    // 修改标题选中颜色
    label.textColor = [UIColor colorWithHex:@"333333"];
//    label.font = YZSelectedTitleFont;
    label.backgroundColor = [UIColor colorWithHex:@"f1cacd"];
    
    // 设置标题居中
    [self setLabelTitleCenter:label];
    
    // 设置下标的位置
//    if (_isShowUnderLine) {
//        [self setUpUnderLine:label];
//    }
    
    // 设置cover
//    if (_isShowTitleCover) {
//        [self setUpCoverView:label];
//    }
    
}

// 让选中的按钮居中显示
- (void)setLabelTitleCenter:(UILabel *)label
{
    
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - ([UIScreen mainScreen].bounds.size.width - 18) * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - [UIScreen mainScreen].bounds.size.width + _titleMargin;
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 滚动区域
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

- (NSMutableArray *)titleWidths
{
    if (_titleWidths == nil) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}

- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

// 懒加载标题滚动视图
- (UIScrollView *)titleScrollView
{
    if (_titleScrollView == nil) {
        
        UIScrollView *titleScrollView = [[UIScrollView alloc] init];
        titleScrollView.scrollsToTop = NO;
        titleScrollView.backgroundColor = [UIColor whiteColor];
        titleScrollView.layer.cornerRadius = 10;
        titleScrollView.layer.masksToBounds = YES;
        
        _titleScrollView = titleScrollView;
        
    }
    return _titleScrollView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleScrollView.frame = CGRectMake(9, 0, self.frame.size.width - 18, self.frame.size.height);
}

@end
