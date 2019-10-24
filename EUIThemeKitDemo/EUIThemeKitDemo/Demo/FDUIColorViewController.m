//
//  FDUIColorViewController.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/22.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "FDUIColorViewController.h"
///< Component
#import "FDUIColorTestView.h"
#import "FDUIColorTest2View.h"
///< Theme
#import "EUIThemeKit.h"
#import "FDUIColorTemplet.h"
#import "FDUITheme.h"

@implementation FDUIColorViewController {
    FDUIColorTemplet *_themeTemplet;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    ///< 配置主题
    _themeTemplet = [FDUIColorTemplet new];
    
    ///< 应用主题
    [self.view setBackgroundColor:FDUIBackgroundColor];
    
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
    FDUIColorTestView *one = [[FDUIColorTestView alloc] initWithFrame:CGRectMake(100, 230, 100, 100)];
    [self.view addSubview:one];
}

- (void)p_addTest2ViewComponent {
    FDUIColorTest2View *one = [[FDUIColorTest2View alloc] initWithFrame:CGRectMake(100, 330, 100, 100)];
    [self.view addSubview:one];
}

#pragma mark - ---| Action |---

- (void)tapAction {
    NSLog(@"点击切换主题");
    id <EUIThemeProtocol> theme = [EUIThemeManager sharedInstance].currentTheme;
    if ([theme.identifier isEqualToString:@"red"]) {
        [[EUIThemeManager sharedInstance] applyTheme:[FDUIBlueTheme new]];
    } else if ([theme.identifier isEqualToString:@"blue"]) {
        [[EUIThemeManager sharedInstance] applyTheme:[FDUIRedTheme new]];
    } else {
        [[EUIThemeManager sharedInstance] applyTheme:[FDUIBlueTheme new]];
    }
}

@end
