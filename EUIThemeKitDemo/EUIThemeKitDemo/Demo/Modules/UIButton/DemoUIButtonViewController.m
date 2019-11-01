//
//  DemoUIButtonViewController.m
//  EUIThemeKitDemo
//
//  Created by Lux on 2019/10/25.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoUIButtonViewController.h"
#import "EUIThemeKit.h"

@interface DemoUIButtonViewController ()
@end

@implementation DemoUIButtonViewController

+ (void)initialize {
    [self configuration];
}

+ (void)configuration {
    UIButton *one = [UIButton eui_appearance];
    [one setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"UIButton"];
    
    NSArray <NSString *> *titles = @[
        @"设置 UIButton 标题默认色为棕色(Brown)",
        @"设置 UIButton 标题默认色为蓝色(Blue)",
        @"设置 UIButton 背景默认色是灰色(Gray)",
        @"设置 UIButton 背景默认色是空(Clear)"
    ];
    
    __block CGRect r = CGRectMake(10, 44 + 20, self.view.bounds.size.width - 20, 50);
    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *one = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [one setFrame:r];
        [one setTitle:title forState:UIControlStateNormal];
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"tap%@", @(idx + 1)]);
        [one addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:one];
        r.origin.y = CGRectGetMaxY(r) + 10;
    }];
}

- (void)tap1 {
    UIButton *one = [UIButton eui_appearance];
    [one setTitleColor:UIColor.brownColor forState:UIControlStateNormal];
    [self eui_updateThemeStyleIfNeeded];
}

- (void)tap2 {
    UIButton *one = [UIButton eui_appearance];
    [one setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self eui_updateThemeStyleIfNeeded];
}

- (void)tap3 {
    UIButton *one = [UIButton eui_appearance];
    [one setBackgroundColor:UIColor.grayColor];
    [self eui_updateThemeStyleIfNeeded];
}

- (void)tap4 {
    UIButton *one = [UIButton eui_appearance];
    [one setBackgroundColor:UIColor.clearColor];
    [self eui_updateThemeStyleIfNeeded];
}

- (void)eui_themeDidChange:(EUIThemeManager *)manager theme:(__kindof NSObject<EUIThemeProtocol> *)theme {
    [super eui_themeDidChange:manager theme:theme];
}

@end
