//
//  ToolManager.h
//  WuWuMap
//
//  Created by mymac on 2017/2/20.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface ToolManager : NSObject


/** 警告框 (简版)
 获取字符串宽度
 @param title           提示语
 @param messages        提示信息
 @param style           提示框类型
 @param defaultAction   点击确定按钮后，需要执行代码
 @param vc              提示框在vc上模态弹出
 */
+(void)alertViewWithTitle:(NSString*)title
                messaages:(NSString*)messages
           preferredStyle:(UIAlertControllerStyle)style
            defaultAction:(void(^)(void))defaultAction
               controller:(UIViewController*)vc;

/********相机扫码风格************/
typedef NS_OPTIONS(NSInteger , SacanningStlye) {
    
    /**
     *  付款界面
     */
    SacanningStlyePayment       = 0,
    
    /**
     *  Web界面
     */
    SacanningStlyeWeb          = 1<<0,
    
    /**
     *  物品详情
     */
    SacanningStlyeItemDetails   = 1<<1,

    /**
     *  AA 付款扫码
     */
    SacanningStlyeAAPay         =  1<< 2
    
};

/// 时间转换
typedef NS_OPTIONS(NSInteger , TimeTransformationStlye) {
    
   /// 年月日
    TimeTransformationStlyeDateMonthYear      = 0,
    
    /// 年月日 时分秒
    TimeTransformationStlyeDateMonthYearHourMinutesSeconds   = 1,
    
};

/// 优惠券的状态
typedef NS_ENUM(NSInteger,CouponState) {
    /// 未领取
    CouponStateUncollected = 0,
    /// 已领取
    CouponStateCollected,
   ///  立即使用
    CouponStateImmediateUse,
    /// 已使用
    CouponStateAlreadyUsed,
    /// 已过期
    CouponStateExpired
};
/// 价格种类
typedef NS_ENUM(NSInteger,PriceType) {
    /// 自己公司收入
   GiveYourselfPrice = 0,
    /// 给别人的
    GiveToOthersPrice
};
/**
 获取字符串宽度

 @param str 字符串
 @param fonts 字号
 @return 宽度
 */
+(CGFloat)setTextWidthStr:(NSString *)str andFont:(UIFont *)fonts;


/**
 label 中相应的字符串变色

 @param label 目标label
 @param font 字号
 @param rag 字符串
 @param vaColor 想要改变的颜色
 @param numer 是否是数字
 */
+(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSString *)rag AndColor:(UIColor *)vaColor isNumer:(BOOL)numer;

/**
存值

 @param obj 值
 @param key 键
 */
+ (void)setDataObject:(id)obj key:(NSString *)key;

/**
 获取相应键的值

 @param key 键
 @return 值
 */
+ (NSString *)getDataKey:(NSString *)key;

/**
 删除相应键的值

 @param key 键
 */
+ (void)removeDataKey:(NSString *)key;

/**
 获取当前视图控制器对象

 @return 控制器对象
 */
+ (UIViewController *)currentViewControll;

/**
 登陆
 */
+ (void)login;

+ (void)loginBlock:(void(^)(void))sender ;

/**
 打开相机
 */
+ (void)openCamera;

+ (void)alertTitle:(NSString  *)title content:(NSString *)content theFirstButtonTitle:(NSString * )buttonTitle  theFirstButton:(void(^)(void))confirm  theSecondButtonTitle:(NSString *)buttonTitles theSecondButton:(void(^)(void))cancel;




+ (NSString*)encodeBase64String:(NSString * )input;
+ (NSString*)decodeBase64String:(NSString * )input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;


/**
 相机权限
 
 @param style 相机类型
 */
+(void)CameraRightsStyle:(SacanningStlye)style;


/**
 获取服务器时间

 @param time 时间
 */
+ (void)getServerTimer:(void(^)(NSString *timer))time;



/**
 时间戳转换时间 默认年月日时分秒

 @param str 时间戳
 @return 时间字符串
 */
+ (NSString *)reverseSwitchTimer:(NSString *)str;


/**
 时间戳转换时间

 @param str 时间戳
 @param style 时间风格
 @return 时间字符串
 */
+ (NSString *)reverseSwitchTimer:(NSString *)str timeStyle:(TimeTransformationStlye)style;

/**
 时间戳

 @return 时间
 */
+ (NSDate *)getInternetDate;

/**
 获取当前时间戳

 @return 时间戳
 */
+ (NSString *)getCurrentTimeStamp;
/**
 <#Description#>

 @param endTime <#endTime description#>
 @param hours <#hours description#>
 @param Minutes <#Minutes description#>
 @param seconds <#seconds description#>
 @return <#return value description#>
 */
+ (NSString*)remainingTimeMethodAction:(NSString *)endTime andHour:(void(^)(NSInteger hours))hours andMin:(void(^)(NSInteger Minutes))Minutes andSec:(void(^)(NSInteger Sec))seconds;

/**
 时间转化（1970至今）

 @param timer 当前时间
 @return 时间距离
 */
+(NSString *)switchTimer:(NSInteger)timer;


+ (BOOL)valiMobile:(NSString *)mobile;
+ (BOOL)nameText:(NSString *)text;
#pragma mark --- 身份证合法性判断
+ (BOOL)checkIDCard:(NSString *)sPaperId;



+(NSString *)convertStr:(NSString *)str;

/**
 验证TouchID

 @return 是否开启或者是否支持
 */
+ (BOOL)whetherToSupportTouchID;


/**
 TouchID 验证情况

 @param send 验证内容
 @param inputPassWord 是否选择了用输入
 */
+ (void)verificationTouchID:(void(^)(BOOL isSuccess,NSError *error))send Input:(void(^)(BOOL isInputPassWord))inputPassWord ;


/**
 消费码

 @param str 原字符串
 @return 插入空格后字符串
 */
+ (NSString *)separatedDigitStringWithStr:(NSString *)str;

/**
 创建过滤器

 @param str 需要生成 码的内容
 @return 过滤器
 */
+ (CIImage *)outputImageStr:(NSString *)str ;

/**
 生成二维码

 @param image 过滤器
 @param size 码的大小
 @return 二维码
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;


/**
 字典转字符串

 @param objc 需转的单位
 @return 字符串
 */
+ (NSString *)arrayOrDictToJSONString:(id)objc;


/**
 颜色转图片

 @param color 颜色
 @return 图片
 */
+ (UIImage*)createImageWithColor:(UIColor*)color;


/**
 字符串和image 通用 返回 UIImage 对象

 @param image 所需转换的对象
 @return image 对象
 */
+ (UIImage *)conversionsImage:(id)image ;


/**
 label 内容的变化

 @param label 需要变化内容的label
 @param changeText 所要改变的字符
 @param font 改变字符的大小
 @param color 改变字符的颜色
 */
+ (void)changeLabelText:(UILabel *)label needChangeText:(NSString *)changeText needFont:(CGFloat)font needtextColor:(UIColor *)color;

/**
 通讯录手机号码过滤

 @param mobileNo 原来的状态
 @return 转换后的状态
 */
+ (NSString *)dealWithTheMobileNo:(NSString *)mobileNo ;

/**
 获取设备名称

 @return 设备名
 */
+ (NSString *)deviceModelName;


/**
 hash 判断

 @return hash
 */
+ (NSString *)hashCode;

/**
 截取指定小数点几位字符串

 @param number 需要截取的字符串
 @param position 位数
 @return 截取后的字符串
 */
+ (NSString *_Nonnull)retainScale:(NSString *_Nonnull)number afterPoint:(int)position ;

/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;

/**
 10进制转16进制

 @param tmpid 10进制
 @return 16进制
 */
+ (NSString *)toHex:(long long int)tmpid;

/**
 推荐注册
 */
+ (void)shareRegistered;

/**
 微信推荐注册
 */
+ (void)shareImage;
//获取最顶层的弹出视图,没有子节点则返回本身
+ (UIViewController *)topestPresentedViewControllerForVC:(UIViewController *)viewController;

///  是否可点击推荐奖励 
+ (BOOL)recommendedQualification;
/// 字符串是否包含表情
+ (BOOL)stringContainsEmoji:(NSString *)string;
/// 延时多少时间执行
+ (void)delayedTimer:(CGFloat)timer complete:(void(^)(void))complete;
/// 判断字符串是否为空
+  (BOOL)isBlankString:(NSString *)aStr;
/**
 将 UIView 转换成 UIImage
 
 @param view 将要转换的View
 @return 新生成的 UIImage 对象
 */
+ (UIImage *)yzz_convertCreateImageWithUIView:(UIView *)view;

/// 打电话
+ (void)callPhoneWithPhoneNumer:(NSString *)numer;

/// 请求中返回的是否正确
+ (BOOL)isSucceedWith:(NSDictionary *)dict;


/// 价格截取，分类
/// @param price 需要截取的价格
/// @param type 价格的种类
+ (NSString *)needChangePrice:(NSString *) price priceType:(PriceType)type ;
+ (NSString *)reviseString:(NSString *)string ;


+ (NSNumber *)reviseDouble:(double)number;
/// 自动计算显示时长的toast
+ (void)showToastWithTitle:(NSString *)title position:(id)position;
+ (void)showTopToastWithTitle:(NSString *)title;
+ (void)showCenterToastWithTitle:(NSString *)title;
+ (void)showBottomToastWithTitle:(NSString *)title;

@end
NS_ASSUME_NONNULL_END
