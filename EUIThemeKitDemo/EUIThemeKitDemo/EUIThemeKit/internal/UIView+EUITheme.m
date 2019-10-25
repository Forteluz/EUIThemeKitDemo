//
//  UIView+FDUIColor.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/23.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "UIView+EUITheme.h"
#import "EUIThemeManager.h"
#import "NSObject+EUITheme.h"
#import "EUIAppearance.h"
#import "EUIHelper.h"

static const void *kFDBackgroundColorKey = &kFDBackgroundColorKey;
static const void *kFDBorderColorKey = &kFDBorderColorKey;

@interface CALayer (EUITheme) @end
@implementation CALayer(EUITheme)

- (void)fd_setOriginBackgroundColor:(UIColor *)fd_backgroundColor {
    objc_setAssociatedObject(self, kFDBackgroundColorKey, fd_backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)fd_originBackgroundColor {
    return objc_getAssociatedObject(self, kFDBackgroundColorKey);
}

- (void)fd_setOriginBorderColor:(UIColor *)fd_backgroundColor {
    objc_setAssociatedObject(self, kFDBorderColorKey, fd_backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)fd_originBorderColor {
    return objc_getAssociatedObject(self, kFDBorderColorKey);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [EUIHelper hookClass:CALayer.class
                fromSelector:@selector(setBackgroundColor:)
                  toSelector:@selector(fd_setBackgroundColor:)];
        [EUIHelper hookClass:CALayer.class
                fromSelector:@selector(setBorderColor:)
                  toSelector:@selector(fd_setBorderColor:)];
    });
}

- (void)fd_setBackgroundColor:(CGColorRef)backgroundColor {
    /*!
     CALayer 绘制的时候使用的是 CGColorRef ，为了触发 FDUIColor 的回调，需要将两者做一个关系绑定
     */
    UIColor *color = nil;
    if (backgroundColor) {
        color = [(__bridge id)backgroundColor fd_colorByCGColor];
    }
    [self fd_setOriginBackgroundColor:color];
    [self fd_setBackgroundColor:backgroundColor];
}

- (void)fd_setBorderColor:(CGColorRef)borderColor {
    [self fd_setBorderColor:borderColor];
    [self fd_setOriginBorderColor:[(__bridge id)borderColor fd_colorByCGColor]];
}

- (void)fd_displayIfNeeded {
    CGColorRef backgroundColor = [self fd_originBackgroundColor].CGColor;
    if (backgroundColor) {
        self.backgroundColor = backgroundColor;
    }
    CGColorRef borderColor = [self fd_originBorderColor].CGColor;
    if (borderColor) {
        self.borderColor = borderColor;
    }
}

@end

@implementation UIView (EUITheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [EUIHelper hookClass:UIView.class
                fromSelector:@selector(setBackgroundColor:)
                  toSelector:@selector(fd_setBackgroundColor:)];
    });
}

- (void)fd_setBackgroundColor:(UIColor *)color {
    [self.layer setBackgroundColor:nil];
    [self fd_setBackgroundColor:color];
}

- (void)eui_themeDidChange:(EUIThemeManager *)manager theme:(__kindof NSObject <EUIThemeProtocol> *)theme {
    /*!
     视图树开始递归换肤
     */
    NSArray *subviews = [self subviews];
    [subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj eui_themeDidChange:manager theme:theme];
    }];
    
    /*!
     自动调用 EUIAppearance
     */
    [self eui_invokeSelectors];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.layer fd_displayIfNeeded];
    [CATransaction commit];
}

- (void)eui_updateThemeStyleIfNeeded {
    EUIThemeManager *one = [EUIThemeManager sharedInstance];
    [self eui_themeDidChange:one theme:one.currentTheme];
}

@end
