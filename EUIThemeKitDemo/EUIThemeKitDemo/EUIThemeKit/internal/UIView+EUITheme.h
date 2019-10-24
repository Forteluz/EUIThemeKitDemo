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

@interface CALayer (EUITheme)
@end

@interface UIView (EUITheme)
- (void)eui_themeDidChange:(id)manager theme:(id <EUIThemeProtocol>)theme;
@end

NS_ASSUME_NONNULL_END
