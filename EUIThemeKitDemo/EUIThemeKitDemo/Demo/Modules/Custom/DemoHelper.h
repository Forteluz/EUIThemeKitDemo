//
//  DemoHelper.h
//  EUIThemeKitDemo
//
//  Created by Lux on 2019/10/30.
//  Copyright © 2019 Lux. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoHelper : NSObject

+ (void)setNaviBarRightItem:(NSString *)title
                     target:(UIViewController *)target
                        sel:(SEL)sel;

+ (void)setNaviBarLeftItem:(NSString *)title
                    target:(UIViewController *)target
                       sel:(SEL)sel;


@end

NS_ASSUME_NONNULL_END
