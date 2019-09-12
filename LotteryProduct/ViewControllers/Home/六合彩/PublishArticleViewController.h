//
//  PublishArticleViewController.h
//  LotteryTest
//
//  Created by 研发中心 on 2018/12/4.
//  Copyright © 2018 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYYTextView.h"
#import "RecommendlistModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PublishArticleViewController : RootCtrl
@property (weak, nonatomic) IBOutlet LYYTextView *textView;

@property (weak, nonatomic) IBOutlet LYYTextView *titleTextField;

@property (nonatomic, copy) NSString *controlerName;

@property (nonatomic, copy) NSString *content;

@property (nonatomic , assign) NSInteger   ID;





@property (nonatomic, strong)RecommendlistModel *model;

@end

NS_ASSUME_NONNULL_END
