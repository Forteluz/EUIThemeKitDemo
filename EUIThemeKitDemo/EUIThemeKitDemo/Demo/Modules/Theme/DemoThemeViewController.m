//
//  DemoThemeViewController.m
//  EUIThemeKitDemo
//
//  Created by Lux on 2019/10/30.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DemoThemeViewController.h"
#import "DemoThemeTemplet.h"

#define NEW_BUTTON(_TITLE_, _FRAME_) \
({ \
UIButton *one = [UIButton buttonWithType:UIButtonTypeRoundedRect]; \
[one setFrame:_FRAME_]; \
[one setTitle:_TITLE_ forState:UIControlStateNormal]; \
[one addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside]; \
[self.view addSubview:one]; \
one; \
})

@interface DemoThemeViewController ()
@end

@implementation DemoThemeViewController

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"切换主题"];
    
    CGRect r = CGRectMake(10, 44 + 20, self.view.bounds.size.width - 20, 50);
    {
        UIButton *one = NEW_BUTTON(@"RED", r);
        one.tag = 1;
        one.backgroundColor = nil;
    }
    r.origin.y = CGRectGetMaxY(r) + 10;
    {
        UIButton *one = NEW_BUTTON(@"BLUE", r);
        one.tag = 2;
        one.backgroundColor = nil;
    }
    r.origin.y = CGRectGetMaxY(r) + 10;
    {
        UIButton *one = NEW_BUTTON(@"DARK", r);
        one.tag = 3;
        one.backgroundColor = nil;
    }
    r.origin.y = CGRectGetMaxY(r) + 10;
    {
        UIButton *one = NEW_BUTTON(@"LIGHT", r);
        one.tag = 4;
        one.backgroundColor = nil;
    }
}

- (void)action:(UIButton *)button {
    DemoTheme *theme = nil;
    switch (button.tag) {
        case 1:
            theme = [DemoThemeRed new];
            break;
        case 2:
            theme = [DemoThemeBlue new];
            break;
        case 3:
            theme = [DemoThemeDark new];
            break;
        default:
            theme = [DemoThemeLight new];
            break;
    }
    [[EUIThemeManager sharedInstance] applyTheme:theme];
}

@end
