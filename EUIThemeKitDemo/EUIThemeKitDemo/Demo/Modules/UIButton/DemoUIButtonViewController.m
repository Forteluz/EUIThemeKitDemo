//
//  DemoUIButtonViewController.m
//  EUIThemeKitDemo
//
//  Created by Lux on 2019/10/25.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoUIButtonViewController.h"
#import "EUIThemeKit.h"

@interface DemoUIButtonViewController ()
@end

@implementation DemoUIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *one = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    one.appearanceIdentifier = @"";
    [one setFrame:CGRectMake(10, 44 + 20, self.view.bounds.size.width - 20, 50)];
    [one setTitle:@"点击更新所有的 UIButton 样式" forState:UIControlStateNormal];
    [one addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:one];
}

- (void)tapAction {
    UIButton *button = [UIButton eui_appearance];
    button.appearanceIdentifier = @"";
    [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [self.view eui_updateThemeStyleIfNeeded];
}

@end
