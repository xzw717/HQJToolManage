//
//  ViewController.m
//  HQJToolManager
//
//  Created by Ethan on 2020/8/12.
//  Copyright © 2020 Fujian first time iot technology investment co., LTD. All rights reserved.
//

#import "ViewController.h"
#import "HintView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    btn.frame =CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];

}
- (void)click {
//    [HintView enrichSubviews:@"测试弹窗" andSureTitle:@"确定" cancelTitle:@"取消" sureAction:^{
        
//    }];
}

@end
