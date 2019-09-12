//
//  Tools.h
//  Qianyaso
//
//  Created by vsskyblue on 16/9/28.
//  Copyright © 2016年 vsskyblue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface Tools : NSObject
+ (NSArray *)readCircleModelDataFromPlistFile:(NSString *)name;//圈子缓存

/**
 创建UILable方法
 */
+(UILabel *) createLableWithFrame:(CGRect)frame
                         andTitle:(NSString *)title
                          andfont:(UIFont *)font
                    andTitleColor:(UIColor *)titleColor
               andBackgroundColor:(UIColor *)backgroundColor
                 andTextAlignment:(NSTextAlignment)textAlignment;

/**
 创建UIButton方法
 */
+(UIButton *) createButtonWithFrame:(CGRect)frame
                           andTitle:(NSString *)title
                      andTitleColor:(UIColor *)titleColor
                 andBackgroundImage:(UIImage *)backgroundImage
                           andImage:(UIImage *)Image
                          andTarget:(id)target
                          andAction:(SEL)sel
                            andType:(UIButtonType)type;
/**
 创建uitextfield
 */
+(UITextField *) creatFieldWithFrame:(CGRect)frame
                      andPlaceholder:(NSString *)placeholder
                             andFont:(UIFont *)font
                    andTextAlignment:(NSTextAlignment)textAlignment
                        andTextColor:(UIColor *)textColor;

/**
 获取uilable高度
 */
+ (float) createLableHighWithString:(NSString *)string andfontsize:(int)font andwithwidth:(float)width;

/**
 获取uilabel宽度
 */
+ (float) createLableWidthWithString:(NSString *)string andfontsize:(int)font andwithhigh:(float)high;

/**
 32位MD5加密方式
 */
+ (NSString *)getMd5WithString:(NSString *)srcString;

+ (NSString*)getMD5WithData:(NSData *)data;

+(NSString*)URLDecodedString:(NSString*)str;
/**
 获取当前时间
 */
+ (NSString*)getlocaleDate;

/**
 获取当前日期
 */
+(NSString *)getlocaletime;

/**
 获取几天后时间
 */
+ (NSString *)GetTomorrowDays:(NSInteger)days;
/**
 获取当前时间戳
 */
+(NSString *)getlocaleChuo;

/**
 时间转时间戳
 */
+(NSString *)returntimetochuo:(NSString *)time;

/**
 时间戳转时间
 */
+(NSString *)returnchuototime:(NSString *)chuo;
/**
 时间戳转Date
 */
+(NSDate *)returnchuotodate:(NSInteger)chuo;

/**字符串转换成时间*/
+ (NSDate *)dateFromString:(NSString *)string;

/**
 获取星期
 */
+(NSString *)getweek:(NSInteger)chuo;

/**
 传入 秒  得到  xx分钟xx秒
 */
+(NSString *)getMMSSFromSS:(NSString *)totalTime;

/**
 获取本周一到周日的日期
 */
+(NSString *)gettodayweek;

/**
 获取本月天数
 */
+(NSInteger)getthismonthdays;
/**
 获取某年月天数
 */
+(NSInteger)getmonthdaysWith:(NSInteger )year Withmonth:(NSInteger)month;

+(UIColor *)numbertoSixColor:(NSString *)string;

/**
 比较两个日期的大小  日期格式为2016-08-14 08：46：20
 */
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;
/**
 获取当前版本号
 */
+ (NSString*)getnowVersion;

/**
 获取BundleID
 */
+(NSString*) getBundleID;
/**
 获取app的名字
 */
+(NSString*) getAppName;
/**
 唯一标示符
 */
+ (NSString *)getuuid;

/**
 uniocode处理中文
 */
+ (NSString *)utf8ToUnicode:(NSString *)string;

/**
 json解析
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 字典转字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 普通字符串转换为十六进制的
 */
+ (NSString *)hexStringFromString:(NSString *)string;

/**
 十六进制转换为普通字符串的。
 */
+ (NSString *)stringFromHexString:(NSString *)hexString;

/**
 NSData转16进制字符串
 */
+ (NSString *)hexStringFromdatabyte:(NSData *)data;

/**
 去掉html标签
 */
+(NSString *)filterHTML:(NSString *)html;

/**
 邮箱
 */
+ (BOOL) validateEmail:(NSString *)email;

/**
 电话号码
 */
+ (BOOL) validatetelphone:(NSString *)telphone;

/**
 手机号码验证
 */
+ (BOOL) validateMobile:(NSString *)mobile;

/**
 纯数字
 */
+ (BOOL)isPureInt:(NSString*)string;
/**
 是否包含中文
 */
+ (BOOL)hasChinese:(NSString *)str;

/**
 *昵称是否有效
 */
+ (BOOL) validateNickname:(NSString *)string;

/**
 密码*/
+ (BOOL) validatePassword:(NSString *)string;

/**
 身份证号
 
 身份证号码验证 1、号码的结构 公民身份号码是特征组合码，由十七位数字本体码和一位校验码组成。排列顺序从左至右依次为：六位数字地址码，
 八位数字出生日期码，三位数字顺序码和一位数字校验码。 2、地址码(前六位数）
 表示编码对象常住户口所在县(市、旗、区)的行政区划代码，按GB/T2260的规定执行。 3、出生日期码（第七位至十四位）
 表示编码对象出生的年、月、日，按GB/T7408的规定执行，年、月、日代码之间不用分隔符。 4、顺序码（第十五位至十七位）
 表示在同一地址码所标识的区域范围内，对同年、同月、同日出生的人编定的顺序号， 顺序码的奇数分配给男性，偶数分配给女性。 5、校验码（第十八位数）
 （1）十七位数字本体码加权求和公式 S = Sum(Ai * Wi), i = 0, ... , 16 ，先对前17位数字的权求和
 Ai:表示第i位置上的身份证号码数字值 Wi:表示第i位置上的加权因子 Wi: 7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
 （2）计算模 Y = mod(S, 11) （3）通过模得到对应的校验码 Y: 0 1 2 3 4 5 6 7 8 9 10 校验码: 1 0 X 9 8 7 6 5 4 3 2
 
 */
+ (BOOL) validateIdentityCard: (NSString *)IDCardNumber;

/**
 两时间差
 */
+(NSString *)intervaldate:(NSString *)time1 Withdate:(NSString *)time2;

/**
 距当前时间差
 */
+(NSString *)getUTCFormateDate:(NSString *)newsDate;

/**
 设置图片圆角
 */
+(void)setCornerRadiusWith:(UIImageView *)headimgv WithRadius:(CGFloat)radius;

/**
 判断document中是否存在某文件
 */
+ (BOOL) isFileExist:(NSString *)fileName;

/**
 动态获取textview大小
 */
+ (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView;

/**
 字符串用，拼接
 */
+(NSString *)appenddatafromeArray:(NSArray *)list;

/**
 获取当前时间年月日时分秒星期
 */
+(void)getcurrentDate:(void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second ,NSString *week))date;

/**
 获取某一天的年月日时分秒 Date转
 */
+(void)getDateWithDate:(NSDate*)date success:(void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second ,NSString *week))dateInfo;

/**
 获取某一天的年月日时分秒 时间戳转
 */
+(void)getDateWithTime:(NSInteger)time success:(void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second ,NSString *week))dateInfo;

/**时间戳传成YYYY/MM/dd*/
+(NSString *)chuototime:(NSTimeInterval)time;

/**
 时间戳传成yyyy.MM.dd HH:mm
 */
+(NSString *)chuototimedian:(NSTimeInterval)time;
+(NSString *)chuototimedian2:(NSTimeInterval)time;

/**
 生成二维码
 */
+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

/**
 画圆角头像
 */
+ (UIImage *)circleImage:(UIImage *)originalimg;

/**
 图片添加图片水印
 
 @param image 要添加水印的图片
 @param watermarkImage 水印图片
 @param rect 水印图片位置
 @return 添加完水印的图片
 */
+ (UIImage *)addWatermarkWithImage:(UIImage *)image
                    watermarkImage:(UIImage *)watermarkImage
                              rect:(CGRect)rect;

/**
 设置评论名字属性
 */
+(NSMutableAttributedString *)setcommentAttributedWithstring:(NSString *)string Withname:(NSString *)nickname Withpid_name:(NSString *)pid_name;

/**
 获取字符串中的数字
 */
+(NSInteger)getnumberfrome:(NSString *)string;

/**判断是否是第一次启动*/
+ (BOOL)isFirstLaunching;

/**判断字符串是否为空*/
+(BOOL)isEmptyOrNull:(NSString *)str;


/**去掉空格*/
+ (NSString *)deleteBlank:(NSString *)string;

/**去掉空格及空行*/
+ (NSString *)deleteBlankAndEnter:(NSString *)string;

/**格式化浮点数（若有一位小数，显示一位；若有两位小数，则显示两位）*/
+(NSString *)formaterDoubleString:(double)doublevalue;

/**
 *  是否有数字
 *
 *  @param string 字符串
 *
 *  @return YES 有数字 ，NO 没有数字
 */
+ (BOOL)hasDigital:(NSString *)string;

/**
 *  是否有字母
 *
 *  @param string 字符串
 *
 *  @return YES 有字母 ，NO 没有字母
 */
+ (BOOL)hasLetter:(NSString *)string;

/**
 纯色生成图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color Withsize:(CGSize)size;

/**
 获取view图片
 */
+ (UIImage *) imageWithView:(UIView *)view Withsize:(CGSize)size;
/**
 保存图片进相册
 */
+ (void)loadImageFinished:(UIImage *)image With:(void (^)(BOOL success))result;

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

/**
 渐变色
 */
+ (CAGradientLayer *)rj_creatGradientLayer:(NSArray *)colors frame:(CGRect)frame;

/**
 是否新版
 */
+ (BOOL)isLead;

/**
 以maskImage的形状为遮罩，绘画出一个相同形状的图片，黑色遮罩可绘制
 */
+ (UIImage*)maskImage:(UIImage *)image withMask:(UIImage *)maskImage;

/**
 图片变灰
 */
+(UIImage *)changeGrayImage:(UIImage *)oldImage;

/**
 *  根据图片url获取网络图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL;


/**
 图片半透明
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;
/**
 图片转base64
 */
+(NSString *)imagetobase64:(UIImage *)image;

/**
 判断图片类型
 */
+ (NSString *)typeForImageData:(NSData *)data ;
/**
 是否包含某字符
 */
+(BOOL)string:(NSString *)string containof:(NSString *)str;
/**
 获取文件夹内容大小
 */
+(float)folderSizeAtPath:(NSString *)path;

/**
 将文本多个空格转为一个空格
 */
+(NSString *)getmoreblanktoone:(NSString *)text;

/**
 获取中国农历年份及生肖
 */
+ (NSString *)getChineseYearWithDate:(NSDate *)date;
/**
 六合彩数字选背景图
 */
+(UIImage *)numbertoimage:(NSString *)string Withselect:(BOOL)select;
+(UIImage *)sixnumberSelectimage:(NSString *)string;
/**
 通过号码判断是金木水火土
 */
+(NSString *)numbertowuxin:(NSString *)string;
/**
 获取今年的五行
 */
+(NSArray *)getwuxin;
/**
 获取下期开奖期数和时间
 type = 1:重庆时时彩
 = 2：六合彩
 = 3：北京PK10
 = 4:PC蛋蛋
 = 5:新疆时时彩
 = 6:比特币分分彩
 = 7:幸运快艇
 */
+(void)getNextOpenTime:(NSInteger)type Withresult:(void(^)(NSDictionary *dic))result;

/**
 获取投注彩票集合
 */
+(NSMutableArray *)publishlottery:(NSArray *)array;
/**
 pricetype:0 = 100
 1 = 50
 2 = 10
 3 = 2
 4 = 1
 5 = 0.5
 */
+(CGFloat)lotteryprice:(NSInteger)pricetype;

/**
 从m个数中机选n个随机数
 */
+(NSMutableArray *)getDifferentRandomWithNum:(NSInteger )n Withfrome:(int)m;

#pragma mark - 压缩图片
+(UIImage *)compressImageWith:(UIImage *)image;

/**
 *保存 plist 文件到本地
 */
+ (void)saveDataToPlistFile:(NSArray *)array WithName:(NSString *)name;

/**
 *读取本地 plist 文件
 */
+ (NSArray *)readDataFromPlistFile:(NSString *)name;
+ (NSArray *)readDataFromBundle:(NSString *)name;

+ (void)roundSide:(NSInteger)side view:(UIView *)view;

+ (NSString *)getWanString:(NSInteger)sourceNum;


@end
