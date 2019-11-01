//
//  UIViewController+EUITheme.m
//  EUIThemeKitDemo
//
//  Created by Lux on 2019/10/24.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "UIViewController+EUITheme.h"
#import "UIView+EUITheme.h"

@implementation UIViewController (EUITheme)

- (void)eui_themeDidChange:(id)manager theme:(id <EUIThemeProtocol>)theme {
    NSArray *childs = self.childViewControllers;
    [childs enumerateObjectsUsingBlock:^(UIViewController *child, NSUInteger idx, BOOL *stop) {
        [child eui_themeDidChange:manager theme:theme];
    }];
    
    if (self.presentedViewController &&
        self.presentedViewController.presentingViewController == self)
    {
        [self.presentedViewController eui_themeDidChange:manager theme:theme];
        if ([self.presentedViewController isViewLoaded]) {
            [self.presentedViewController.view eui_themeDidChange:manager theme:theme];
        }
    }
}

- (void)eui_updateThemeStyleIfNeeded {
    EUIThemeManager *one = [EUIThemeManager sharedInstance];
    [self eui_themeDidChange:one theme:one.currentTheme];
}

@end
