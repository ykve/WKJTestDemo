//
//  SixPhotosListCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/6/6.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "SixPhotosListCtrl.h"
#import "PhotoPreView.h"
#import "PhotoModel.h"
@interface SixPhotosListCtrl ()

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation SixPhotosListCtrl

-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumInteritemSpacing = 0;
        
        layout.minimumLineSpacing = 0;
        
        CGFloat itemWidth = (SCREEN_WIDTH - 1) / 2;
        
        layout.itemSize = CGSizeMake(itemWidth, 32);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithHex:@"dddddd"];
        //注册
        [_collectionView registerClass:[CollectionBaseCell class] forCellWithReuseIdentifier:RJCellIdentifier];
        
        [self.view addSubview:_collectionView];
        @weakify(self)
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self)
            make.edges.equalTo(self.view);
        }];
    }
    
    return _collectionView;
}

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self hiddenavView];
    
    [self initData];
}

-(void)initData {
    
    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getPhotoCategory.json" params:@{@"count":self.ID} success:^(BaseData *data) {
        @strongify(self)
        self.dataArray = data.data[@"list"];
        
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RJCellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.item];
    
    cell.titlelab.text = dic[@"name"];
    
    NSInteger row = indexPath.item ;
    
    NSInteger line = row + ((row%2==0) ? 2 : 1);
    
    cell.contentView.backgroundColor = line/2%2==1 ? WHITE : [UIColor groupTableViewBackgroundColor];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.item];
    
//    @weakify(self)
    [WebTools postWithURL:@"/lhcSg/getphotoA.json" params:@{@"type":dic[@"id"]} success:^(BaseData *data) {
        
//        @strongify(self)
        NSArray *array = [PhotoModel mj_objectArrayWithKeyValuesArray:data.data];
        
        PhotoPreView *pre = [PhotoPreView share];
        
        [pre show:array];
        
    } failure:^(NSError *error) {
        
    } showHUD:NO];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
