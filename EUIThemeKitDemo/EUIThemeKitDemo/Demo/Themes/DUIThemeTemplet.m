//
//  DUIThemeTemplet.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/23.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DUIThemeTemplet.h"
#import "DUITheme.h"
///< ThemeKit
#import "EUIThemeKit.h"
///< Components
#import "DUICustomView.h"
#import "DUICustomChildView.h"

@implementation EUIThemeManager(FDUITheme)

- (DUITheme *)applyingTheme {
    /// For easy access
    return (DUITheme *)self.currentTheme;
}

@end

@implementation DUIThemeTemplet

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applyThemeTempletConfiguration)
                                                     name:FDUIThemeDidChangeNotification
                                                   object:nil];
        [self applyThemeTempletConfiguration];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applyThemeTempletConfiguration {
    EUIThemeManager *manager = [EUIThemeManager sharedInstance];
    DUITheme *theme = manager.applyingTheme;
    ///===============================================
    /// 配置自定义视图组件的主题样式
    ///===============================================
    {///< 配置 Custom 视图
        DUICustomView *one = [DUICustomView eui_appearance];
        one.textColor = theme.fd_textColor;
        one.textFont = theme.fd_textFont;
        one.inner = theme.fd_insets;
        one.backgroundColor = theme.fd_backgrounndColor;
    }
    {///< 配置Custom 的子类
        DUICustomChildView *one = [DUICustomChildView eui_appearance];
        one.textColor = [UIColor yellowColor];
        one.textFont = theme.fd_textFont;
        one.inner = theme.fd_insets;
        one.backgroundColor = [UIColor brownColor];
    }
    ///=============================================================================
    /// 可配置系统组件，但通常不建议直接系统 UI，推荐通过继承的方式配置子类样式，这样可更加
    /// 有效地收敛风险和问题，避免修改底层引发不可预知的BUG；
    ///=============================================================================
    {///< 配置 Label
//        UILabel *label = [UILabel eui_appearance];
//        label.backgroundColor = DUISecondaryColor;
//        label.textColor = [UIColor blackColor];
    }
    {///< 配置 button
//        UIButton *button = [UIButton eui_appearance];
//        [button setBackgroundColor:DUIPrimaryColor];
//        [button setTitleColor:DUITextColor forState:UIControlStateNormal];
//        [button.titleLabel setFont:theme.fd_textFont];
    }
    {///< 设置 cell 的背景色额
//        UITableViewCell *cell = [UITableViewCell eui_appearance];
//        cell.backgroundColor = DUISecondaryColor;
    }
    {///< 也可直接配置一些私有组件的样式
//        id tableViewLabel = [NSClassFromString(@"UITableViewLabel") eui_appearance];
//        [tableViewLabel setBackgroundColor:[UIColor brownColor]];
    }
}

+ (UIColor *)fd_primaryColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        DUITheme *theme = manager.applyingTheme;
        return theme.fd_primaryColor;
    }];
}

+ (UIColor *)fd_secondaryColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        DUITheme *theme = manager.applyingTheme;
        return theme.fd_secondaryColor;
    }];
}

+ (UIColor *)fd_textColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        DUITheme *theme = manager.applyingTheme;
        return theme.fd_textColor;
    }];
}

+ (UIColor *)fd_backgrounndColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        DUITheme *theme = manager.applyingTheme;
        return theme.fd_backgrounndColor;
    }];
}

@end
