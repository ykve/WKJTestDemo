//
//  Tools.m
//  Qianyaso
//
//  Created by vsskyblue on 16/9/28.
//  Copyright © 2016年 vsskyblue. All rights reserved.
//

#import "Tools.h"
#import <CommonCrypto/CommonDigest.h>
//获取mac
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
//#import <Photos/Photos.h>
#import "CartSixModel.h"
#import "CartHomeModel.h"
#import "CircleModel.h"
@implementation Tools

#pragma mark - 创建UILable方法
+(UILabel *) createLableWithFrame:(CGRect)frame
                         andTitle:(NSString *)title
                          andfont:(UIFont *)font
                    andTitleColor:(UIColor *)titleColor
               andBackgroundColor:(UIColor *)backgroundColor
                 andTextAlignment:(NSTextAlignment)textAlignment
{
    //创建UILable对象并设置位置大小
    UILabel * lable = [[UILabel alloc]initWithFrame:frame];
    //设置标题
    lable.text = title;
    //设置字体颜色
    lable.textColor = titleColor;
    //设置背景颜色
    lable.backgroundColor = backgroundColor;
    //设置字体大小
    lable.font = font;
    //设置字体格式
    lable.textAlignment = textAlignment;
    //设置阴影
    //    lable.shadowColor = [UIColor blackColor];
    //    lable.shadowOffset = CGSizeMake(0, -2);
    
    return lable ;
}

#pragma mark -创建UIButton方法
+(UIButton *) createButtonWithFrame:(CGRect)frame
                           andTitle:(NSString *)title
                      andTitleColor:(UIColor *)titleColor
                 andBackgroundImage:(UIImage *)backgroundImage
                           andImage:(UIImage *)Image
                          andTarget:(id)target
                          andAction:(SEL)sel
                            andType:(UIButtonType)type
{
    //创建UIButton并设置类型
    UIButton * btn = [UIButton buttonWithType:type];
    //设置按键位置和大小
    btn.frame = frame;
    //设置按键名
    [btn setTitle:title forState:UIControlStateNormal];
    //设置按键名字体颜色
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    //背景图片
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    //图片
    [btn setImage:Image forState:UIControlStateNormal];
    //设置按键响应方法
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    btn.titleLabel.font = [UIFont fontWithName:@"Verdana" size:15];
    
    return btn;
}

#pragma mark -uitextfield
+(UITextField *) creatFieldWithFrame:(CGRect)frame
                      andPlaceholder:(NSString *)placeholder
                             andFont:(UIFont *)font
                    andTextAlignment:(NSTextAlignment)textAlignment
                        andTextColor:(UIColor *)textColor
{
    UITextField *field = [[UITextField alloc]initWithFrame:frame];
    
    field.placeholder = placeholder;
    
    field.font = font;
    
    field.textAlignment = textAlignment;
    
    field.textColor = textColor;
    
    return field;
}

#pragma mark - 获取uilable高度
+(float) createLableHighWithString:(NSString *)string andfontsize:(int)font andwithwidth:(float)width{
    
    NSLog(@"%@",string);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size.height;
}

#pragma mark - 获取uilable宽度
+ (float) createLableWidthWithString:(NSString *)string andfontsize:(int)font andwithhigh:(float)high{
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, high) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size.width;
}

#pragma mark -32位MD5加密方式
+ (NSString *)getMd5WithString:(NSString *)sourceString{
    
    if(!sourceString){
        return nil;//判断sourceString如果为空则直接返回nil。
    }
    
    
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *cString = sourceString.UTF8String;
    //创建一个C语言的字符数组，用来接收加密结束之后的字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //MD5计算（也就是加密）
    //第一个参数：需要加密的字符串
    //第二个参数：需要加密的字符串的长度
    //第三个参数：加密完成之后的字符串存储的地方
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    //将加密完成的字符拼接起来使用（16进制的）。
    //声明一个可变字符串类型，用来拼接转换好的字符
    NSMutableString *resultString = [[NSMutableString alloc]init];
    //遍历所有的result数组，取出所有的字符来拼接
    for (int i = 0;i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString  appendFormat:@"%02x",result[i]];
        //%02x：x 表示以十六进制形式输出，02 表示不足两位，前面补0输出；超出两位，不影响。当x小写的时候，返回的密文中的字母就是小写的，当X大写的时候返回的密文中的字母是大写的。
    }
    //打印最终需要的字符
    NSLog(@"resultString === %@",resultString);
    return resultString;
    
    
    
    //    const char *cStr = [sourceString UTF8String];
    //    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    //    CC_MD5( cStr, strlen(cStr), digest );
    //    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    //    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    //        [result appendFormat:@"%02x", digest[i]];
    //
    //    return result;
    
}

+ (NSString*)getMD5WithData:(NSData *)data{
    
    if (!data) {
        return nil;//判断sourceString如果为空则直接返回nil。
    }
    //需要MD5变量并且初始化
    CC_MD5_CTX  md5;
    CC_MD5_Init(&md5);
    //开始加密(第一个参数：对md5变量去地址，要为该变量指向的内存空间计算好数据，第二个参数：需要计算的源数据，第三个参数：源数据的长度)
    CC_MD5_Update(&md5, data.bytes, (CC_LONG)data.length);
    //声明一个无符号的字符数组，用来盛放转换好的数据
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //将数据放入result数组
    CC_MD5_Final(result, &md5);
    //将result中的字符拼接为OC语言中的字符串，以便我们使用。
    NSMutableString *resultString = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString appendFormat:@"%02X",result[i]];
    }
    NSLog(@"resultString=========%@",resultString);
    return  [resultString lowercaseString];
}


+(NSString*)URLDecodedString:(NSString*)str
{
    NSCharacterSet *encode_set= [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *urlString_encode = [str stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
    
    return urlString_encode;
    
}

#pragma mark -获取当前时间
+ (NSString*)getlocaleDate{
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
}

#pragma mark - 获取当前日期
+(NSString *)getlocaletime {
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *time = [dateformatter stringFromDate:senddate];
    
    return time;
}

#pragma mark - 获取几天后时间
+ (NSString *)GetTomorrowDays:(NSInteger)days {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    [components setDay:([components day]+days)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

#pragma mark - 获取当前时间戳
+(NSString *)getlocaleChuo{
    
    NSTimeInterval newtime=[[NSDate date] timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%ld",(long)newtime];
}

#pragma mark -时间戳传成YYYY-MM-dd
+(NSString *)chuototime:(NSTimeInterval)time{
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    NSString *timestring = [dateFormatter stringFromDate: detaildate];
    
    return timestring;
}
#pragma mark -时间戳传成yyyy.MM.dd HH:mm
+(NSString *)chuototimedian:(NSTimeInterval)time{
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    
    NSString *timestring = [dateFormatter stringFromDate: detaildate];
    
    return timestring;
}

+(NSString *)chuototimedian2:(NSTimeInterval)time{
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    
    NSString *timestring = [dateFormatter stringFromDate: detaildate];
    
    return timestring;
}


#pragma mark - 时间转时间戳
+(NSString *)returntimetochuo:(NSString *)time{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //创建了日期对象
    NSDate *date1=[dateFormatter dateFromString:time];
    
    NSTimeInterval newtime=[date1 timeIntervalSince1970];
    
    NSLog(@"%ld",(long)newtime);
    return [NSString stringWithFormat:@"%ld",(long)newtime];
}

#pragma mark - 时间戳转时间
+(NSString *)returnchuototime:(NSString *)chuo{
    
    NSTimeInterval time=[chuo doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *timestring = [dateFormatter stringFromDate: detaildate];
    
    return timestring;
}
#pragma mark - 时间戳转Date
+(NSDate *)returnchuotodate:(NSInteger)chuo {
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:chuo];
    
    return detaildate;
}

#pragma mark -字符串转换成时间
+ (NSDate *)dateFromString:(NSString *)string{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

#pragma mark -获取星期
+(NSString *)getweek:(NSInteger)chuo{
    
    NSDateFormatter*format=[[NSDateFormatter alloc]init];
    format.dateFormat=@"c";
    NSString*week= [format stringFromDate:[NSDate dateWithTimeIntervalSince1970:chuo]];
    NSInteger weekint = [week integerValue];
    if (weekint-1 ==1) {
        week = @"周一";
    }else  if (weekint-1 ==2) {
        week = @"周二";
    }else  if (weekint-1==3) {
        week = @"周三";
    }else  if (weekint-1==4) {
        week = @"周四";
    }else  if (weekint-1==5) {
        week = @"周五";
    }else  if (weekint-1==6) {
        week = @"周六";
    }else  if (weekint-1==7) {
        week = @"周日";
    }
    
    return week;
}

#pragma mark -传入 秒  得到  xx分钟xx秒
+(NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    NSLog(@"format_time : %@",format_time);
    
    return format_time;
    
}

#pragma mark - 获取当前年月日时分秒星期
+(void)getcurrentDate:(void (^)(NSInteger, NSInteger, NSInteger, NSInteger, NSInteger, NSInteger, NSString *))date{
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    NSInteger week = [componets weekday];
    NSString *weekstr = [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week-1]];
    
    date(year,month,day,hour,minute,second,weekstr);
}

#pragma mark - 获取某一天的年月日时分秒
+(void)getDateWithDate:(NSDate*)date success:(void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second ,NSString *week))dateInfo{
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    
    NSLog(@"now date is: %@", date);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    NSInteger week = [componets weekday];
    NSString *weekstr = [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week-1]];
    
    dateInfo(year,month,day,hour,minute,second,weekstr);
}

#pragma mark - 获取某一天的年月日时分秒
+(void)getDateWithTime:(NSInteger)time success:(void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second ,NSString *week))dateInfo{
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    
    NSDate *date = [Tools returnchuotodate:time];
    
    NSLog(@"now date is: %@", date);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    NSInteger week = [componets weekday];
    NSString *weekstr = [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week-1]];
    
    dateInfo(year,month,day,hour,minute,second,weekstr);
}

#pragma mark - 获取当前周的周一至周日的时间
+(NSString *)gettodayweek{
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    // 获取今天是周几
    NSInteger weekDay = [comp weekday];
    // 获取几天是几号
    NSInteger day = [comp day];
    NSLog(@"%ld----%ld",(long)weekDay,(long)day);
    
    // 计算当前日期和本周的星期一和星期天相差天数
    long firstDiff,lastDiff;
    //    weekDay = 1;
    if (weekDay == 1)
    {
        firstDiff = -6;
        lastDiff = 0;
    }
    else
    {
        firstDiff = [calendar firstWeekday] - weekDay + 1;
        lastDiff = 8 - weekDay;
    }
    NSLog(@"firstDiff: %ld   lastDiff: %ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    NSString *firstDay = [formatter stringFromDate:firstDayOfWeek];
    NSString *lastDay = [formatter stringFromDate:lastDayOfWeek];
    NSLog(@"%@=======%@",firstDay,lastDay);
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@",firstDay,lastDay];
    
    return dateStr;
    
}

//比较两个日期的大小  日期格式为2016-08-14 08：46：20
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    int ci;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    
    if(result==NSOrderedAscending){
        
        //date02比date01大
        ci=1;
    }
    else if (result==NSOrderedDescending){
        //date02比date01小
        ci = -1;
    }
    else {
        //date02=date01
        ci = 0;
    }
    
    return ci;
    
}

+(NSInteger)getthismonthdays{
    
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:nowDate];
    
    NSInteger year = [comp year];
    
    NSInteger month = [comp month];
    
    return [Tools getmonthdaysWith:year Withmonth:month];
}

+(NSInteger)getmonthdaysWith:(NSInteger )year Withmonth:(NSInteger)month{
    
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
    
}

#pragma mark - 获取当前版本号
+ (NSString*)getnowVersion {
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    return nowVersion;
}
#pragma mark - 获取BundleID
+(NSString*) getBundleID {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

#pragma mark - 获取app的名字
+(NSString*) getAppName {
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    
    return appName;
}
#pragma MARK - 获取uudi
+ (NSString *)getuuid{
    
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
    
    
    if (keychainStore[@"uuid"]) {
        
        return keychainStore[@"uuid"];
    }
    else {
        
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        assert(uuid != NULL);
        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
        
        [keychainStore setString:(__bridge NSString *)(uuidStr) forKey:@"uuid"];
        
        return (__bridge NSString *)(uuidStr);
    }
    
}

#pragma mark--纯数字
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
#pragma mark - 是否包含中文
+ (BOOL)hasChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark -unicode转码
+ (NSString *)utf8ToUnicode:(NSString *)string

{
    
    NSUInteger length = [string length];
    
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
    for (int i = 0;i < length; i++)
        
    {
        
        unichar _char = [string characterAtIndex:i];
        
        
        
        if(_char >= 0 && _char <= 255)
            
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
        }
        
        else
            
        {
            NSString *str=[string substringWithRange:NSMakeRange(i, 1)];
            
            NSString *strutf8 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [s appendFormat:@"%@",strutf8];
            //  [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
            
            
        }
        
    }
    
    return s;
    
}

#pragma mark -json解析
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark - 字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if(dic == nil){
        
        return @"";
    }
    if(dic.allKeys.count == 0) {
        
        return @"";
    }
    NSError *parseError = [NSError new];
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:&parseError];
    NSString * jsonstr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonstr;
}

#pragma mark -普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
#pragma mark -流转16进制
+ (NSString *)hexStringFromdatabyte:(NSData *)data{
    //    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


#pragma mark - 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
    
}

#pragma mark - 去掉html标签
+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}


#pragma mark -邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark -电话号码
+ (BOOL) validatetelphone:(NSString *)telphone{
    
    NSString *telphoneRegex = @"\\d{3}-\\d{8}|\\d{4}-\\d{7}";
    NSPredicate *telphoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telphoneRegex];
    return [telphoneTest evaluateWithObject:telphone];
    
}


#pragma mark -手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    // NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"0{0,1}1[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark -密码
+ (BOOL) validatePassword:(NSString *)string
{
    NSString *passWordRegex = @"^[0-9a-zA-Z_]{1,}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:string];
    
    
    /**
     //验证该字符串是否是6-16位字母和数字组合
     if (string.length < 6 || string.length > 20)
     {
     return NO;
     }
     NSString *regex = @"^[A-Za-z0-9]+$";
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
     if ([predicate evaluateWithObject:string]) {
     if ([self hasDigital:string] && [self hasLetter:string]) {
     return YES;
     }else{
     return NO;
     }
     }else{
     return NO;
     }
     */
}

#pragma mark -昵称
+ (BOOL) validateNickname:(NSString *)string
{
    NSString *nicknameRegex = @"^[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    NSPredicate *nicknamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [nicknamePredicate evaluateWithObject:string];
    
    
    /**
     只含有汉字、数字、字母、下划线不能以下划线开头和结尾
     
     ^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$
     
     只含有汉字、数字、字母、下划线，下划线位置不限
     
     ^[a-zA-Z0-9_\u4e00-\u9fa5]+$
     */
}

/**
 *  是否有数字
 *
 *  @param string 字符串
 *
 *  @return YES 有数字 ，NO 没有数字
 */
+ (BOOL)hasDigital:(NSString *)string
{
    for(int i = 0; i < string.length ; i++){
        unichar a = [string characterAtIndex:i];
        if ((a >= '0' && a <= '9' )) {
            return YES;
        }
    }
    return NO;
}

/**
 *  是否有字母
 *
 *  @param string 字符串
 *
 *  @return YES 有字母 ，NO 没有字母
 */
+ (BOOL)hasLetter:(NSString *)string
{
    for(int i = 0; i < string.length ; i++){
        unichar a = [string characterAtIndex:i];
        if ((a >= 'A' && a <= 'Z' ) || (a >= 'a' && a <= 'z')) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -身份证号
+ (BOOL) validateIdentityCard: (NSString *)IDCardNumber
{
    /*----旧版比较泛
     BOOL flag;
     if (IDCardNumber.length <= 0) {
     flag = NO;
     return flag;
     }
     NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
     NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
     return [identityCardPredicate evaluateWithObject:IDCardNumber];
     */
    
    IDCardNumber = [IDCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([IDCardNumber length] != 18)
    {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:IDCardNumber]){
        return NO;
    }
    int summary = ([IDCardNumber substringWithRange:NSMakeRange(0,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(10,1)].intValue) *7+ ([IDCardNumber substringWithRange:NSMakeRange(1,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(11,1)].intValue) *9+ ([IDCardNumber substringWithRange:NSMakeRange(2,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(12,1)].intValue) *10+ ([IDCardNumber substringWithRange:NSMakeRange(3,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(13,1)].intValue) *5+ ([IDCardNumber substringWithRange:NSMakeRange(4,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(14,1)].intValue) *8+ ([IDCardNumber substringWithRange:NSMakeRange(5,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(15,1)].intValue) *4+ ([IDCardNumber substringWithRange:NSMakeRange(6,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(16,1)].intValue) *2+ [IDCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [IDCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6+ [IDCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    NSString *laststr = [[IDCardNumber substringWithRange:NSMakeRange(17,1)] uppercaseString];
    return [checkBit isEqualToString:laststr];
}

#pragma mark - 银行卡输入4位空一格
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    [textField setText:newString];
    
    return NO;
    
}

#pragma mark - 去掉空格
+ (NSString *)deleteBlank:(NSString *)string
{
    NSString *newString= [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newString;
}

#pragma mark -去掉空格及空行
+ (NSString *)deleteBlankAndEnter:(NSString *)string
{
    NSString *newString= [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    newString= [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newString= [newString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return newString;
}

#pragma mark - 两时间差
+(NSString *)intervaldate:(NSString *)time1 Withdate:(NSString *)time2{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    //创建了两个日期对象
    NSDate *date1=[dateFormatter dateFromString:time1];
    NSDate *date2=[dateFormatter dateFromString:time2];
    //NSDate *date=[NSDate date];
    //NSString *curdate=[dateFormatter stringFromDate:date];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    NSLog(@"%d",(int)time);
    
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    
    return dateContent;
}

#pragma mark - 距当前时间差
+(NSString *)getUTCFormateDate:(NSString *)newsDate
{
    //    newsDate = @"2013-08-09 17:01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"newsDate = %@",newsDate);
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate* current_date = [[NSDate alloc] init];
    
    NSTimeInterval time=[current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    
    int day15 = 15*24*3600;
    
    NSString *dateContent;
    
    if(day15>(int)time){
        
        int days=(day15-(int)time)/(3600*24);
        int hours=(day15-(int)time)%(3600*24)/3600;
        
        dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    }
    else{
        
        dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",0,0];
    }
    
    //    if(month!=0){
    //
    //        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",month,@"个月前"];
    //
    //    }else if(days!=0){
    //
    //        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",days,@"天前"];
    //    }else if(hours!=0){
    //
    //        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",hours,@"小时前"];
    //    }else {
    //
    //        dateContent = [NSString stringWithFormat:@"%@%i%@",@"   ",minute,@"分钟前"];
    //    }
    
    
    
    return dateContent;
}

#pragma mark - 设置图片圆角
+(void)setCornerRadiusWith:(UIImageView *)headimgv WithRadius:(CGFloat)radius{
    
    [headimgv.layer setCornerRadius:radius];
    [headimgv.layer setMasksToBounds:YES];
    [headimgv setContentMode:UIViewContentModeScaleAspectFill];
    [headimgv setClipsToBounds:YES];
}

#pragma mark - 判断document中是否存在某文件
+ (BOOL) isFileExist:(NSString *)fileName
{
    NSString * cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path=[NSString stringWithFormat:@"%@/%@",cacheDirectory,fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:path];
    return result;
}

#pragma mark - 动态获取textview大小
+ (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView
{
    //实际textView显示时我们设定的宽
    CGFloat contentWidth = CGRectGetWidth(textView.frame);
    //但事实上内容需要除去显示的边框值
    CGFloat broadWith    = (textView.contentInset.left + textView.contentInset.right
                            + textView.textContainerInset.left
                            + textView.textContainerInset.right
                            + textView.textContainer.lineFragmentPadding/*左边距*/
                            + textView.textContainer.lineFragmentPadding/*右边距*/);
    
    CGFloat broadHeight  = (textView.contentInset.top
                            + textView.contentInset.bottom
                            + textView.textContainerInset.top
                            + textView.textContainerInset.bottom);//+self.textview.textContainer.lineFragmentPadding/*top*//*+theTextView.textContainer.lineFragmentPadding*//*there is no bottom padding*/);
    
    //由于求的是普通字符串产生的Rect来适应textView的宽
    contentWidth -= broadWith;
    
    CGSize InSize = CGSizeMake(contentWidth, MAXFLOAT);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = textView.textContainer.lineBreakMode;
    NSLog(@"%@--%@",textView.font,[paragraphStyle copy]);
    textView.font = [UIFont systemFontOfSize:14];
    NSDictionary *dic = @{NSFontAttributeName:textView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};
    
    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);//ceilf(calculatedSize.height)
    return adjustedSize;
}

#pragma mark - 字符串用，拼接
+(NSString *)appenddatafromeArray:(NSArray *)list{
    
    if(list.count==0){
        
        return nil;
    }
    NSMutableString *uidstring = [[NSMutableString alloc]init];
    
    for (int i=0; i<list.count; i++) {
        
        NSString *invistr = [list objectAtIndex:i];
        
        [uidstring appendString:[NSString stringWithFormat:@"%@,",invistr]];
    }
    
    NSString *result = [uidstring substringToIndex:[uidstring length]-1];
    
    return result;
    
}

#pragma mark - 生成二维码
+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

#pragma mark 画圆角头像
+ (UIImage *)circleImage:(UIImage *)originalimg
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(originalimg.size);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 矩形框
    CGRect rect = CGRectMake(0, 0, originalimg.size.width, originalimg.size.height);
    
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    
    // 往圆上面画一张图片
    [originalimg drawInRect:rect];
    
    // 获得上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 设置评论名字属性
+(NSMutableAttributedString *)setcommentAttributedWithstring:(NSString *)string Withname:(NSString *)nickname Withpid_name:(NSString *)pid_name{
    
    if(pid_name){
        
        NSString *totalstring = [NSString stringWithFormat:@"%@回复%@:%@",nickname,pid_name,string];
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:totalstring];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor colorWithHex:@"012D87"]
         
                              range:NSMakeRange(0, nickname.length)];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor colorWithHex:@"012D87"]
         
                              range:NSMakeRange(nickname.length+2, pid_name.length)];
        
        return AttributedStr;
    }
    else{
        
        NSString *totalstring = [NSString stringWithFormat:@"%@:%@",nickname,string];
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:totalstring];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor colorWithHex:@"012D87"]
         
                              range:NSMakeRange(0, nickname.length)];
        
        return AttributedStr;
    }
    
}


#pragma mark - 获取字符串中的数字
+(NSInteger)getnumberfrome:(NSString *)string{
    
    /*
     NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
     
     NSInteger remainSecond =[[string stringByTrimmingCharactersInSet:nonDigits] integerValue];
     
     return remainSecond;
     */
    
    NSString*strRegex=@"^(\\d)*$";
    NSPredicate*predict=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",strRegex];
    
    return [predict evaluateWithObject:string];
}

#pragma mark -判断是否是第一次启动
+ (BOOL)isFirstLaunching{
    
    BOOL firstLaunching = false;
    
    NSUserDefaults *UserDefaultUtil = [NSUserDefaults standardUserDefaults];
    
    NSString *lastAppVersion =  [UserDefaultUtil valueForKey:@"LastAppVersion"];
    
    NSString *currentAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    if ([lastAppVersion floatValue] < [currentAppVersion floatValue])
    {
        [UserDefaultUtil setValue:currentAppVersion forKey:@"LastAppVersion"];
        
        firstLaunching = true;
    }
    
    return firstLaunching;
}

#pragma mark -判断字符串是否为空
+(BOOL)isEmptyOrNull:(NSString *)str{
    
    if (!str || [str isKindOfClass:[NSNull class]])
    {
        // null object
        return true;
    } else {
        NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            
            // empty string
            return true;
        }
        else{
            // is neither empty nor null
            return false;
        }
        
    }
}

#pragma mark -格式化浮点数
+(NSString *)formaterDoubleString:(double)doublevalue{
    
    NSString *doubleStr = [NSString stringWithFormat:@"%.2f",doublevalue];
    NSRange pointRange = [doubleStr rangeOfString:@"."];
    if (pointRange.length > 0) {
        //包含小数点
        if ([[doubleStr substringWithRange:NSMakeRange(pointRange.location+2, 1)] isEqualToString:@"0"]) {
            //最后一位为0
            if ([[doubleStr substringWithRange:NSMakeRange(pointRange.location+1, 1)] isEqualToString:@"0"]) {
                //小数点后一位为0
                doubleStr = [NSString stringWithFormat:@"%.f",doublevalue];
            }
            else{
                doubleStr = [NSString stringWithFormat:@"%.1f",doublevalue];
            }
        }
    }
    else{
        //整数
        doubleStr = [NSString stringWithFormat:@"%.f",doublevalue];
    }
    return doubleStr;
}

#pragma mark - 纯色生成图片
+ (UIImage *)createImageWithColor:(UIColor *)color Withsize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//图片添加图片水印
+ (UIImage *)addWatermarkWithImage:(UIImage *)image watermarkImage:(UIImage *)watermarkImage rect:(CGRect)rect{
    
    watermarkImage = [self imageByApplyingAlpha:0.7 image:watermarkImage];
    
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    // 创建一个graphics context来画我们的东西
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0, 0, w, h)];
    // 然后在把hat画在合适的位置
    [watermarkImage drawInRect:rect];
    // 通过下面的语句创建新的UIImage
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 最后，我们必须得清理并关闭这个再也不需要的context
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
//图片半透明
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 获取view图片
+ (UIImage *) imageWithView:(UIView *)view Withsize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (void)loadImageFinished:(UIImage *)image With:(void (^)(BOOL success))result
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        
        result(success);
    }];
}

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

#pragma mark - 渐变色
+ (CAGradientLayer *)rj_creatGradientLayer:(NSArray *)colors frame:(CGRect)frame {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.frame = frame;
    gradientLayer.colors = colors;
    
    gradientLayer.startPoint = CGPointMake(1, 1);
    
    gradientLayer.endPoint = CGPointMake(0, 0);
//     gradientLayer.locations = @[@(0.5f), @(1.0f)];
    return gradientLayer;
}

#pragma mark - 是否新版
+ (BOOL)isLead
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        return NO;
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
}

//以maskImage的形状为遮罩，绘画出一个相同形状的图片，黑色遮罩可绘制
+ (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage
{
    
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef sourceImage = [image CGImage];
    
    CGImageRef imageWithAlpha = sourceImage;
    //add alpha channel for images that don't have one (ie GIF, JPEG, etc...)
    //this however has a computational cost
    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone)
    {
        imageWithAlpha = [Tools CopyImageAndAddAlphaChannel:sourceImage];
    }
    
    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
    CGImageRelease(mask);
    
    //release imageWithAlpha if it was created by CopyImageAndAddAlphaChannel
    if (sourceImage != imageWithAlpha)
    {
        CGImageRelease(imageWithAlpha);
    }
    
    UIImage* retImage = [UIImage imageWithCGImage:masked];
    
    CGImageRelease(masked);
    
    return retImage;
}
//给图片设置alpha通道
+ (CGImageRef)CopyImageAndAddAlphaChannel:(CGImageRef)sourceImage
{
    CGImageRef retVal = NULL;
    
    size_t width = CGImageGetWidth(sourceImage);
    size_t height = CGImageGetHeight(sourceImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL, width, height,
                                                          8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    
    if (offscreenContext != NULL)
    {
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), sourceImage);
        retVal = CGBitmapContextCreateImage(offscreenContext);
        CGContextRelease(offscreenContext);
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return retVal;
}


#pragma mark -根据图片url获取网络图片尺寸
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        //以下是对手机32位、64位的处理（由网友评论区拿到的：小怪兽饲养猿）
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            CFRelease(imageProperties);
        }
        
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}


#pragma mark - 图片变灰
+(UIImage *)changeGrayImage:(UIImage *)oldImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = oldImage.size.width;
    int height = oldImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), oldImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

#pragma mark -  图片转base64
+(NSString *)imagetobase64:(UIImage *)image{
    
    NSData *data = UIImagePNGRepresentation(image);
    
    NSString *encodeStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSString *endstr = [NSString stringWithFormat:@"%@%@",@"data:image/png;base64,",encodeStr];
    
    return endstr;
}


#pragma mark - 判断图片类型
+ (NSString *)typeForImageData:(NSData *)data {
    
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    
    
    switch (c) {
            
        case 0xFF:
            
            return @"image/jpeg";
            
        case 0x89:
            
            return @"image/png";
            
        case 0x47:
            
            return @"image/gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"image/tiff";
            
    }
    
    return nil;
}

+(BOOL)string:(NSString *)string containof:(NSString *)str {
    
    NSRange range = [string rangeOfString:str];
    
    if(range.location != NSNotFound)
        
    {
        return YES;
    }
    return NO;
}

+(float)folderSizeAtPath:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *cachePath= path;
    long long folderSize=0;
    if ([fileManager fileExistsAtPath:cachePath])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles)
        {
            NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
            
            long long size=[fileManager attributesOfItemAtPath:fileAbsolutePath error:nil].fileSize;
            
            folderSize += size;
        }
        
        //        return folderSize/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

#pragma mark - 将文本多个空格转为一个空格
+(NSString *)getmoreblanktoone:(NSString *)text {
    
    //正则表达式替换两个以上的空格为一个空格
    
    NSError *error = nil;
    
    NSString *newtext = text;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s{2,}" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *arr = [regex matchesInString:text options:NSMatchingReportCompletion range:NSMakeRange(0, [text length])];
    
    arr = [[arr reverseObjectEnumerator] allObjects];
    
    for (NSTextCheckingResult *str in arr) {
        
        newtext = [newtext stringByReplacingCharactersInRange:[str range] withString:@" "];
        
    }
    
    
    NSLog(@"%@", newtext);
    return newtext;
    
}


#pragma mark - 获取中国农历年份及生肖
+ (NSString *)getChineseYearWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛巳",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸卯",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year - 1];
    
    NSString *Cz_str = nil;
    if ([y_str hasSuffix:@"子"]) {
        Cz_str = @"鼠";
    }else if ([y_str hasSuffix:@"丑"]){
        Cz_str = @"牛";
    }else if ([y_str hasSuffix:@"寅"]){
        Cz_str = @"虎";
    }else if ([y_str hasSuffix:@"卯"]){
        Cz_str = @"兔";
    }else if ([y_str hasSuffix:@"辰"]){
        Cz_str = @"龙";
    }else if ([y_str hasSuffix:@"巳"]){
        Cz_str = @"蛇";
    }else if ([y_str hasSuffix:@"午"]){
        Cz_str = @"马";
    }else if ([y_str hasSuffix:@"未"]){
        Cz_str = @"羊";
    }else if ([y_str hasSuffix:@"申"]){
        Cz_str = @"猴";
    }else if ([y_str hasSuffix:@"酉"]){
        Cz_str = @"鸡";
    }else if ([y_str hasSuffix:@"戌"]){
        Cz_str = @"狗";
    }else if ([y_str hasSuffix:@"亥"]){
        Cz_str = @"猪";
    }
    
    return  [NSString stringWithFormat:@"%@,%@",y_str,Cz_str];
}

/**
 六合彩数字选背景图
 */
+(UIImage *)numbertoimage:(NSString *)string Withselect:(BOOL)select{
    
    UIImage *image = nil;
    
    if ([string isEqualToString:@"01"] || [string isEqualToString:@"1"] || [string isEqualToString:@"02"]|| [string isEqualToString:@"2"] || [string isEqualToString:@"07"] || [string isEqualToString:@"7"]|| [string isEqualToString:@"08"] || [string isEqualToString:@"8"]|| [string isEqualToString:@"12"] || [string isEqualToString:@"13"] || [string isEqualToString:@"18"] || [string isEqualToString:@"19"] || [string isEqualToString:@"23"] || [string isEqualToString:@"24"] || [string isEqualToString:@"29"] || [string isEqualToString:@"30"] || [string isEqualToString:@"34"] || [string isEqualToString:@"35"] || [string isEqualToString:@"40"] || [string isEqualToString:@"45"] || [string isEqualToString:@"46"]) {
        
//        if (select) {
//
//            return IMAGE(@"sixred_1");
//        }
        NSString *sixRedBallName = [[CPTThemeConfig shareManager] SixRedBallName];
        return IMAGE(sixRedBallName);
    }
    else if ([string isEqualToString:@"03"] || [string isEqualToString:@"3"]|| [string isEqualToString:@"04"] || [string isEqualToString:@"4"]|| [string isEqualToString:@"09"]|| [string isEqualToString:@"9"] || [string isEqualToString:@"10"] || [string isEqualToString:@"14"] || [string isEqualToString:@"15"] || [string isEqualToString:@"20"] || [string isEqualToString:@"25"] || [string isEqualToString:@"26"] || [string isEqualToString:@"31"] || [string isEqualToString:@"36"] || [string isEqualToString:@"37"] || [string isEqualToString:@"41"] || [string isEqualToString:@"42"] || [string isEqualToString:@"47"] || [string isEqualToString:@"48"]) {
        
//        if (select) {
//
//            return IMAGE(@"sixblue_1");
//        }
        NSString *sixBlueBallName = [[CPTThemeConfig shareManager] SixBlueBallName];

        return IMAGE(sixBlueBallName);
    }
    else {
        
//        if (select) {
//            
//            return IMAGE(@"sixgreen_1");
//        }
        
        NSString *sixGreenBallName = [[CPTThemeConfig shareManager] SixGreenBallName];
        
        return IMAGE(sixGreenBallName);
    }
    
    return image;
}

/**
 六合彩数字选背景图
 */
+(UIImage *)sixnumberSelectimage:(NSString *)string{
    
    UIImage *image = nil;
    
    if ([string isEqualToString:@"01"] || [string isEqualToString:@"1"] || [string isEqualToString:@"02"]|| [string isEqualToString:@"2"] || [string isEqualToString:@"07"] || [string isEqualToString:@"7"]|| [string isEqualToString:@"08"] || [string isEqualToString:@"8"]|| [string isEqualToString:@"12"] || [string isEqualToString:@"13"] || [string isEqualToString:@"18"] || [string isEqualToString:@"19"] || [string isEqualToString:@"23"] || [string isEqualToString:@"24"] || [string isEqualToString:@"29"] || [string isEqualToString:@"30"] || [string isEqualToString:@"34"] || [string isEqualToString:@"35"] || [string isEqualToString:@"40"] || [string isEqualToString:@"45"] || [string isEqualToString:@"46"]) {
        
        //        if (select) {
        //
        //            return IMAGE(@"sixred_1");
        //        }
        return IMAGE(@"sixnumberSelectRed");
    }
    else if ([string isEqualToString:@"03"] || [string isEqualToString:@"3"]|| [string isEqualToString:@"04"] || [string isEqualToString:@"4"]|| [string isEqualToString:@"09"]|| [string isEqualToString:@"9"] || [string isEqualToString:@"10"] || [string isEqualToString:@"14"] || [string isEqualToString:@"15"] || [string isEqualToString:@"20"] || [string isEqualToString:@"25"] || [string isEqualToString:@"26"] || [string isEqualToString:@"31"] || [string isEqualToString:@"36"] || [string isEqualToString:@"37"] || [string isEqualToString:@"41"] || [string isEqualToString:@"42"] || [string isEqualToString:@"47"] || [string isEqualToString:@"48"]) {
        
        //        if (select) {
        //
        //            return IMAGE(@"sixblue_1");
        //        }
        
        return IMAGE(@"sixnumberSelectBlue");
    }
    else {
        
        //        if (select) {
        //
        //            return IMAGE(@"sixgreen_1");
        //        }
        
        
        return IMAGE(@"sixnumberSelectG");
    }
    
    return image;
}

+(UIColor *)numbertoSixColor:(NSString *)string{
    
    UIColor *color = nil;
    
    if ([string isEqualToString:@"01"] || [string isEqualToString:@"02"] || [string isEqualToString:@"07"] || [string isEqualToString:@"08"] || [string isEqualToString:@"12"] || [string isEqualToString:@"13"] || [string isEqualToString:@"18"] || [string isEqualToString:@"19"] || [string isEqualToString:@"23"] || [string isEqualToString:@"24"] || [string isEqualToString:@"29"] || [string isEqualToString:@"30"] || [string isEqualToString:@"34"] || [string isEqualToString:@"35"] || [string isEqualToString:@"40"] || [string isEqualToString:@"45"] || [string isEqualToString:@"46"]) {
        
        //        if (select) {
        //
        //            return IMAGE(@"sixred_1");
        //        }
        return color = [UIColor colorWithHex:@"e64154"];
    }
    else if ([string isEqualToString:@"03"] || [string isEqualToString:@"04"] || [string isEqualToString:@"09"] || [string isEqualToString:@"10"] || [string isEqualToString:@"14"] || [string isEqualToString:@"15"] || [string isEqualToString:@"20"] || [string isEqualToString:@"25"] || [string isEqualToString:@"26"] || [string isEqualToString:@"31"] || [string isEqualToString:@"36"] || [string isEqualToString:@"37"] || [string isEqualToString:@"41"] || [string isEqualToString:@"42"] || [string isEqualToString:@"47"] || [string isEqualToString:@"48"]) {
        
        //        if (select) {
        //
        //            return IMAGE(@"sixblue_1");
        //        }
        return color = [UIColor colorWithHex:@"0079ba"];
    }
    else {
        
        //        if (select) {
        //
        //            return IMAGE(@"sixgreen_1");
        //        }
        return color = [UIColor colorWithHex:@"00ad00"];
    }
    
    return color;
}

+(NSString *)numbertowuxin:(NSString *)string {
    
    NSString *number = [NSString stringWithFormat:@"%02ld",(long)string.integerValue];
    
    NSArray *data = [self getwuxin];
    
    NSArray *dataarray = [CartSixModel mj_objectArrayWithKeyValuesArray:data];
    
    for (CartSixModel *model in dataarray) {
        
        if ([model.array containsObject:number]) {
            
            return model.title;
            
            break;
        }
    }
    
    return nil;
}

#pragma mark - 获取今年的五行
+(NSArray *)getwuxin {
    
    NSInteger year = [NSDate date].getYear;
    
    NSArray *array = @[@"木",@"水",@"金",@"火",@"木",@"土",@"金",@"火",@"水",@"土",@"金",@"木",@"水",@"土",@"火",@"木",@"水",@"金",@"火",@"木",@"土",@"金",@"火",@"水",@"土",@"金",@"木",@"水",@"土",@"火",@"木"];
    
    NSMutableArray *data = [[NSMutableArray alloc]init];
    
    NSArray *wuxinarr = @[@"金",@"木",@"水",@"火",@"土"];
    
    for (int i = 0; i< wuxinarr.count; i++) {
        
        NSMutableArray *cell = [[NSMutableArray alloc]init];
        
        NSDictionary *dic = @{@"array":cell,@"title":wuxinarr[i]};
        
        [data addObject:dic];
    }
    
    for (int i = 1 ; i< 50 ; i++) {
        
        int a = floor(year/2.0);
        int b = floor(i/2.0);
        NSInteger number = (60 + a % 30 - b) % 30;
        if (year % 2 != 0 && i % 2 == 0) {
            
            number = number + 1;
        }
        
        NSString *key = array[number];
        
        NSString *str = [NSString stringWithFormat:@"%02d",i];
        if ([key isEqualToString:@"金"]) {
            
            NSMutableArray *arr1 = data[0][@"array"];
            
            [arr1 addObject:str];
        }
        else if ([key isEqualToString:@"木"]) {
            
            NSMutableArray *arr2 = data[1][@"array"];
            
            [arr2 addObject:str];
        }
        else if ([key isEqualToString:@"水"]) {
            
            NSMutableArray *arr3 = data[2][@"array"];
            
            [arr3 addObject:str];
        }
        else if ([key isEqualToString:@"火"]) {
            
            NSMutableArray *arr4 = data[3][@"array"];
            
            [arr4 addObject:str];
        }
        else {
            
            NSMutableArray *arr4 = data[4][@"array"];
            
            [arr4 addObject:str];
        }
    }
    
    return data;
}

+(void)getNextOpenTime:(NSInteger)type Withresult:(void (^)(NSDictionary *))result {
    
//    NSArray * ids = [[CPTBuyDataManager shareManager] allLotteryIds];
//    NSString *tempString = [ids componentsJoinedByString:@","];//分隔符逗号
//
//    [WebTools postWithURL:@"/sg/getNewestSgInfobyids.json" params:@{@"ids":tempString} success:^(BaseData *data) {
//
//    } failure:^(NSError *error) {
//
//    }showHUD:NO];
   
    NSString *url = nil;

    if (type == 1) {
        url = @"/cqsscSg/getNowIssueAndTime.json";
    }else if (type == 4) {
        url = @"/lhcSg/getNowIssueAndTime.json";
    }else if (type == 6) {
        url = @"/bjpksSg/getNowIssueAndTime.json";
    }else if (type == 5) {
        url = @"/pceggSg/getNextIssue.json";
    }else if (type == 2) {
        url = @"/xjsscSg/getNowIssueAndTime.json";
    }else if (type == 3) {
        url = @"/txffcSg/getNowIssueAndTime.json";
    }else if (type == 7) {
        url = @"/xyftSg/getNowIssueAndTime.json";
    }else if (type == 11) {
        url = @"/azPrixSg/getNowIssueAndTime.json";
    }

    [WebTools postWithURL:url params:nil success:^(BaseData *data) {

        if (![data.status isEqualToString:@"1"] || [data.data isEqual:@""]) {
            return ;
        }
        if([data.data isKindOfClass:[NSString class]]){
            return;
        }
        NSDictionary *dic = data.data;
        NSNumber *nextIssue = type == 5 ? dic[@"nextIssue"] : dic[@"issue"];
        NSNumber *nextOpenTime = type == 5 ? dic[@"nextOpenTime"] : type == 4 ? dic[@"betTime"] : dic[@"time"];
        NSInteger cha = nextOpenTime.integerValue - data.time;
        NSNumber *opentime = dic[@"openTime"] == nil ? nextOpenTime : dic[@"openTime"];
        
        NSDictionary *resultdic;
        if (type == 4) {
          resultdic  = @{@"issue":nextIssue,@"time":@(cha),@"start":@(data.time),@"betTime":dic[@"betTime"],@"opentime":opentime};
        } else {
            resultdic = @{@"issue":nextIssue,@"time":@(cha),@"start":@(data.time),@"opentime":opentime};
        }
        result(resultdic);

    } failure:^(NSError *error) {
        MBLog(@"1");
    } showHUD:NO];
}

#pragma mark - 获取投注彩票集合
+(NSMutableArray *)publishlottery:(NSArray *)array {
    
    double time = [[NSDate date] timeIntervalSince1970];
    MBLog(@"开始计算玩法");
    
    if (array.count<2) {
        
        return [NSMutableArray array];
    }
    NSMutableArray * temps = [self getPlayerFirsts:array[0] Twos:array[1]];
    for (int i=2; i<array.count; i++) {
        temps = [self getPlayerFirsts:temps Twos:array[i]];
    }
    
    NSInteger count = temps.count;
    
    double now = [[NSDate date] timeIntervalSince1970];
    NSLog(@"一共有 %ld玩法 耗时:%f",count,now-time);
    NSLog(@"简单计算有 %ld 玩法",(long)[self getCount:array]);
    //    for (NSString *str in temps) {
    //
    //        NSLog(@"投注号码：%@",str);
    //    }
    return temps;
}

//第一种计算
+(NSMutableArray *)getPlayerFirsts:(NSArray *)firsts Twos:(NSArray *)twos{
    NSMutableArray * temps = [[NSMutableArray alloc] init];
    for (NSString * one in firsts) {
        for (NSString * two in twos) {
            
            NSString *centemp = [one stringByAppendingString:two];
            
            [temps addObject:centemp];
        }
    }
    return temps;
}

//第二种计算
+(NSInteger )getCount:(NSArray *)temp{
    NSInteger count = 1;
    for (NSArray * t in temp) {
        count = count*t.count;
    }
    return count;
}

/**
 pricetype:0 = 100
 1 = 50
 2 = 10
 3 = 2
 4 = 1
 5 = 0.5
 */
+(CGFloat)lotteryprice:(NSInteger)pricetype {
    
    switch (pricetype) {
        case 0:
            return 100;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 10;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 1;
            break;
        default:
            return 0.5;
            break;
    }
//    switch (pricetype) {
//            /*
//             _moneyArray = @[@"1角",@"5角",@"1元",@"5元",@"10元",@"100元",@"1000元",@"2000元",@"5000元",@"10000元"];
//
//             */
//        case 0:
//            return 0.1;
//            break;
//        case 1:
//            return 0.5;
//            break;
//        case 2:
//            return 1;
//            break;
//        case 3:
//            return 5;
//            break;
//        case 4:
//            return 10;
//            break;
//        case 5:
//            return 100;
//            break;
//        case 6:
//            return 1000;
//            break;
//        case 7:
//            return 2000;
//            break;
//        case 8:
//            return 5000;
//            break;
//        default:
//            return 10000;
//            break;
//    }
}

#pragma mark - 从m个数中机选n个随机数
+(NSMutableArray *)getDifferentRandomWithNum:(NSInteger )n Withfrome:(int)m{
    
    NSMutableArray *randomArr = [[NSMutableArray alloc]init];
    
    NSInteger random;
    
    for (;;) {
        
        random=arc4random_uniform(m);//随机数0-10
        
        NSLog(@"random--%tu",random);
        
        if(randomArr.count==0){
            
            [randomArr addObject:INTTOSTRING(random)];
            
            if (n == 1) {
                
                return randomArr;
            }
            continue;//进行下一次循环
        }
        BOOL isHave=[randomArr containsObject:INTTOSTRING(random)];//判断数组中有没有
        
        if(isHave){
            continue;
        }
        [randomArr addObject:INTTOSTRING(random)];
        
        if(randomArr.count==n){
            
            return randomArr;
            
        }
    }
    
}

#pragma mark - 压缩图片
+(UIImage *)compressImageWith:(UIImage *)image
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = 320;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *data = UIImageJPEGRepresentation(newImage, 0.2);
    UIImage *newimage2 = [UIImage imageWithData:data];
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newimage2;
}
#pragma mark 保存 plist 文件到本地
+ (void)saveDataToPlistFile:(NSArray *)array WithName:(NSString *)name{

    NSArray *pathArray =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //在这里,我们指定搜索的是Cache目录,所以结果只有一个,取出Cache目录
    NSString *cachePath = pathArray[0];
    //拼接文件路径
    NSString *filePathName = [cachePath stringByAppendingPathComponent:name];
    //想要把这个字典存储为plist文件.
    //直接把字典写入到沙盒当中
    //用字典写, plist文件当中保存的是字典.
    //    NSDictionary *dict = dict;//@{@"age" : @26,@"name" : @"LayneCheung"};
    //获取沙盒路径
    //ToFile:要写入的沙盒路径
    //    [dict writeToFile:filePathName atomically:YES];
    
    //    //用数组写,plist文件当中保存的类型是数组.
    //    NSArray *dataArray = @[@56,@"asdfa"];
    //获取沙盒路径
    //ToFile:要写入的沙盒路径
    [array writeToFile:filePathName atomically:YES];
    
}
#pragma mark 读取本地 plist 文件
+ (NSArray *)readDataFromPlistFile:(NSString *)name{
    //这个方法获取出的结果是一个数组.因为有可以搜索到多个路径.
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //在这里,我们指定搜索的是Cache目录,所以结果只有一个,取出Cache目录
    NSString *cachePath = array[0];
    
    NSString *filePathName = [cachePath stringByAppendingPathComponent:name];
    
    //从文件当中读取字典, 保存的plist文件就是一个字典,这里直接填写plist文件所存的路径
    //    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePathName];
    
    //如果保存的是一个数组.那就通过数组从文件当中加载.
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePathName];
    NSLog(@"%@",dataArray);
    if([name isEqualToString:@"favoritelist.plist"]){
        NSArray *modelArray = [CrartHomeSubModel mj_objectArrayWithKeyValuesArray:dataArray];
        return modelArray;

    }else{
        NSArray *modelArray = [CartHomeModel mj_objectArrayWithKeyValuesArray:dataArray];
        return modelArray;
    }
}

+ (NSArray *)readCircleModelDataFromPlistFile:(NSString *)name{
    //这个方法获取出的结果是一个数组.因为有可以搜索到多个路径.
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //在这里,我们指定搜索的是Cache目录,所以结果只有一个,取出Cache目录
    NSString *cachePath = array[0];
    
    NSString *filePathName = [cachePath stringByAppendingPathComponent:name];
    
    //从文件当中读取字典, 保存的plist文件就是一个字典,这里直接填写plist文件所存的路径
    //    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePathName];
    
    //如果保存的是一个数组.那就通过数组从文件当中加载.
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePathName];
        NSArray *modelArray = [CircleModel mj_objectArrayWithKeyValuesArray:dataArray];
        return modelArray;
        
 
}


+ (NSArray *)readDataFromBundle:(NSString *)name{
    
    
    NSString *filePathName = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    
    //从文件当中读取字典, 保存的plist文件就是一个字典,这里直接填写plist文件所存的路径
    //    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePathName];
    
    //如果保存的是一个数组.那就通过数组从文件当中加载.
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePathName];
    NSLog(@"%@",dataArray);
    NSArray *modelArray = [CrartHomeSubModel mj_objectArrayWithKeyValuesArray:dataArray];
    
    return modelArray;
    
}



+ (void)roundSide:(NSInteger)side view:(UIView *)view
{
    UIBezierPath *maskPath;
    
    if (side == 1)//左上,左下
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    else if (side == 2)//右上,右下
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                         byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    else if (side == 3)//
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                         byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    else
        maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                         byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                               cornerRadii:CGSizeMake(26.f, 26.f)];
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
    
    [view.layer setMasksToBounds:YES];
}

+ (NSString *)getWanString:(NSInteger)sourceNum{
    if (sourceNum >= 10000) {
        return [NSString stringWithFormat:@"%.1f万", (CGFloat)sourceNum/10000];
    }else{
        return [NSString stringWithFormat:@"%ld", (long)sourceNum];
    }
}
@end
