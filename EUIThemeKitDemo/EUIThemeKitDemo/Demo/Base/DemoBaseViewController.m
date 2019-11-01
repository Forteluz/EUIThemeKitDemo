//
//  DemoBaseViewController.m
//  FrameWorksTest
//
//  Created by Lux on 2019/9/18.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoBaseViewController.h"
#import "DemoThemeViewController.h"

@interface DemoBaseViewController()
@end
@implementation DemoBaseViewController

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
}

@end
