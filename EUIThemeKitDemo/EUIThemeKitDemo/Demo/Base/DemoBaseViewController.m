//
//  DemoBaseViewController.m
//  FrameWorksTest
//
//  Created by Lux on 2019/9/18.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoBaseViewController.h"

@interface DemoBaseViewController()
@end
@implementation DemoBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.caser = [[FDCaser alloc] init];
    self.helper = [[FDHelper alloc] init];
}

@end