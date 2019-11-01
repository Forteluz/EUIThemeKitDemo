//
//  DemoSystemUIThemeTemplet.m
//  EUIThemeKitDemo
//
//  Created by Lux on 2019/10/30.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoSystemUIThemeTemplet.h"

@implementation DemoSystemUIThemeTemplet

+ (instancetype)sharedInstance {
    static DemoSystemUIThemeTemplet *one;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        one = [[DemoSystemUIThemeTemplet alloc] init];
    });
    return one;
}

- (void)applyThemeTempletConfiguration {
    EUIThemeManager *manager = [EUIThemeManager sharedInstance];
    DemoTheme *theme = manager.currentTheme;
    
    ///=============================================================================
    /// 虽然可配置系统组件样式，但不建议直接修改（在咱们的工程中），推荐通过继承的方式配置子类样式，
    /// 这样可有效地降低风险，避免修改底层 UI 引发不可预知的BUG；
    ///=============================================================================

    ///< 配置 Label
    UILabel *label = [UILabel eui_appearance];
    label.backgroundColor = DemoSecondaryColor;
    label.textColor = [UIColor blackColor];

    ///< 配置 button
    UIButton *button = [UIButton eui_appearance];
    [button setBackgroundColor:DemoPrimaryColor];
    [button setTitleColor:DemoTextColor forState:UIControlStateNormal];
    [button.titleLabel setFont:theme.demo_textFont];

    ///< 设置 cell 的背景色
    UITableViewCell *cell = [UITableViewCell eui_appearance];
    cell.backgroundColor = DemoSecondaryColor;
    
    ///< 也可直接配置一些私有组件的样式
    id tableViewLabel = [NSClassFromString(@"UITableViewLabel") eui_appearance];
    [tableViewLabel setBackgroundColor:[UIColor brownColor]];
}

@end
