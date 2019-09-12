//
//  DaShenHeadAvatarView.h
//  LotteryProduct
//
//  Created by pt c on 2019/9/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DaShenHeadAvatarView : UIView

/// <#assign注释#>
@property (nonatomic, assign) CGFloat imgWidht;

/// 头像
@property (nonatomic, strong) UIImageView *headImg;
/// 外圈
@property (nonatomic, strong) UIImageView *ccImg;
/// 皇冠
@property (nonatomic, strong) UIImageView *ttImg;
/// 百分比
@property (nonatomic, strong) UILabel *ppLabel;
/// 昵称
@property (nonatomic, strong) UILabel *nameLabel;

@end

NS_ASSUME_NONNULL_END
