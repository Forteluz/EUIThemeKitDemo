//
//  FDUIColorTemplet.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/23.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "FDUIColorTemplet.h"
///< ThemeKit
#import "EUIThemeKit.h"
#import "FDUITheme.h"
///< Components
#import "FDUIColorTestView.h"
#import "FDUIColorTest2View.h"
#import "EUIDynamicAppearance.h"

@implementation EUIThemeManager(FDUITheme)

- (FDUITheme *)applyingTheme {
    /// For easy access
    return (FDUITheme *)self.currentTheme;
}

@end

@implementation FDUIColorTemplet

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateTemplet)
                                                     name:FDUIThemeDidChangeNotification
                                                   object:nil];
        [self updateTemplet];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateTemplet {
    EUIThemeManager *manager = [EUIThemeManager sharedInstance];
    FDUITheme *theme = manager.applyingTheme;
    
    
    UILabel *label = [UILabel eui_appearance];
       label.backgroundColor = FDUISecondaryColor;
       label.textColor = [UIColor blackColor];

    ///< 测试视图组件
    FDUIColorTestView *testView = [FDUIColorTestView eui_appearance];
    testView.textColor = theme.fd_textColor; // FDUITextColor;
    testView.textFont = theme.fd_textFont;
    testView.inner = theme.fd_insets;
    testView.backgroundColor = FDUISecondaryColor;

    FDUIColorTest2View *test2View = [FDUIColorTest2View eui_appearance];
    test2View.textColor = [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        return [UIColor yellowColor];
    }];
    test2View.textFont = [UIFont boldSystemFontOfSize:20];
    test2View.inner = theme.fd_insets;
    test2View.backgroundColor = FDUISecondaryColor;
    
    ///< 系统组件
//    UIButton *button = [UIButton eui_appearance];
//    [button setBackgroundColor:FDUIPrimaryColor];
//    [button setTitleColor:FDUITextColor forState:UIControlStateNormal];
//    [button.titleLabel setFont:theme.fd_textFont];
//
//    UITableViewCell *cell = [UITableViewCell eui_appearance];
//    cell.backgroundColor = FDUISecondaryColor;
//
   
//
//    id tableViewLabel = [NSClassFromString(@"UITableViewLabel") eui_appearance];
//    [tableViewLabel setBackgroundColor:[UIColor brownColor]];
}

+ (UIColor *)fd_primaryColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        FDUITheme *theme = manager.applyingTheme;
        return theme.fd_primaryColor;
    }];
}

+ (UIColor *)fd_secondaryColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        FDUITheme *theme = manager.applyingTheme;
        return theme.fd_secondaryColor;
    }];
}

+ (UIColor *)fd_textColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        FDUITheme *theme = manager.applyingTheme;
        return theme.fd_textColor;
    }];
}

+ (UIColor *)fd_backgrounndColor {
    return [UIColor eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        FDUITheme *theme = manager.applyingTheme;
        return theme.fd_backgrounndColor;
    }];
}

@end
