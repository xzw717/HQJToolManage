////
////  HintView.m
////  HQJBusiness
////
////  Created by XXX on 2019/6/25.
////  Copyright © 2019年 Fujian first time iot technology investment co., LTD. All rights reserved.
////
//
#import "HintView.h"
//#import "UIColor+ColorConversion.h"
//#import <Masonry/Masonry.h>
//#define  WIDTH  [[UIScreen mainScreen] bounds].size.width
//#define HEIGHT  [[UIScreen mainScreen] bounds].size.height
//@interface HintView ()
//
//@property (nonatomic,strong)UIView *maskView;
//@property (nonatomic,strong)UIButton *cancelButton;
//@property (nonatomic,strong)UILabel *topicLabel;
//@property (nonatomic,strong)UIView *divisionView;
//@property (nonatomic, copy) void(^submitBlcok)(void);
//@end
//
@implementation HintView
//
//-(UIView *)maskView {
//    if ( _maskView == nil ) {
//        _maskView =  [[UIView alloc]init];
//        _maskView.backgroundColor = [UIColor whiteColor];
//        _maskView.alpha = 1;
//        _maskView.layer.masksToBounds = YES;
//        _maskView.layer.cornerRadius = 10.0f;
//        [self addSubview:_maskView];
//    }
//    return _maskView;
//}
//-(UILabel *)topicLabel {
//    if ( _topicLabel == nil ) {
//        _topicLabel =  [[UILabel alloc]init];
//        _topicLabel.font = [UIFont systemFontOfSize:40/3];
//        _topicLabel.textColor = [UIColor colorWithHexString:@"010101"];
//        _topicLabel.textAlignment = NSTextAlignmentCenter;
//        _topicLabel.numberOfLines = 0;
//        [_topicLabel sizeToFit];
//        [self.maskView addSubview:_topicLabel];
//    }
//
//
//    return _topicLabel;
//}
//
//- (UIView *)divisionView{
//    if ( _divisionView  == nil ) {
//        _divisionView = [[UIView alloc]init];
//        _divisionView.backgroundColor = [UIColor colorWithHexString:@"e7e5e5"];
//        [self.maskView addSubview:_divisionView];
//    }
//
//    return _divisionView;
//}
//
//- (UIButton *)cancelButton{
//    if ( _cancelButton == nil ) {
//        _cancelButton =  [UIButton buttonWithType:0];
//        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"919191"] forState:UIControlStateNormal];
//        _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:40/3];
//        _cancelButton.layer.masksToBounds = YES;
//        _cancelButton.layer.cornerRadius = [HintView s_ratioW:50.f];
//        _cancelButton.layer.borderWidth = 1.0f;
//        _cancelButton.layer.borderColor = [UIColor colorWithHexString:@"919191"].CGColor;
//        [_cancelButton addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
//
//
//        [self.maskView addSubview:_cancelButton];
//    }
//    return _cancelButton;
//}
//- (UIButton *)sureButton{
//    if ( _sureButton == nil ) {
//        _sureButton =  [UIButton buttonWithType:0];
//        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _sureButton.backgroundColor = [UIColor redColor];
//        _sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:40/3];
//        _sureButton.layer.masksToBounds = YES;
//        _sureButton.layer.cornerRadius = [HintView s_ratioW:50.f];
//        [self.maskView addSubview:_sureButton];
//    }
//    return _sureButton;
//}
//
//-(instancetype)initWithFrame:(CGRect)frame {
//
//    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
//    if (self) {
//        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
//        [[UIApplication sharedApplication].keyWindow addSubview:self];
////        [self enrichSubviews:topic andSureTitle:sureTitle cancelTitle:cancelTitle];
//        [self updateConstraintsIfNeeded];
//    }
//    return self;
//}
//- (void)updateConstraints {
//    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self);
//        make.width.mas_equalTo([HintView s_ratioW:240.0f]);
//    }];
//    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-[HintView s_ratioW:40.f]);
//        make.left.mas_equalTo([HintView s_ratioW:40.f]);
//        make.height.mas_equalTo([HintView s_ratioW:100.f]);
//        make.width.mas_equalTo([HintView s_ratioW:100.f]);
//    }];
//    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-[HintView s_ratioW:40.f]);
//        make.right.mas_equalTo(-[HintView s_ratioW:40.f]);
//        make.height.mas_equalTo([HintView s_ratioW:100]);
//        make.width.mas_equalTo([HintView s_ratioW:100]);
//    }];
//    [self.divisionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.sureButton.mas_top).mas_offset(-[HintView s_ratioW:40]);
//        make.right.mas_equalTo(-10);
//        make.left.mas_equalTo(10);
//        make.height.mas_equalTo(0.5f);
//    }];
//    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.top.mas_equalTo(70.f / 3);
//         make.right.mas_equalTo(-25);
//         make.left.mas_equalTo(25);
//         make.bottom.mas_equalTo(self.divisionView.mas_top).mas_offset(-70.f / 3);
//     }];
//    [super updateConstraints];
//}
//- (void)btnCancelAction {
//    ! self.cancelAction ? [HintView dismssView] :  self.cancelAction ();
//}
//
//
//- (void)btnSubmitAction {
//    [HintView dismssView];
//    ! self.submitBlcok ? : self.submitBlcok();
//}
//+ (CGFloat)s_ratioW:(CGFloat)w {
//    return w / 375.0f * WIDTH / 3;
//}
//
//+ (CGFloat)s_ratioH:(CGFloat)h {
//    return h / 667.0f * HEIGHT / 3;
//}
//
//
//+ (HintView *)showView {
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    UIView *view = [window.subviews lastObject];
//    [[self currentViewControll].view endEditing:YES];
//    if (![NSStringFromClass([view class]) isEqualToString:@"HintView"]) {
//        HintView *hit = [[HintView alloc]initWithFrame:CGRectZero];
//        return hit;
//    } else {
//        return (HintView *)view;
//    }
//}
//
//+ (HintView *)enrichSubviews:(NSString *)topic andSureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle sureAction:(void(^)(void))sure {
//    [HintView showView].topicLabel.text = topic;
//    [[HintView showView].sureButton setTitle:sureTitle forState:UIControlStateNormal];
//    [[HintView showView].cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
//    [[HintView showView].sureButton addTarget:self action:@selector(btnSubmitAction) forControlEvents:UIControlEventTouchUpInside];
//    sure = [HintView showView].submitBlcok;
//    return [HintView showView];
//}
//
//+ (void)dismssView {
//    [[HintView showView] removeFromSuperview];
//
//}
//
//+ (UIViewController *)currentViewControll{
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//
//    UIViewController *result = window.rootViewController;
//    while (result.presentedViewController) {
//        result = result.presentedViewController;
//    }
//    if ([result isKindOfClass:[UITabBarController class]]) {
//        result = [(UITabBarController *)result selectedViewController];
//    }
//    if ([result isKindOfClass:[UINavigationController class]]) {
//        result = [(UINavigationController *)result topViewController];
//    }
//    return result;
//}
@end
