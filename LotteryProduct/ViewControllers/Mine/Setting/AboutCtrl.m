//
//  AboutCtrl.m
//  LotteryProduct
//
//  Created by vsskyblue on 2018/11/13.
//  Copyright © 2018年 vsskyblue. All rights reserved.
//

#import "AboutCtrl.h"
#import "CPTInfoManager.h"
@interface AboutCtrl ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AboutCtrl

- (void)dealloc{
    MBLog(@"%s dealloc",object_getClassName(self));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([AppDelegate shareapp].wkjScheme == Scheme_LotterHK) {
        
        self.textView.text = @"【香港彩票】最权威的彩票行业资讯,最便捷的网络购彩平台！\n我们以“娱乐、公益、诚信、责任”为核心价值观；\n以“一切为了彩民、为了彩民的一切，为了一切的彩民”为经营理念；\n以“彩民为本、产品体验服务于客户”为原则；\n 我们精益求精地提升服务质量！为广大彩民提供便捷、安全、愉悦的购彩体验！";

    }else if([AppDelegate shareapp].wkjScheme == Scheme_LotterEight){
     
        self.textView.text = @"【008】为广大彩民提供优质详尽的彩票资讯和细致入微的专业服务，为彩民朋友提供第一手的彩市信息；最安全、彩种齐全的专业彩票网站！\n【008】是彩票行业正在掘起的企业，是中国领先的网络彩票电话投注电子商务运营商，公司拥有购彩网站“008”。立足于对彩票行业、互联网及移动互联网的深刻理解，凭借领先的理念和技术，娱彩构建出新一代的网络彩票交易代购平台，拥有全新交互体验的互联网彩票系统，为中国彩民提供最优质的互联网及移动互联网彩票代购服务业务！\n【008】以专业+优质，彩种结构合理+产品线完善，因此获得了广大彩民的大力推崇，每天都有数万活跃用户在平台上体验着贴心的购彩服务。日益剧增的用户群，一路飙升的中奖率，不断刷新的大奖纪录，正成为广大彩民的风水宝地，正大步奔向互联网、中国移动互联网彩票行业的龙头位置！";
    }else{
        self.textView.text = @"进入彩票通，开启幸运大门。\n上海彩票通网络科技有限公司成立于2016年，实收资本5000万元，公司核心团队由来自知名互联网公司的管理人才所组成，这是中国互联网彩票创始团队建立的企业平台。\n彩票通是彩票行业正在掘起的企业，是中国领先的网络彩票电话投注电子商务运营商，公司拥有购彩网站“彩票通”。立足于对彩票行业、互联网及移动互联网的深刻理解，凭借领先的理念和技术，彩票构建出新一代的网络彩票交易代购平台，拥有全新交互体验的互联网彩票系统，为中国彩民提供最优质的互联网及移动互联网彩票代购服务业务。\n 彩票通以“娱乐、公益、诚信、责任”为核心价值观，以“一切为了彩民、为了彩民的一切，为了一切的彩民”为经营理念，坚持以彩民为本、产品体验服务于客户为原则，精益求精地提升服务质量。公司依托网络、通信和数字电视技术，通过网络、电话、手机、短信、数字电视、电子杂志、电子邮件和平面媒体等多样化服务手段，为广大彩民提供全国各大联销型彩票及各地地方彩票的代购合买、彩票软件、彩票资讯等综合服务，以及便捷、安全、愉悦的购彩体验。\n专业+优质，彩种结构合理+产品线完善，彩票通因此获得了广大彩民的大力推崇，每天都有数万活跃用户在平台上体验着贴心的购彩服务。日益剧增的用户群，一路飙升的中奖率，不断刷新的大奖纪录，彩票通正成为广大彩民的风水宝地，正大步奔向互联网、中国移动互联网彩票行业的龙头位置。";

    }
    [[CPTInfoManager shareManager] checkModelCallBack:^(CPTInfoModel * _Nonnull model, BOOL isSuccess) {
        if(isSuccess){
            self.textView.text = model.aboutUs;
        }
    }];
}




@end
