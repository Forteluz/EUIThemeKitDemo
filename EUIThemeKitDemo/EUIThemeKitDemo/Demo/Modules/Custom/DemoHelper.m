//
//  DemoHelper.m
//  EUIThemeKitDemo
//
//  Created by Lux on 2019/10/30.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoHelper.h"

@implementation DemoHelper

+ (void)setNaviBarRightItem:(NSString *)title
                     target:(UIViewController *)target
                        sel:(SEL)sel
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:sel];
    UINavigationBar *bar = target.navigationController.navigationBar;
    NSArray *items = bar.items;
    UINavigationItem *barItem = items[0];
    barItem.rightBarButtonItem = item;
}

+ (void)setNaviBarLeftItem:(NSString *)title
                    target:(UIViewController *)target
                       sel:(SEL)sel
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:sel];
    UINavigationBar *bar = target.navigationController.navigationBar;
    NSArray *items = bar.items;
    UINavigationItem *barItem = items[0];
    barItem.leftBarButtonItem = item;
}


@end
