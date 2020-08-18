//
//  UIColor+ColorConversion.h
//  WuWuMap
//
//  Created by mymac on 2017/2/15.
//  Copyright © 2017年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorConversion)

/**
 16颜色 进制转换

 @param hexColorString 色值字符串
 @return 所转换的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColorString;
@end
