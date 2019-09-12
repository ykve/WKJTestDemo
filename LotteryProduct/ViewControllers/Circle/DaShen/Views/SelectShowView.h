//
//  SelectShowView.h
//  LotteryProduct
//
//  Created by pt c on 2019/7/6.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectShowView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *titleBgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,copy) void(^clickClose)(void);
@property (nonatomic,copy) void(^clickOK)(NSString *,NSString *);
@end

NS_ASSUME_NONNULL_END
