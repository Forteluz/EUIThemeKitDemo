//
//  EUIDynamicAppearance.h
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/24.
//  Copyright © 2019 Lux. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 UIView 动态换肤功能接口
 */
@interface NSObject(EUIAppearance)

/*!
 使用 + (instancetype)eui_appearance 可获得获得一个 UIAppearance 实例，可以动态注册 UI_APPEARANCE_SELECTOR 属性，当主题切换时，这些 UI_APPEARANCE_SELECTOR 属性会自动得到 setter 调用。
 */
+ (instancetype)eui_appearance;

/*!
 获得一个指定 identifier 的 UIAppearance 对象
 */
+ (instancetype)eui_appearanceByIDs:(NSArray <NSString *> *)identifiers;

/*!
 可指定一个外观 ID，绑定了外观 ID 的 UIView 及其子类只会被同样 ID 的 Appearance 更新
 默认是 @"default_appearance_id"
 */
@property (nonatomic, copy, setter=eui_setAppearanceIdentifier:) NSString *eui_appearanceIdentifier;

/*!
 让视图已注册的 Appearance 属性立即生效！
 接口非线程安全
 */
- (void)eui_makeDynamicAppearance;

/*!
 可关闭对象的动态更新功能，默认读取 [UIView isDynamicAppearance]
 */
@property (nonatomic, assign, getter=eui_isDynamicAppearance, setter=eui_setDynamicAppearance:) BOOL dynamicAppearance;

/*!
 更改全局默认值，该值会被缓存
 */
@property (nonatomic, assign, class, getter=eui_isDynamicAppearance, setter=eui_setDynamicAppearance:) BOOL eui_dynamicAppearance;

@end


NS_ASSUME_NONNULL_END
