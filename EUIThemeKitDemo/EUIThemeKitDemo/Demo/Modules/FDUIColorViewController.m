//
//  FDUIColorViewController.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/22.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "FDUIColorViewController.h"
///< Component
#import "DUICustomView.h"
#import "DUICustomChildView.h"
///< Theme
#import "EUIThemeKit.h"
#import "DUIThemeTemplet.h"
#import "DUITheme.h"

@implementation FDUIColorViewController {
    DUIThemeTemplet *_themeTemplet;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    ///< 配置主题
    _themeTemplet = [DUIThemeTemplet new];
    
    ///< 应用主题
    [self.view setBackgroundColor:DUIBackgroundColor];
    
    [self p_addButtonComponent];
    [self p_addTestViewComponent];
    [self p_addTest2ViewComponent];
}

#pragma mark - ---| Componentss |---

- (void)p_addButtonComponent {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.userInteractionEnabled = YES;
    [button setTitle:@"点我切换" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)p_addTestViewComponent {
    DUICustomView *one = [[DUICustomView alloc] initWithFrame:CGRectMake(100, 230, 100, 100)];
    [self.view addSubview:one];
}

- (void)p_addTest2ViewComponent {
    DUICustomChildView *one = [[DUICustomChildView alloc] initWithFrame:CGRectMake(100, 350, 100, 100)];
    [self.view addSubview:one];
}

#pragma mark - ---| Action |---

- (void)tapAction {
    NSLog(@"点击切换主题");
    id <EUIThemeProtocol> theme = [EUIThemeManager sharedInstance].currentTheme;
    if ([theme.identifier isEqualToString:@"red"]) {
        [[EUIThemeManager sharedInstance] applyTheme:[DUIThemeBlue new]];
    } else if ([theme.identifier isEqualToString:@"blue"]) {
        [[EUIThemeManager sharedInstance] applyTheme:[DUIThemeRed new]];
    } else {
        [[EUIThemeManager sharedInstance] applyTheme:[DUIThemeBlue new]];
    }
}

@end
