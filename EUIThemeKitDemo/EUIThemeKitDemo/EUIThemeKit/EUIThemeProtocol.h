//
//  FDUIThemeProtocol.h
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/24.
//  Copyright © 2019 Lux. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EUIThemeProtocol <NSObject>

/*!
 主题需要指定唯一标识
 @warning identifier 不能重复
 */
@property (nonatomic, copy) NSString *identifier;

@end
