//
//  DemoThemeTemplet.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/23.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoThemeTemplet.h"
#import "DemoTheme.h"
///< Components
#import "DUICustomView.h"
#import "DUICustomChildView.h"

@implementation DemoThemeTemplet

+ (instancetype)sharedInstance {
    static DemoThemeTemplet *one;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        one = [[DemoThemeTemplet alloc] init];
    });
    return one;
}

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

+ (void)applyThemeTempletConfiguration {
    [[self sharedInstance] applyThemeTempletConfiguration];
}

- (void)applyThemeTempletConfiguration {
    EUIThemeManager *manager = [EUIThemeManager sharedInstance];
    DemoTheme *theme = manager.currentTheme;
    ///===============================================
    /// 配置自定义视图组件的主题样式
    ///===============================================
    {///< 配置 Custom 视图
        DUICustomView *one = [DUICustomView eui_appearance];
        one.textColor = theme.demo_textColor;
        one.textFont = theme.demo_textFont;
        one.inner = theme.demo_insets;
        one.backgroundColor = theme.demo_backgrounndColor;
    }
    {///< 配置 CustomChild 视图
        DUICustomChildView *one = [DUICustomChildView eui_appearance];
        one.textColor = [UIColor yellowColor];
        one.textFont = theme.demo_textFont;
        one.inner = theme.demo_insets;
        one.backgroundColor = [UIColor brownColor];
    }
}

+ (UIColor *)demo_primaryColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        DemoTheme *theme = manager.currentTheme;
        return theme.demo_primaryColor;
    }];
}

+ (UIColor *)demo_secondaryColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        DemoTheme *theme = manager.currentTheme;
        return theme.demo_secondaryColor;
    }];
}

+ (UIColor *)demo_textColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        DemoTheme *theme = manager.currentTheme;
        return theme.demo_textColor;
    }];
}

+ (UIColor *)demo_backgrounndColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        DemoTheme *theme = manager.currentTheme;
        return theme.demo_backgrounndColor;
    }];
}

@end
