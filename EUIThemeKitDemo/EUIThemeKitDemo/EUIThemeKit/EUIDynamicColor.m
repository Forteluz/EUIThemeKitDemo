//
//  FDUIColor.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/22.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "EUIDynamicColor.h"
#import "EUIThemeManager.h"
#import "NSObject+EUITheme.h"

@interface EUIDynamicColor : UIColor
@property (nonatomic, copy) UIColor *(^provider)(EUIThemeManager *);
@end
@implementation EUIDynamicColor

- (instancetype)copyWithZone:(NSZone *)zone {
    EUIDynamicColor *color = [[self class] allocWithZone:zone];
    color.provider = self.provider;
    return color;
}

- (void)set {
    /*!
     需要重写 set 方法，如 UILabel 内部绘制会使用 UIColor.set :
     [UILabel drawRect:]
     [UILabel drawTextInRect:]
     [UILabel _drawTextInRect:baselineCalculationOnly:]
     [NSString(NSExtendedStringDrawing) drawWithRect:options:attributes:context:]
     ...
     [EUIDynamicColor set]
     */
    [self.p_dynamicColor set];
}

- (void)setFill {
    ///< 同 set 方法，CG库绘制用
    [self.p_dynamicColor setFill];
}

- (void)setStroke {
    ///< 同 set 方法，CG库绘制用
    [self.p_dynamicColor setStroke];
}

- (CGColorRef)CGColor {
    /*!
     有的地方直接用 CGColor（比如 layer.borderColor 或者 layer.shadowColor），所以需要将回调绑定给 CGColor
     以便在 setter 时可触发 UIColor 的 provider 回调；
     */
    CGColorRef colorRef = [UIColor colorWithCGColor:self.p_dynamicColor.CGColor].CGColor;
    ///< toll-free 转成 NSObject 用 runtime 建立和 color 的关系
    NSObject *objRef = (__bridge id)colorRef;
    [objRef setFd_colorByCGColor:self];
    return colorRef;
}

- (UIColor *)p_dynamicColor {
    if (self.provider) {
        return self.provider([EUIThemeManager sharedInstance]);
    }
    return nil;
}

- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha {
    return [self.class eui_colorWithProvider:^UIColor *(EUIThemeManager *manager) {
        return [self.p_dynamicColor colorWithAlphaComponent:alpha];
    }];
}

/*!
 文档规定 isEqual 和 hash 需要同时实现
 “Make sure you also define hash in your subclass.”
 */
- (BOOL)isEqual:(id)object {
    return self == object;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger)self.provider;
    return hash;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, dynamic color = %@",
            [super description],
            self.p_dynamicColor];
}

@end

@implementation UIColor(FDColor)

+ (UIColor *)eui_colorWithProvider:(UIColor *(^)(EUIThemeManager *))provider {
    EUIDynamicColor *color = [[EUIDynamicColor alloc] init];
    color.provider = provider;
    return color;
}

@end
