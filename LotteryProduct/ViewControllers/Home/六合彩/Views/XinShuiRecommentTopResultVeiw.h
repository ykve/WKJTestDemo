//
//  XinShuiRecommentTopResultVeiw.h
//  LotteryProduct
//
//  Created by 研发中心 on 2019/2/18.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XinShuiRecommentTopResultVeiwDelegate <NSObject>

- (void)IsShowResultView:(UIButton *)sender;
- (void)skipToHistoryVc;

@end

@interface XinShuiRecommentTopResultVeiw : UIView
@property (weak, nonatomic) IBOutlet UIView *backView;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *numberResults;


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numberShengXiaos;

@property (weak, nonatomic) IBOutlet UILabel *dateLbl;

@property (weak, nonatomic) IBOutlet UIButton *showBtn;


@property (nonatomic,weak) id<XinShuiRecommentTopResultVeiwDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
