//
//  SixSearchView.m
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/7.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import "SixSearchView.h"

@interface SixSearchView ()<UISearchBarDelegate,UITextFieldDelegate>

@property (nonatomic, copy) NSString *searchStr;


@end

@implementation SixSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        [self setSearchBar];
        
    }
    return self;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    NSLog(@"%@", searchText);
    self.searchStr = searchText;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    MBLog(@"0000");
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(searchArticles:)]) {
        [self.delegate searchArticles:@""];
    }
    return YES;
}
- (void)setPlacehold:(NSString *)placehold{
    _placehold = placehold;
    self.searchBar.placeholder = placehold;
}
- (void)searchChange:(UITextField *)txField{
    MBLog(@"--");
}
- (void)initSubViews{
    self.backgroundColor = SIXColor(217, 217, 217);
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 60, 40)];
    self.searchBar = searchbar;
    //    [self setSearchBar];
    searchbar.layer.cornerRadius = 3;
    searchbar.layer.masksToBounds = YES;
    searchbar.barTintColor = SIXColor(217, 217, 217);
    //通过KVC拿到textField
    UITextField  *seachTextFild = [searchbar valueForKey:@"searchField"];
    //修改字体颜色
    seachTextFild.textColor = [UIColor redColor];
    [seachTextFild addTarget:self action:@selector(searchChange:) forControlEvents:UIControlEventValueChanged];
    //修改字体大小
    seachTextFild.font = [UIFont systemFontOfSize:14];
    seachTextFild.textColor = [UIColor darkGrayColor];
//    searchbar.delegate = self;
    self.searchBar.delegate = self;
    [self addSubview:searchbar];
    searchbar.placeholder = self.placehold;
    searchbar.barTintColor = SIXColor(217, 217, 217);
    searchbar.returnKeyType = UIReturnKeySearch;
    //    self.tableView.tableHeaderView = self.searchVeiw;
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(searchbar.frame) + 5, 5, 40, 40)];
    [searchBtn setTitle:@"搜索" forState: UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:searchBtn];
    [searchBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(beginSearchView) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)beginSearchView{
    
    if ([self.delegate respondsToSelector:@selector(searchArticles:)]) {
        [self.delegate searchArticles:self.searchStr];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([self.delegate respondsToSelector:@selector(searchArticles:)]) {
        [self.delegate searchArticles:self.searchStr];
    }
}

// 去掉SearchBar上面两条线
- (void)setSearchBar {
    
    for (UIView *obj in [self.searchBar subviews]) {
        for (UIView *objs in [obj subviews]) {
            if ([objs isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
                [objs removeFromSuperview];
            }
        }
        if ([obj isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
            [obj removeFromSuperview];
        }
    }
}

@end
