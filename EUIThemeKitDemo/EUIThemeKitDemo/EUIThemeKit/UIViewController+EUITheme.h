//
//  UIViewController+EUITheme.h
//  EUIThemeKitDemo
//
//  Created by Lux on 2019/10/24.
//  Copyright © 2019 Lux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUIThemeManager.h"

@interface UIViewController (EUITheme)

/*!
 收到更新主题的回调， 显示调用 eui_updateThemeStyleIfNeeded 也会触发此逻辑；
 */
- (void)eui_themeDidChange:(EUIThemeManager *)manager theme:(__kindof NSObject <EUIThemeProtocol> *)theme NS_REQUIRES_SUPER;

/*!
 
 */
- (void)eui_updateThemeStyleIfNeeded;

@end
