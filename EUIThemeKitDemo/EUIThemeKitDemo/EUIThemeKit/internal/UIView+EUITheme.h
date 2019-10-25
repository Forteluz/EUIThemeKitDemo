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
 UIView 收到主题更新的回调，可以继承该方法并在这个回调中处理自己的换肤逻辑
 */
- (void)eui_themeDidChange:(EUIThemeManager *)manager theme:(__kindof NSObject <EUIThemeProtocol> *)theme;

/*!
 强制更新为当前的主题，会触发 eui_themeDidChange:theme: 方法回调；
 */
- (void)eui_updateThemeStyleIfNeeded;

@end

NS_ASSUME_NONNULL_END
