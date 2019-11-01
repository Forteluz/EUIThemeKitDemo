//
//  UIView+FDUIColor.h
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/23.
//  Copyright © 2019 Lux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUIThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (EUITheme)

/*!
 也可实现 block 做主题切换的相关逻辑
 */
@property (nonatomic, copy) void (^eui_themeDidChange)(__kindof UIView *oneSelf, EUIThemeManager *manager);

/*!
 UIView 收到主题更新的回调，可以继承该方法并在这个回调中处理自己的换肤逻辑
 （显示调用 eui_updateThemeStyleIfNeeded 也会触发此逻辑）
 */
- (void)eui_themeDidChange:(EUIThemeManager *)manager theme:(__kindof NSObject <EUIThemeProtocol> *)theme NS_REQUIRES_SUPER;

/*!
 强制更新为当前的主题，会触发 eui_themeDidChange:theme: 方法回调；
 */
- (void)eui_updateThemeStyleIfNeeded;

@end

NS_ASSUME_NONNULL_END
