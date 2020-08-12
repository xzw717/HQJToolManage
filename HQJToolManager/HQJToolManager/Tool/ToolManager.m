//
//  ToolManager.m
//  WuWuMap
//
//  Created by mymac on 2017/2/20.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ToolManager.h"
#import <AVFoundation/AVFoundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "sys/utsname.h"
@implementation ToolManager
+ (CGFloat)setTextWidthStr:(NSString *)str andFont:(UIFont *)fonts {
    

    CGSize frame = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fonts,NSFontAttributeName,nil]];
    
    return frame.width;
}

//设置不同字体颜色
+(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSString *)rag AndColor:(UIColor *)vaColor isNumer:(BOOL)numer
{
    if (numer == NO) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
        //设置字号
        NSRange range = [label.text rangeOfString:rag];
        [str addAttribute:NSFontAttributeName value:font range:range];
        //设置文字颜色
        [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
        
        label.attributedText = str;
    } else {
        NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@":",@"-"];
        
        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:rag];
        for (int i = 0; i < rag.length; i ++) {
            //这里的小技巧，每次只截取一个字符的范围
            NSString *a = [rag substringWithRange:NSMakeRange(i, 1)];
            //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
            if ([number containsObject:a]) {
                [attributeString setAttributes:@{NSForegroundColorAttributeName:vaColor,NSFontAttributeName:font,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]} range:NSMakeRange(i, 1)];
            }
            
        }
        //完成查找数字，最后将带有字体下划线的字符串显示在UILabel上
        label.attributedText = attributeString;
    }
    
}

#pragma mark --
#pragma mark - 警告框 ( 简版 )
+(void)alertViewWithTitle:(NSString*)title
                messaages:(NSString*)messages
           preferredStyle:(UIAlertControllerStyle)style
            defaultAction:(void(^)(void))defaultAction
               controller:(UIViewController*)vc
{

    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:messages preferredStyle:style];
    UIAlertAction * action0 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        defaultAction();
    }];
//    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action0];
//    [alertVC addAction:action1];
    [vc presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark --
#pragma mark --- 数据持久化--- NSUserDefaults 存数据
+ (void)setDataObject:(id)obj key:(NSString *)key {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:obj forKey:key];
//    [userDefaults setValue:obj forKey:key];
    [userDefaults synchronize];
    
    
}

#pragma mark --
#pragma mark --- 取数据
+ (id)getDataKey:(NSString *)key {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    id str = [userDefaults objectForKey:key];
    
    
    return str;
}

#pragma mark --
#pragma mark --- 删除数据
+ (void)removeDataKey:(NSString *)key {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
    

}



#pragma mark --
#pragma mark --- 获取当前视图控制器对象
+ (UIViewController *)currentViewControll{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}





#pragma mark --
#pragma mark ---
+ (void)alertTitle:(NSString  *)title content:(NSString * )content theFirstButtonTitle:(NSString * )buttonTitle  theFirstButton:(void(^)(void))confirm  theSecondButtonTitle:(NSString *)buttonTitles theSecondButton:(void(^)(void))cancel { 
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !confirm ?:confirm();
        
    }]];
    if (buttonTitles != nil) {
        
        [alert addAction:[UIAlertAction actionWithTitle:buttonTitles style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !cancel ?:cancel();
            
        }]];
        
    }
           
    [[ToolManager currentViewControll] presentViewController:alert animated:YES completion:nil];
    
}



+ (void)delayedTimer:(CGFloat)timer complete:(void(^)(void))complete {
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timer/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        complete();
    });

}

+ (NSString *)reverseSwitchTimer:(NSString *)str {
  return  [ToolManager reverseSwitchTimer:str timeStyle:TimeTransformationStlyeDateMonthYearHourMinutesSeconds];
}

#pragma mark --
#pragma mark --- 时间戳转时间
+ (NSString *)reverseSwitchTimer:(NSString *)str timeStyle:(TimeTransformationStlye)style {
    NSInteger timer =  [str integerValue];
    
    if ([[NSString stringWithFormat:@"%ld",timer] length] == 13) {
        timer/=1000;
    }
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timer];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    switch (style) {
        case TimeTransformationStlyeDateMonthYear:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];

            break;
        case TimeTransformationStlyeDateMonthYearHourMinutesSeconds:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        default:
            break;
    }
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
    
   
}


#pragma mark --
#pragma mark ---判断相机权限
+ (void)CameraRightsStyle:(SacanningStlye)style {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        [self alertTitle:@"提示" content:@"尚未打开相机权限" theFirstButtonTitle:@"暂不设置" theFirstButton:^{
        } theSecondButtonTitle:@"前去设置" theSecondButton:^{
            dispatch_after(0.2, dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                
            });
        }];
        
        return;
    } else {

    
    }
    
    
    
    
}


#pragma mark ----时间戳
+ (NSDate *)getInternetDate {
    NSString *urlString = @"http://m.baidu.com/";
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    // 实例化NSMutableURLRequest，并进行参数配置
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString: urlString]];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    [request setTimeoutInterval: 5];
    
    [request setHTTPShouldHandleCookies:FALSE];
    
    [request setHTTPMethod:@"GET"];
    
    NSError *error = nil;
    
    NSHTTPURLResponse *response;
    
    [NSURLConnection sendSynchronousRequest:request
     
                          returningResponse:&response error:&error];
    if (error) {
        return [NSDate date];
    }
    
    //    NSLog(@"response is %@",response);
    
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    //    NSLog(@"date is \n%@",date);
    
    date = [date substringFromIndex:5];
    
    date = [date substringToIndex:[date length]-4];
    
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    
    [dMatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//直接指定时区，这里是东8区
    
    
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    
    return netDate;
    
}

#pragma mark --- 获取当前时间戳
+ (NSString *)getCurrentTimeStamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    NSString *ts = [NSString stringWithFormat:@"%ld",(long)timeSp];//时间戳的值
    return ts;
}

#pragma mark --
#pragma mark ---判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile {
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (mobile.length != 11)
        
    {
        
        return NO;
        
    }else{
        return [mobile hasPrefix:@"1"];
       
//        /**
//
//         * 移动号段正则表达式
//
//         */
//
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(198)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//
//        /**
//
//         * 联通号段正则表达式
//
//         */
//
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)||(166)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//
//        /**
//
//         * 电信号段正则表达式
//
//         */
//
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(199)|(18[0,1,9]))\\d{8}$";
//
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//
//        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
//
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//
//        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
//
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//
//        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
//
//
//
//        if (isMatch1 || isMatch2 || isMatch3) {
//
//            return YES;
//
//        }else{
//
//            return NO;
//
//        }
        
    }
    
}


#pragma mark --姓名合法性
+ (BOOL)nameText:(NSString *)text {
    
    NSString * regex = @"^[\u4E00-\u9FA5]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:text];
    return isMatch;
}



#pragma mark --
#pragma mark ---倒计时功能 （时间转时间戳然后在转倒计时）
+ (NSString*)remainingTimeMethodAction:(NSString *)endTime andHour:(void(^)(NSInteger hours))hours andMin:(void(^)(NSInteger Minutes))Minutes andSec:(void(^)(NSInteger Sec))seconds
{
    
   
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:endTime];
    
    
    
    //得到当前时间
    NSDate *nowData = [NSDate date];
    NSTimeInterval time =(long)[date timeIntervalSince1970];
    NSDate *endData=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags =
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:nowData  toDate: endData options:0];
    NSInteger Hour  = [cps hour];
    NSInteger Min   = [cps minute];
    NSInteger Sec   = [cps second];
    if (hours) {
        hours(Hour);
    }
    if (Minutes) {
        Minutes(Min);
    }
    if (seconds) {
        seconds(Sec);
    }
    
    
    
    NSString *countdown = [NSString stringWithFormat:@"%zi小时 %zi分钟 %zi秒",Hour, Min, Sec];
    
    
    if (Sec<0 ||Min<0 ) {
        countdown=[NSString stringWithFormat:@"付款时间已过"];
    }
    return countdown;
}

#pragma mark --
#pragma mark --- 身份证合法性判断
+ (BOOL)checkIDCard:(NSString *)sPaperId {
    //判断位数
    if (sPaperId.length != 15 && sPaperId.length != 18) {
        return NO;
    }
    NSString *carid = sPaperId;
    long lSumQT = 0 ;
    //加权因子
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    //校验码
    unsigned char sChecker[12] = {'1','0','x','X','9','8','7','6','5','4','3','2'};
    //将15位身份证号转换为18位
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    if (sPaperId.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p =0;
        //        const char *pid = [mString UTF8String];
        for (int i =0; i<17; i++)
        {
            NSString * s = [mString substringWithRange:NSMakeRange(i, 1)];
            p += [s intValue] * R[i];
            //            p += (long)(pid-48) * R;//
            
        }
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    //判断地区码
    NSString *sProvince = [carid substringToIndex:2];
    if (![self isAreaCode:sProvince]) {
        return NO ;
    }
    //判断年月日是否有效
    //年份
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    //月份
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    //日
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        return NO;
    }
    [carid uppercaseString];
    const char *PaperId = [carid UTF8String];
    //检验长度
    if (18!=strlen(PaperId)) {
        return NO;
    }
    //校验数字
    NSString * lst = [carid substringFromIndex:carid.length-1];
    char di = [carid characterAtIndex:carid.length-1];

    if (!isdigit(di)) {
        if ([lst isEqualToString:@"x"] || [lst isEqualToString:@"X"]) {

        }else{
            return NO;
        }
    }
    //验证最末的校验码
    lSumQT = 0;
    for (int i = 0; i<17; i++){
        NSString * s = [carid substringWithRange:NSMakeRange(i, 1)];
        lSumQT += [s intValue] * R[i];

    }
    if (sChecker[lSumQT%11] != PaperId[17]) {
        if (sChecker[lSumQT%11 + 1] != PaperId[17]) {
            
            return NO;
            
        }
    }
    
    
    
    return YES;
}

+ (NSArray *)provinceArr {
    NSArray *pArr = @[
                      
                      @"11",//北京市|110000，
                      
                      @"12",//天津市|120000，
                      
                      @"13",//河北省|130000，
                      
                      @"14",//山西省|140000，
                      
                      @"15",//内蒙古自治区|150000，
                      
                      @"21",//辽宁省|210000，
                      
                      @"22",//吉林省|220000，
                      
                      @"23",//黑龙江省|230000，
                      
                      @"31",//上海市|310000，
                      
                      @"32",//江苏省|320000，
                      
                      @"33",//浙江省|330000，
                      
                      @"34",//安徽省|340000，
                      
                      @"35",//福建省|350000，
                      
                      @"36",//江西省|360000，
                      
                      @"37",//山东省|370000，
                      
                      @"41",//河南省|410000，
                      
                      @"42",//湖北省|420000，
                      
                      @"43",//湖南省|430000，
                      
                      @"44",//广东省|440000，
                      
                      @"45",//广西壮族自治区|450000，
                      
                      @"46",//海南省|460000，
                      
                      @"50",//重庆市|500000，
                      
                      @"51",//四川省|510000，
                      
                      @"52",//贵州省|520000，
                      
                      @"53",//云南省|530000，
                      
                      @"54",//西藏自治区|540000，
                      
                      @"61",//陕西省|610000，
                      
                      @"62",//甘肃省|620000，
                      
                      @"63",//青海省|630000，
                      
                      @"64",//宁夏回族自治区|640000，
                      
                      @"65",//新疆维吾尔自治区|650000，
                      
                      @"71",//台湾省（886)|710000,
                      
                      @"81",//香港特别行政区（852)|810000，
                      
                      @"82",//澳门特别行政区（853)|820000
                      
                      @"91",//国外
                      ];
    return pArr;
}

+ (BOOL)isAreaCode:(NSString *)province {
    //在provinceArr中找
    NSArray * arr = [self provinceArr];
    int a = 0;
    for (NSString * pr in arr) {
        if ([pr isEqualToString:province]) {
            a ++;
        }
    }
    if (a == 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (NSString *)getStringWithRange:(NSString *)str Value1:(int)v1 Value2:(int)v2 {
    NSString * sub = [str substringWithRange:NSMakeRange(v1, v2)];
    return sub;
}


#pragma mark --
#pragma mark --- 直接传入精度丢失有问题的Double类型
+ (NSString *)convertStr:(NSString *)str {
    double conversionValue        = (double)[str floatValue];
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
    
}

#pragma mark --
#pragma mark --- 时间转化（1970至今）
// 时间戳为13位是精确到毫秒的，10位精确到秒
+(NSString *)switchTimer:(NSInteger)timer {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-d"];
//    NSString *dateLoca = [NSString stringWithFormat:@"%ld",timer*24*60*60];
//    NSTimeInterval time=[dateLoca doubleValue];
//    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    NSString *timestr = [formatter stringFromDate:detaildate];
//    
//    NSTimeInterval time = timer + 28800;//因为时差问题要加8小时 == 28800 sec
//    if ([[NSString stringWithFormat:@"%ld",timer] length] == 13) {
//        timer/=1000;
//    }
//    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timer];
//
//    //实例化一个NSDateFormatter对象
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//
//    //设定时间格式,这里可以设置成自己需要的格式
//
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//
//    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
//    return currentDateStr;
    return  [ToolManager reverseSwitchTimer:[NSString stringWithFormat:@"%ld",timer] timeStyle:TimeTransformationStlyeDateMonthYearHourMinutesSeconds];

}


#pragma mark --- 是否支持 Touch ID
+ (BOOL)whetherToSupportTouchID {
    LAContext *context = [LAContext new];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        // 设备支持
        return  YES;

    } else {
        
        
        NSLog(@"不支持指纹识别");
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
        return  NO;

        // 设备不支持
    }
}




#pragma mark --- 分割字符串
+ (NSString *)separatedDigitStringWithStr:(NSString *)str {
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithFormat:@"%@",str];
    for (NSInteger i = 0; i < str.length / 4 -1; i ++) {
        [mutableStr insertString:@" " atIndex:4 + ( 4 * i) + i];
    }
    return mutableStr;
}

+ (CIImage *)outputImageStr:(NSString *)str {
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    return  [filter outputImage];
    
}


#pragma mark --- 根据CIImage生成指定大小的UIImage
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone); CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


#pragma mark --- 模型转字符串
+ (NSString *)arrayOrDictToJSONString:(id)objc {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:objc options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData == nil) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

#pragma mark 颜色转换为图片
+ (UIImage*)createImageWithColor:(UIColor*)color {
    
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

#pragma mark --- image 或 名称 转换
+ (UIImage *)conversionsImage:(id)image  {
    if ([[image class]isEqual:[UIImage class]]) {
        return image;
    } else {
        return [UIImage imageNamed:image];
    }
}


#pragma mark --- 改变label 内显示的内容 
+ (void)changeLabelText:(UILabel *)label needChangeText:(NSString *)changeText needFont:(CGFloat)font needtextColor:(UIColor *)color  {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    NSRange range = [label.text rangeOfString:changeText];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    label.attributedText = str;
}


#pragma mark --- 通讯录手机号码过滤
+ (NSString *)dealWithTheMobileNo:(NSString *)mobileNo {
    NSString *localPersonPhone = [mobileNo stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    localPersonPhone = [localPersonPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    localPersonPhone = [localPersonPhone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    localPersonPhone = [localPersonPhone stringByReplacingOccurrencesOfString:@")" withString:@""];
    localPersonPhone = [localPersonPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    localPersonPhone = [[localPersonPhone componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    return localPersonPhone;
    
}





+ (NSString *)deviceModelName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
    //simulator
    if ([platform isEqualToString:@"i386"])          return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])        return @"Simulator";
    
    //AirPods
    if ([platform isEqualToString:@"AirPods1,1"])    return @"AirPods";
    
    //Apple TV
    if ([platform isEqualToString:@"AppleTV2,1"])    return @"Apple TV (2nd generation)";
    if ([platform isEqualToString:@"AppleTV3,1"])    return @"Apple TV (3rd generation)";
    if ([platform isEqualToString:@"AppleTV3,2"])    return @"Apple TV (3rd generation)";
    if ([platform isEqualToString:@"AppleTV5,3"])    return @"Apple TV (4th generation)";
    if ([platform isEqualToString:@"AppleTV6,2"])    return @"Apple TV 4K";
    
    //Apple Watch
    if ([platform isEqualToString:@"Watch1,1"])    return @"Apple Watch (1st generation)";
    if ([platform isEqualToString:@"Watch1,2"])    return @"Apple Watch (1st generation)";
    if ([platform isEqualToString:@"Watch2,6"])    return @"Apple Watch Series 1";
    if ([platform isEqualToString:@"Watch2,7"])    return @"Apple Watch Series 1";
    if ([platform isEqualToString:@"Watch2,3"])    return @"Apple Watch Series 2";
    if ([platform isEqualToString:@"Watch2,4"])    return @"Apple Watch Series 2";
    if ([platform isEqualToString:@"Watch3,1"])    return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,2"])    return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,3"])    return @"Apple Watch Series 3";
    if ([platform isEqualToString:@"Watch3,4"])    return @"Apple Watch Series 3";
    
    //HomePod
    if ([platform isEqualToString:@"AudioAccessory1,1"])    return @"HomePod";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])    return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])    return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"])    return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,2"])    return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,3"])    return @"iPad (3rd generation)";
    if ([platform isEqualToString:@"iPad3,4"])    return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,5"])    return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad3,6"])    return @"iPad (4th generation)";
    if ([platform isEqualToString:@"iPad4,1"])    return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])    return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])    return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"])    return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])    return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,7"])    return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,8"])    return @"iPad Pro (12.9-inch)";
    if ([platform isEqualToString:@"iPad6,3"])    return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,4"])    return @"iPad Pro (9.7-inch)";
    if ([platform isEqualToString:@"iPad6,11"])    return @"iPad (5th generation)";
    if ([platform isEqualToString:@"iPad6,12"])    return @"iPad (5th generation)";
    if ([platform isEqualToString:@"iPad7,1"])    return @"iPad Pro (12.9-inch, 2nd generation)";
    if ([platform isEqualToString:@"iPad7,2"])    return @"iPad Pro (12.9-inch, 2nd generation)";
    if ([platform isEqualToString:@"iPad7,3"])    return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"])    return @"iPad Pro (10.5-inch)";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])    return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,6"])    return @"iPad mini";
    if ([platform isEqualToString:@"iPad2,7"])    return @"iPad mini";
    if ([platform isEqualToString:@"iPad4,4"])    return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,5"])    return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,6"])    return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"])    return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,8"])    return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad4,9"])    return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"])    return @"iPad mini 4";
    if ([platform isEqualToString:@"iPad5,2"])    return @"iPad mini 4";
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])     return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])     return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])     return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])     return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])     return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])     return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])     return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])     return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])     return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])     return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])     return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])     return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])     return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])     return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])     return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])     return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])     return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])     return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"])     return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])     return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"])     return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    
    //iPod touch
    if ([platform isEqualToString:@"iPod1,1"])    return @"iPod touch";
    if ([platform isEqualToString:@"iPod2,1"])    return @"iPod touch (2nd generation)";
    if ([platform isEqualToString:@"iPod3,1"])    return @"iPod touch (3rd generation)";
    if ([platform isEqualToString:@"iPod4,1"])    return @"iPod touch (4th generation)";
    if ([platform isEqualToString:@"iPod5,1"])    return @"iPod touch (5th generation)";
    if ([platform isEqualToString:@"iPod7,1"])    return @"iPod touch (6th generation)";
    
    return platform;
    
}
#pragma mark --- 截取指定小数点几位的字符串
+ (NSString *_Nonnull)retainScale:(NSString *_Nonnull)number afterPoint:(int)position {
    
    NSString *result = [NSString stringWithFormat:@"%@",number];
    if ([result containsString:@"."]) {
        NSRange range = [result rangeOfString:@"."];
        NSString *sub = [result substringFromIndex:range.location + 1];
        if (sub.length<position) {
            for (int i = 0; i < position - sub.length ; i ++) {
                result  = [result stringByAppendingString:@"0"];
            }
        }else if (sub.length>position){
            result  = [result substringToIndex:range.location + position + 1];
        }
    }else{
        result = [result stringByAppendingString:@"."];
        for (int i = 0; i < position ; i ++) {
            result  = [result stringByAppendingString:@"0"];
        }
    }
    return result;
    
}

#pragma mark --- 调整图片尺寸和大小
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0 * 2;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}
//将十进制转化为十六进制
+ (NSString *)toHex:(long long int)tmpid {
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}


+ (UIViewController *)topestPresentedViewControllerForVC:(UIViewController *)viewController
{
    UIViewController *topestVC = viewController;
    while (topestVC.presentedViewController) {
        topestVC = topestVC.presentedViewController;
    }
    return topestVC;
}


#pragma mark ---字符串中是否包含表情
+ (BOOL)stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        
        if (0xd800 <= hs && hs <= 0xdbff) {
            
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
                
            }
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
    
}
+  (BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

+ (UIImage *)yzz_convertCreateImageWithUIView:(UIView *)view{
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
}

+ (void)callPhoneWithPhoneNumer:(NSString *)numer {

    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",numer];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}

+ (BOOL)isSucceedWith:(NSDictionary *)dict {
    if ([dict[@"resultCode"] integerValue] % 100 == 0) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)needChangePrice:(NSString *)price priceType:(PriceType)type {
    if (type == GiveYourselfPrice) {
        return @"";
    } else {
        return @"";
    }
    
}
+ (NSString *)reviseString:(NSString *)string {
    
    /* 直接传入精度丢失有问题的Double类型*/
    double conversionValue        = (double)[string floatValue];
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}
+ (NSNumber *)reviseDouble:(double)number {
    NSString *string = [NSString stringWithFormat:@"%f",number];
              
    double doubStr = [string doubleValue];
               
    float floatStr = [string floatValue];
         
    NSNumberFormatter *numberFor = [[NSNumberFormatter alloc] init];
    
    NSNumber *numberString = [numberFor numberFromString:string];
    return numberString;
}

@end
