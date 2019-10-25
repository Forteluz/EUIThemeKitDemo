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
 
 */
- (void)eui_themeDidChange:(EUIThemeManager *)manager theme:(__kindof NSObject <EUIThemeProtocol> *)theme;

@end
