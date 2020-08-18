//
//  HintView.h
//  HQJBusiness
//
//  Created by 姚 on 2019/6/25.
//  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CancelActionBlock)(void);
@interface HintView : UIView

@property (nonatomic,strong)UIButton *sureButton;

/// 取消按钮回调，如果不实现，默认只做取消弹窗操作
@property (nonatomic, copy ) CancelActionBlock cancelAction;


/// 初始化方法，返回HintView  实例对象
+ (HintView *)showView;

///设置视图内容并返回 HintView 实例对象，可搭配取消按钮回调使用。
/// @param topic 提示详情
/// @param sureTitle 确定按钮文字
/// @param cancelTitle 取消按钮文字
/// @param sure 确定按钮点击方法
+ (HintView *)enrichSubviews:(NSString *)topic andSureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle sureAction:(void(^)(void))sure;
/**
 删除子视图移除本视图
 */
+ (void)dismssView;

@end

NS_ASSUME_NONNULL_END
