//
//  DUIThemeTemplet.h
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/23.
//  Copyright © 2019 Lux. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 通常的主题设计体系中，都会定义一些主题色（如主色，副色，文字色等）
 */
#define DUIPrimaryColor        [DUIThemeTemplet fd_primaryColor]
#define DUISecondaryColor      [DUIThemeTemplet fd_secondaryColor]
#define DUITextColor           [DUIThemeTemplet fd_textColor]
#define DUIBackgroundColor     [DUIThemeTemplet fd_backgrounndColor]

/*!
 主题模板，配置组件样式，同时解耦组件和主题库之间的依赖关系。
 */
@interface DUIThemeTemplet : NSObject

/*!
 应用一个主题模板的配置，应该在这个方法中定义各组件的样式；
 */
- (void)applyThemeTempletConfiguration;

/*!
 定义一些和设计同步的主题协议，以下协议都是随主题变化的动态内容
 */
+ (UIColor *)fd_primaryColor;
+ (UIColor *)fd_secondaryColor;
+ (UIColor *)fd_textColor;
+ (UIColor *)fd_backgrounndColor;

@end
