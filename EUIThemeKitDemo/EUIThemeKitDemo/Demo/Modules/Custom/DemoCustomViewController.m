//
//  DemoCustomViewController.m
//  EUIThemeKitDemo
//
//  Created by Lux on 2019/10/30.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoCustomViewController.h"
#import "DemoThemeViewController.h"
#import "DemoHelper.h"
#import "DUICustomView.h"
#import "DUICustomChildView.h"
///< Theme
#import "DemoThemeTemplet.h"

@interface DemoCustomViewController ()
@end

@implementation DemoCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"业务层示例"];

    /*!
     方式一：使用已经封装的主题色宏，通常主题宏会包含两个能力：
     1、主题色定义；
     2、主题色的动态替换能力；
     */
    self.view.backgroundColor = DemoPrimaryColor;
    
    /*!
     方式二：使用主题库提供的颜色动态生成器
     */
    self.view.backgroundColor = [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        DemoTheme *one = manager.currentTheme;
        return one.demo_backgrounndColor;
    }];
    
    [self p_setupNaviBar];
    [self p_addComponents];
}

- (void)p_addComponents {
    CGRect r = CGRectMake(10, 44 + 20, self.view.bounds.size.width - 20, 50);
    {
        UIButton *one = [[UIButton alloc] initWithFrame:r];
        [one setTitle:@"我就是个 UIButton" forState:UIControlStateNormal];
        [self.view addSubview:one];
    }
    r.origin.y = CGRectGetMaxY(r) + 10;
    {
        DUICustomView *one = [[DUICustomView alloc] initWithFrame:r];
        one.eui_themeDidChange = ^(DUICustomView *oneSelf, EUIThemeManager *manager) {
            DemoTheme *theme = manager.currentTheme;
            oneSelf.title = theme.identifier;
        };
        [self.view addSubview:one];
    }
    r.origin.y = CGRectGetMaxY(r) + 10;
    {
        DUICustomChildView *one = [[DUICustomChildView alloc] initWithFrame:r];
        [self.view addSubview:one];
    }
}

- (void)p_setupNaviBar {
    [DemoHelper setNaviBarLeftItem:@"pop" target:self sel:@selector(p_popTheme)];
    [DemoHelper setNaviBarRightItem:@"push" target:self sel:@selector(p_pushTheme)];
}

- (void)p_popTheme {
    UIViewController *one = DemoThemeViewController.new;
    [self presentViewController:one animated:YES completion:nil];
}

- (void)p_pushTheme {
    UIViewController *one = DemoThemeViewController.new;
    [self.navigationController pushViewController:one animated:YES];
}

- (void)eui_themeDidChange:(EUIThemeManager *)manager theme:(__kindof NSObject<EUIThemeProtocol> *)theme {
    [super eui_themeDidChange:manager theme:theme];
    /*!
     可继承该方法自定义其他主题逻辑
     Do something.
     */
}

@end
