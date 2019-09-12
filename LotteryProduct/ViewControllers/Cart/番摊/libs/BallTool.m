//
//  BallTool.m
//  LotteryProduct
//
//  Created by pt c on 2019/4/9.
//  Copyright © 2019 vsskyblue. All rights reserved.
//

#import "BallTool.h"

@implementation BallTool
+ (UIColor *)getColorWithNum:(NSInteger)num{
    switch (num) {
        case 1:
        {
            return [UIColor colorWithHex:@"D542BB"];
        }break;
        case 2:
        {
            return [UIColor colorWithHex:@"2F90DF"];
        }break;
        case 3:
        {
            return [UIColor colorWithHex:@"FAB825"];
        }break;
        case 4:
        {
            return [UIColor colorWithHex:@"11C368"];
        }break;
        case 5:
        {
            return [UIColor colorWithHex:@"A36D55"];
        }break;
        case 6:
        {
            return [UIColor colorWithHex:@"EF3C34"];
        }break;
        case 7:
        {
            return [UIColor colorWithHex:@"66DBDD"];
        }break;
        case 8:
        {
            return [UIColor colorWithHex:@"FF8244"];
        }break;
        case 9:
        {
            return [UIColor colorWithHex:@"4EA3D9"];
        }break;
        case 10:
        {
            return [UIColor colorWithHex:@"917BFF"];
        }break;
        default:
            break;
    }
    return [UIColor colorWithHex:@"D542BB"];
}
+ (NSMutableArray *)sortingFantanWithArray:(NSMutableArray *)array{
    NSMutableArray *retArr = [NSMutableArray array];
    for(int i = 0;i<26;i++){
        [retArr addObject:@(i)];
    }
    NSArray *names = @[@"3-4角",@"3念4",@"正3",@"3念2",@"2-3角",@"4念3",@"3念1",@"番3",@"2念4",@"2念3",@"正4",@"番4",@"单",@"双",@"番2",@"正2",@"4念1",@"4念2",@"番1",@"1念3",@"2念1",@"4-1角",@"1念4",@"正1",@"1念2",@"1-2角"];
    for (Fantan_OddModel *model in array) {
        if([model.name isEqualToString:names[0]]){
            [retArr removeObjectAtIndex:0];
            [retArr insertObject:model atIndex:0];
        }else if([model.name isEqualToString:names[1]]){
            [retArr removeObjectAtIndex:1];
            [retArr insertObject:model atIndex:1];
        }else if([model.name isEqualToString:names[2]]){
            [retArr removeObjectAtIndex:2];
            [retArr insertObject:model atIndex:2];
        }else if([model.name isEqualToString:names[3]]){
            [retArr removeObjectAtIndex:3];
            [retArr insertObject:model atIndex:3];
        }else if([model.name isEqualToString:names[4]]){
            [retArr removeObjectAtIndex:4];
            [retArr insertObject:model atIndex:4];
        }else if([model.name isEqualToString:names[5]]){
            [retArr removeObjectAtIndex:5];
            [retArr insertObject:model atIndex:5];
        }else if([model.name isEqualToString:names[6]]){
            [retArr removeObjectAtIndex:6];
            [retArr insertObject:model atIndex:6];
        }else if([model.name isEqualToString:names[7]]){
            [retArr removeObjectAtIndex:7];
            [retArr insertObject:model atIndex:7];
        }else if([model.name isEqualToString:names[8]]){
            [retArr removeObjectAtIndex:8];
            [retArr insertObject:model atIndex:8];
        }else if([model.name isEqualToString:names[9]]){
            [retArr removeObjectAtIndex:9];
            [retArr insertObject:model atIndex:9];
        }else if([model.name isEqualToString:names[10]]){
            [retArr removeObjectAtIndex:10];
            [retArr insertObject:model atIndex:10];
        }else if([model.name isEqualToString:names[11]]){
            [retArr removeObjectAtIndex:11];
            [retArr insertObject:model atIndex:11];
        }else if([model.name isEqualToString:names[12]]){
            [retArr removeObjectAtIndex:12];
            [retArr insertObject:model atIndex:12];
        }else if([model.name isEqualToString:names[13]]){
            [retArr removeObjectAtIndex:13];
            [retArr insertObject:model atIndex:13];
        }else if([model.name isEqualToString:names[14]]){
            [retArr removeObjectAtIndex:14];
            [retArr insertObject:model atIndex:14];
        }else if([model.name isEqualToString:names[15]]){
            [retArr removeObjectAtIndex:15];
            [retArr insertObject:model atIndex:15];
        }else if([model.name isEqualToString:names[16]]){
            [retArr removeObjectAtIndex:16];
            [retArr insertObject:model atIndex:16];
        }else if([model.name isEqualToString:names[17]]){
            [retArr removeObjectAtIndex:17];
            [retArr insertObject:model atIndex:17];
        }else if([model.name isEqualToString:names[18]]){
            [retArr removeObjectAtIndex:18];
            [retArr insertObject:model atIndex:18];
        }else if([model.name isEqualToString:names[19]]){
            [retArr removeObjectAtIndex:19];
            [retArr insertObject:model atIndex:19];
        }else if([model.name isEqualToString:names[20]]){
            [retArr removeObjectAtIndex:20];
            [retArr insertObject:model atIndex:20];
        }else if([model.name isEqualToString:names[21]]){
            [retArr removeObjectAtIndex:21];
            [retArr insertObject:model atIndex:21];
        }else if([model.name isEqualToString:names[22]]){
            [retArr removeObjectAtIndex:22];
            [retArr insertObject:model atIndex:22];
        }else if([model.name isEqualToString:names[23]]){
            [retArr removeObjectAtIndex:23];
            [retArr insertObject:model atIndex:23];
        }else if([model.name isEqualToString:names[24]]){
            [retArr removeObjectAtIndex:24];
            [retArr insertObject:model atIndex:24];
        }else if([model.name isEqualToString:names[25]]){
            [retArr removeObjectAtIndex:25];
            [retArr insertObject:model atIndex:25];
        }
    }
    
//    for (Fantan_OddModel *model in array) {
//        if(model.ID.integerValue == 59352){
//            [retArr removeObjectAtIndex:0];
//            [retArr insertObject:model atIndex:0];
//        }else if(model.ID.integerValue == 59348){
//            [retArr removeObjectAtIndex:1];
//            [retArr insertObject:model atIndex:1];
//        }else if(model.ID.integerValue == 59358){
//            [retArr removeObjectAtIndex:2];
//            [retArr insertObject:model atIndex:2];
//        }else if(model.ID.integerValue == 59347){
//            [retArr removeObjectAtIndex:3];
//            [retArr insertObject:model atIndex:3];
//        }else if(model.ID.integerValue == 56535){
//            [retArr removeObjectAtIndex:4];
//            [retArr insertObject:model atIndex:4];
//        }else if(model.ID.integerValue == 56507){
//            [retArr removeObjectAtIndex:5];
//            [retArr insertObject:model atIndex:5];
//        }else if(model.ID.integerValue == 59346){
//            [retArr removeObjectAtIndex:6];
//            [retArr insertObject:model atIndex:6];
//        }else if(model.ID.integerValue == 56520){
//            [retArr removeObjectAtIndex:7];
//            [retArr insertObject:model atIndex:7];
//        }else if(model.ID.integerValue == 56527){
//            [retArr removeObjectAtIndex:8];
//            [retArr insertObject:model atIndex:8];
//        }else if(model.ID.integerValue == 56526){
//            [retArr removeObjectAtIndex:9];
//            [retArr insertObject:model atIndex:9];
//        }else if(model.ID.integerValue == 56541){
//            [retArr removeObjectAtIndex:10];
//            [retArr insertObject:model atIndex:10];
//        }else if(model.ID.integerValue == 56495){
//            [retArr removeObjectAtIndex:11];
//            [retArr insertObject:model atIndex:11];
//        }else if(model.ID.integerValue == 56516){
//            [retArr removeObjectAtIndex:12];
//            [retArr insertObject:model atIndex:12];
//        }else if(model.ID.integerValue == 56517){
//            [retArr removeObjectAtIndex:13];
//            [retArr insertObject:model atIndex:13];
//        }else if(model.ID.integerValue == 59337){
//            [retArr removeObjectAtIndex:14];
//            [retArr insertObject:model atIndex:14];
//        }else if(model.ID.integerValue == 59357){
//            [retArr removeObjectAtIndex:15];
//            [retArr insertObject:model atIndex:15];
//        }else if(model.ID.integerValue == 56531){
//            [retArr removeObjectAtIndex:16];
//            [retArr insertObject:model atIndex:16];
//        }else if(model.ID.integerValue == 56532){
//            [retArr removeObjectAtIndex:17];
//            [retArr insertObject:model atIndex:17];
//        }else if(model.ID.integerValue == 56492){
//            [retArr removeObjectAtIndex:18];
//            [retArr insertObject:model atIndex:18];
//        }else if(model.ID.integerValue == 56497){
//            [retArr removeObjectAtIndex:19];
//            [retArr insertObject:model atIndex:19];
//        }else if(model.ID.integerValue == 56499){
//            [retArr removeObjectAtIndex:20];
//            [retArr insertObject:model atIndex:20];
//        }else if(model.ID.integerValue == 56510){
//            [retArr removeObjectAtIndex:21];
//            [retArr insertObject:model atIndex:21];
//        }else if(model.ID.integerValue == 59342){
//            [retArr removeObjectAtIndex:22];
//            [retArr insertObject:model atIndex:22];
//        }else if(model.ID.integerValue == 59356){
//            [retArr removeObjectAtIndex:23];
//            [retArr insertObject:model atIndex:23];
//        }else if(model.ID.integerValue == 56522){
//            [retArr removeObjectAtIndex:24];
//            [retArr insertObject:model atIndex:24];
//        }else if(model.ID.integerValue == 56537){
//            [retArr removeObjectAtIndex:25];
//            [retArr insertObject:model atIndex:25];
//        }
//    }
    
    return retArr;
}
+ (NSString *)resetTheExplainTxWithString:(NSString *)str{
    NSString *retStr = [str stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    retStr = [retStr stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
    return retStr;
}
+ (BOOL)isFantanSeriesLottery:(NSInteger)lotteryId{
    NSArray *arr =  @[@(CPTBuyTicketType_Shuangseqiu),@(CPTBuyTicketType_DaLetou),@(CPTBuyTicketType_QiLecai),@(CPTBuyTicketType_NiuNiu_JiShu),@(CPTBuyTicketType_NiuNiu_AoZhou),@(CPTBuyTicketType_NiuNiu_KuaiLe),@(CPTBuyTicketType_FantanSSC),@(CPTBuyTicketType_FantanPK10),@(CPTBuyTicketType_FantanXYFT)];
    if([arr containsObject:@(lotteryId)]){
        return YES;
    }else{
        return NO;
    }
}
+ (float)heightWithFont:(float)font limitWidth:(float)width string:(NSString *)str
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:attribute
                                    context:nil].size;
    return size.height;
}
+ (NSInteger)numberOfEmptyLine:(NSString *)str{
    NSMutableArray *arr =[self calculateSubStringCount:str str:@"/n"];
    return arr.count;
}
+ (NSMutableArray*)calculateSubStringCount:(NSString *)content str:(NSString *)tab {
    int location = 0;
    NSMutableArray *locationArr = [NSMutableArray new];
    NSRange range = [content rangeOfString:tab];
    if (range.location == NSNotFound){
        return locationArr;
    }
    //声明一个临时字符串,记录截取之后的字符串
    NSString * subStr = content;
    while (range.location != NSNotFound) {
        if (location == 0) {
            location += range.location;
        } else {
            location += range.location + tab.length;
        }
        //记录位置
        NSNumber *number = [NSNumber numberWithUnsignedInteger:location];
        [locationArr addObject:number];
        //每次记录之后,把找到的字串截取掉
        subStr = [subStr substringFromIndex:range.location + range.length];
        NSLog(@"subStr %@",subStr);
        range = [subStr rangeOfString:tab];
        NSLog(@"rang %@",NSStringFromRange(range));
    }
    return locationArr;
}
+ (BOOL)isLongwaveById:(NSInteger)gameId{
    NSArray *notAllowArr = @[@(CPTBuyTicketType_XJSSC),@(CPTBuyTicketType_SSC),@(CPTBuyTicketType_TJSSC),@(CPTBuyTicketType_LiuHeCai),@(CPTBuyTicketType_PK10),@(CPTBuyTicketType_DaLetou),@(CPTBuyTicketType_PaiLie35),@(CPTBuyTicketType_HaiNanQiXingCai),@(CPTBuyTicketType_Shuangseqiu),@(CPTBuyTicketType_3D),@(CPTBuyTicketType_QiLecai)];
    for (NSNumber *num in notAllowArr) {
        if(num.integerValue == gameId){
            return YES;
        }
    }
    return NO;
}
+(CGFloat)getChatMessageHeightWithString:(NSString *)str{
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:kChatFont] };
    CGSize size = [str sizeWithAttributes:attributes ];
//    MBLog(@"===%f",SCREEN_WIDTH);
    if(size.width>SCREEN_WIDTH-80){
        size.width = SCREEN_WIDTH-80;
    }
    CGSize baseSize = CGSizeMake(size.width, 100);
    CGSize labelsize  = [str
                         boundingRectWithSize:baseSize
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kChatFont]}
                         context:nil].size;
    if(labelsize.height<kChatMiniHeight){
        labelsize.height = kChatMiniHeight;
    }
    return labelsize.height;
}
@end
