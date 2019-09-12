//
//  YHContainerTableViewCell.m
//  YHLinkageDemo
//
//  Created by 张长弓 on 2018/1/8.
//  Copyright © 2018年 张长弓. All rights reserved.
//

#import "YHContainerTableViewCell.h"
#import "ParentClassScrollViewController.h"
#import "CircleListPostViewController.h"
//#import "DollsListCollectionViewController.h"
//#import "ColumnModel.h"

//#import "YHListOneTableViewController.h"
//#import "YHListTwoTableViewController.h"
//#import "YHListThreeTableViewController.h"

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125, 2436),[[UIScreen mainScreen]currentMode].size):NO)

#define kHeight [UIScreen mainScreen].bounds.size.height - 40 - SAFE_HEIGHT - (iPhoneX ? 88 : 64)
//#define kHeight [UIScreen mainScreen].bounds.size.height - 64.0 - 60

@interface YHContainerTableViewCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;


//@property (nonatomic, strong) YHListTwoTableViewController *twoVC;
//@property (nonatomic, strong) YHListThreeTableViewController *threeVC;

@end

@implementation YHContainerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.scrollView];
        
        
    }
    return self;
}

-(NSMutableArray *)vcArray {
    
    if (!_vcArray) {
        
        _vcArray = [[NSMutableArray alloc]init];
        [_vcArray addObjectsFromArray:@[[NSNull null],[NSNull null],[NSNull null]]];
    }
    return _vcArray;
}

-(void)setSelectindex:(NSInteger)selectindex {
    
    _selectindex = selectindex;
    
    [self configScrollViewWithindex:selectindex];
}
//- (void)setDataSoure:(NSArray<ColumnModel *> *)dataSoure {
//    _dataSoure = dataSoure;
//
//    [self configScrollView];
//}

//- (void)configScrollView {
//    self.oneVC = [[YHListOneTableViewController alloc] init];
//    self.twoVC = [[YHListTwoTableViewController alloc] init];
//    self.threeVC = [[YHListThreeTableViewController alloc] init];
//
//    [self.scrollView addSubview:self.oneVC.view];
//    [self.scrollView addSubview:self.twoVC.view];
//    [self.scrollView addSubview:self.threeVC.view];
//
//    self.oneVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeight);
//    self.twoVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, kHeight);
//    self.threeVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, [UIScreen mainScreen].bounds.size.width, kHeight);
//}

// 添加所有子控制器
- (void)configScrollViewWithindex:(NSInteger)index
{
    if ([[self.vcArray objectAtIndex:index] isEqual:[NSNull null]]) {
        
        CircleListPostViewController *vc = [[CircleListPostViewController alloc] init];
        vc.tag = index;
        [self.superViewController addChildViewController:vc];
        [self.scrollView addSubview:vc.view];
        [self.vcArray replaceObjectAtIndex:index withObject:vc];
        vc.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * index, 0, [UIScreen mainScreen].bounds.size.width, kHeight);
    }
//
//    for (int i = 0; i < self.vcArray.count; i++) {
//
//
//
//    }
    
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.vcArray.count, kHeight);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 为了横向滑动的时候，外层的tableView不动
    if (!self.isSelectIndex) {
        if (scrollView == self.scrollView) {
            if (self.delegate &&
                [self.delegate respondsToSelector:@selector(mmtdOptionalScrollViewDidScroll:)]) {
                [self.delegate mmtdOptionalScrollViewDidScroll:scrollView];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isSelectIndex = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(mmtdOptionalScrollViewDidEndDecelerating:)]) {
            [self.delegate mmtdOptionalScrollViewDidEndDecelerating:scrollView];
        }
    }
}

#pragma mark - Init Views

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kHeight)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 3, _scrollView.frame.size.height);
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (void)setObjectCanScroll:(BOOL)objectCanScroll {
    _objectCanScroll = objectCanScroll;
    
//    self.oneVC.vcCanScroll = objectCanScroll;
//    self.twoVC.vcCanScroll = objectCanScroll;
//    self.threeVC.vcCanScroll = objectCanScroll;
    for (id object in self.vcArray) {
        
        if ([object isKindOfClass:[CircleListPostViewController class]]) {
            
            CircleListPostViewController *viewController = (CircleListPostViewController *)object ;
            
            viewController.canScroll = objectCanScroll;
            if (!objectCanScroll) {
                [viewController.scrollView setContentOffset:CGPointZero animated:NO];
            }
        }
    }
//    for (CircleListPostViewController *viewController in self.vcArray) {
//        
//        viewController.canScroll = objectCanScroll;
//        if (!objectCanScroll) {
//            [viewController.scrollView setContentOffset:CGPointZero animated:NO];
//        }
//    }
    
//    if (!objectCanScroll) {
//        [self.oneVC.tableView setContentOffset:CGPointZero animated:NO];
//        [self.twoVC.tableView setContentOffset:CGPointZero animated:NO];
//        [self.threeVC.tableView setContentOffset:CGPointZero animated:NO];
//    }
}

@end
