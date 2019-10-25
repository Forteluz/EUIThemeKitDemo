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
@interface DUITheme : NSObject <EUIThemeProtocol>
- (UIColor *)fd_primaryColor;
- (UIColor *)fd_secondaryColor;
- (UIColor *)fd_textColor;
- (UIColor *)fd_backgrounndColor;
- (UIFont  *)fd_textFont;
- (UIEdgeInsets)fd_insets;
@end

@interface DUIThemeRed  : DUITheme @end
@interface DUIThemeBlue : DUITheme @end

NS_ASSUME_NONNULL_END
