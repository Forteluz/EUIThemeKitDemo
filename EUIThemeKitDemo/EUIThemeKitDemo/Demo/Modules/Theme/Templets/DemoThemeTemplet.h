//
//  DemoThemeTemplet.h
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/23.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoTheme.h"
#import "EUIThemeKit.h"

///===========================================================
/// 通常的主题设计体系中，都会定义一些主题色（如主色，副色，文字色等）
///===========================================================
/// 主题第一主色
#define DemoPrimaryColor        [DemoThemeTemplet demo_primaryColor]
/// 主题第二主色
#define DemoSecondaryColor      [DemoThemeTemplet demo_secondaryColor]
/// 主题文字色
#define DemoTextColor           [DemoThemeTemplet demo_textColor]
/// 主题页面背景色
#define DemoBackgroundColor     [DemoThemeTemplet demo_backgrounndColor]

/*!
 主题模板，解耦「组件」和「主题库」以及「主题规范」三者之间的依赖关系, 职责主要是：
 1、定义主题的设计体系规范，即主题定义，这里中我们定义为 DemoTheme 对象，并提供相关主题接口；
 2、配置全局组件的样式设置；
 3、响应主题变化后更新主题配置；
 */
@interface DemoThemeTemplet : NSObject

/*!
 可获得全局唯一的主题模板实例
 */
+ (instancetype)sharedInstance;

/*!
 应用一个主题模板的配置，应该在这个方法中定义各组件的样式；
 */
+ (void)applyThemeTempletConfiguration;
- (void)applyThemeTempletConfiguration;

/*!
 定义一些和设计同步的主题协议，以下协议都是随主题变化的动态内容
 */
+ (UIColor *)demo_primaryColor;
+ (UIColor *)demo_secondaryColor;
+ (UIColor *)demo_textColor;
+ (UIColor *)demo_backgrounndColor;

@end
