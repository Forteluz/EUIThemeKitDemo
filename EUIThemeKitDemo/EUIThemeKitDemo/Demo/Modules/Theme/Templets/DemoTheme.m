//
//  FDUITheme.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/24.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoTheme.h"

@implementation DemoTheme
@synthesize identifier = _identifier;
- (UIColor *)demo_primaryColor { return nil; }
- (UIColor *)demo_secondaryColor { return nil; }
- (UIColor *)demo_textColor { return nil; }
- (UIColor *)demo_backgrounndColor { return nil; }
- (UIFont  *)demo_textFont { return nil; }
- (UIEdgeInsets)demo_insets { return UIEdgeInsetsZero; }
@end

@implementation DemoThemeRed

- (NSString *)identifier {
    return @"red";
}

- (UIColor *)demo_primaryColor {
    return [UIColor redColor];
}

- (UIColor *)demo_secondaryColor {
    return [UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:1];
}

- (UIColor *)demo_textColor {
    return [UIColor whiteColor];
}

- (UIColor *)demo_backgrounndColor {
    return [[self demo_primaryColor] colorWithAlphaComponent:0.4];
}

- (UIFont  *)demo_textFont {
    return [UIFont systemFontOfSize:12];
}

- (UIEdgeInsets)demo_insets {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end

@implementation DemoThemeBlue

- (NSString *)identifier {
    return @"blue";
}

- (UIColor *)demo_primaryColor {
    return [UIColor blueColor];
}

- (UIColor *)demo_secondaryColor {
    return [UIColor colorWithRed:0.2 green:0.2 blue:0.8 alpha:1];
}

- (UIColor *)demo_textColor {
    return [UIColor redColor];
}

- (UIColor *)demo_backgrounndColor {
    return [[self demo_primaryColor] colorWithAlphaComponent:0.4];
}

- (UIFont  *)demo_textFont {
    return [UIFont systemFontOfSize:20];
}

- (UIEdgeInsets)demo_insets {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end


@implementation DemoThemeDark

- (NSString *)identifier {
    return @"dark";
}

- (UIColor *)demo_primaryColor {
    return [UIColor blackColor];
}

- (UIColor *)demo_secondaryColor {
    return [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
}

- (UIColor *)demo_textColor {
    return [UIColor whiteColor];
}

- (UIColor *)demo_backgrounndColor {
    return [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
}

- (UIFont  *)demo_textFont {
    return [UIFont systemFontOfSize:14];
}

- (UIEdgeInsets)demo_insets {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end


@implementation DemoThemeLight

- (NSString *)identifier {
    return @"light";
}

- (UIColor *)demo_primaryColor {
    return [UIColor whiteColor];
}

- (UIColor *)demo_secondaryColor {
    return [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
}

- (UIColor *)demo_textColor {
    return [UIColor blackColor];
}

- (UIColor *)demo_backgrounndColor {
    return [self demo_primaryColor];
}

- (UIFont  *)demo_textFont {
    return [UIFont systemFontOfSize:16];
}

- (UIEdgeInsets)demo_insets {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
