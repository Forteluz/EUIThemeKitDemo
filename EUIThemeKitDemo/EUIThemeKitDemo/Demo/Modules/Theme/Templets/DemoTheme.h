//
//  FDUITheme.h
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/24.
//  Copyright © 2019 Lux. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUIThemeProtocol.h"

NS_ASSUME_NONNULL_BEGIN
///< Base Class
@interface DemoTheme : NSObject <EUIThemeProtocol>
- (UIColor *)demo_primaryColor;
- (UIColor *)demo_secondaryColor;
- (UIColor *)demo_textColor;
- (UIColor *)demo_backgrounndColor;
- (UIFont  *)demo_textFont;
- (UIEdgeInsets)demo_insets;
@end

@interface DemoThemeRed   : DemoTheme @end
@interface DemoThemeBlue  : DemoTheme @end
@interface DemoThemeDark  : DemoTheme @end
@interface DemoThemeLight : DemoTheme @end

NS_ASSUME_NONNULL_END
