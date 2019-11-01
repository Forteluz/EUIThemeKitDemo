//
//  DUICustomView.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/23.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "DUICustomView.h"

@implementation DUICustomView {
    UILabel *_label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.text = @"我是测试视图";
        _label.numberOfLines = 0;
        [self addSubview:_label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = CGRectMake(self.inner.left,
                              self.inner.top,
                              self.bounds.size.width - self.inner.left - self.inner.right,
                              self.bounds.size.height - self.inner.top - self.inner.bottom);
}

- (void)setInner:(UIEdgeInsets)inner {
    if (!UIEdgeInsetsEqualToEdgeInsets(_inner, inner)) {
        _inner = inner;
        [self setNeedsLayout];
    }
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    if (_label) {
        _label.font = textFont;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    if (_label) {
        _label.textColor = textColor;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_label) {
        _label.text = title;
    }
}

@end

@implementation DUICustomView(FDUIAppearance)

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DUICustomView *one = [DUICustomView appearance];
        one.textFont = [UIFont systemFontOfSize:20];
        one.textColor = [UIColor blackColor];
        one.inner = UIEdgeInsetsMake(10, 10, 10, 10);
        one.backgroundColor = [UIColor grayColor];
    });
}

@end
