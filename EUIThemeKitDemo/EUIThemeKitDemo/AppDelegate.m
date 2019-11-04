//
//  AppDelegate.m
//  EUIThemeKitDemo
//
//  Created by Lux on 2019/10/24.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "AppDelegate.h"
#import "EUIThemeManager.h"
#import "DemoThemeTemplet.h"
#import "DemoSystemUIThemeTemplet.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerTheme];
    return YES;
}

- (void)registerTheme {
    ///< 应用一套配置自定义 UI 的模板配置
    [DemoThemeTemplet applyThemeTempletConfiguration];

    ///< 应用一套配置系统 UI 的模板配置
    [DemoSystemUIThemeTemplet applyThemeTempletConfiguration];
    
    ///< 注册一个主题
    [[EUIThemeManager sharedInstance] applyTheme:[DemoThemeRed new]];
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
