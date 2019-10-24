//
//  EUIDynamicAppearance.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/24.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "EUIDynamicAppearance.h"
#import "EUIHelper.h"

#define EUI_APPEARANCE_REGISTER(_cls_, _invocation_) \
[_EUIDynamicAppearanceRegister bindClass:_cls_ invocation:_invocation_];

#define EUI_APPEARANCE_SETTERS(_cls_) \
[_EUIDynamicAppearanceRegister invocationsByClass:_cls_];

#pragma mark - ---| EUIDynamicAppearance |---

@interface _EUIDynamicAppearanceRegister : NSObject
@property (nonatomic, strong) NSMutableDictionary *setters;
@end
@implementation _EUIDynamicAppearanceRegister

+ (instancetype)sharedInstance {
    static _EUIDynamicAppearanceRegister *one;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        one = [[_EUIDynamicAppearanceRegister alloc] init];
    });
    return one;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _setters = @{}.mutableCopy;
    }
    return self;
}

+ (void)bindClass:(Class)class invocation:(NSInvocation *)invocation {
    [[self sharedInstance] bindClass:class invocation:invocation];
}

- (void)bindClass:(Class)class invocation:(NSInvocation *)invocation {
    /*! @{ cls : @{ @"sel" : invocation,
                    @"sel" : invocation,
                    @"sel" : invocation,
                  },
           cls : @{ ... },
         }
     */
    NSString *sel = NSStringFromSelector(invocation.selector);
    NSString *cls = NSStringFromClass(class);
    NSMutableDictionary *setterInfo = self.setters[cls];
    if (setterInfo == nil) {
        setterInfo = @{}.mutableCopy;
        self.setters[cls] = setterInfo;
    }
    [setterInfo setObject:invocation forKey:sel];
}

+ (NSArray <NSInvocation *> *)invocationsByClass:(Class)cls {
    return [[self sharedInstance] invocationsByClass:cls];
}

- (NSArray <NSInvocation *> *)invocationsByClass:(Class)cls {
    NSMutableDictionary *setterInfo = self.setters[NSStringFromClass(cls)];
    if (!!setterInfo) {
        return [setterInfo allValues];
    }
    return nil;
}

@end

@interface _EUIDynamicAppearance : NSObject
@property (nonatomic, weak) NSObject *object;
@property (nonatomic, assign) Class cls;
@end
@implementation _EUIDynamicAppearance
@end

#pragma mark - ---| NSObject(EUIDynamicAppearance) |---

static const void *kEUIDynamicAppearanceKey = &kEUIDynamicAppearanceKey;

@implementation NSObject(EUIDynamicAppearance)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [EUIHelper hookClass:NSClassFromString(@"_UIAppearance")
                fromSelector:@selector(forwardInvocation:)
                  toSelector:@selector(eui_forwardInvocation:)];
    });
}

- (void)set_euiDynamicAppearance:(_EUIDynamicAppearance *)one {
    objc_setAssociatedObject(self, kEUIDynamicAppearanceKey, one, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (_EUIDynamicAppearance *)eui_dynamicAppearance {
    return objc_getAssociatedObject(self, kEUIDynamicAppearanceKey);
}

+ (instancetype)eui_appearance {
    Class cls = [self class];
    NSObject *appearance = [cls appearance];
    
    _EUIDynamicAppearance *one = [appearance eui_dynamicAppearance];
    if ([appearance eui_dynamicAppearance] == nil) {
        [appearance set_euiDynamicAppearance:({
            one = [_EUIDynamicAppearance new];
            one;
        })];
    }
    one.object = one;
    one.cls = cls;
    
    return appearance;
}

- (BOOL)eui_forwardInvocation:(NSInvocation *)anInvocation {
    _EUIDynamicAppearance *dynamic = [self eui_dynamicAppearance];
    if (!!dynamic) EUI_APPEARANCE_REGISTER(dynamic.cls, anInvocation);
    return [self eui_forwardInvocation:anInvocation];
}

- (NSArray <NSInvocation *> *)eui_registeredSetters {
    Class cls = [self class];
    return EUI_APPEARANCE_SETTERS(cls);
}

- (void)eui_invokeEUIAppearanceSelectors {
    NSArray <NSInvocation *> *setters = [self eui_registeredSetters];
    if ( setters ) {
        [setters enumerateObjectsUsingBlock:^(NSInvocation *obj, NSUInteger idx, BOOL *stop) {
            [obj invokeWithTarget:self];
            [obj invoke];
        }];
        NSLog(@"自动更新 %@ 的Appearance属性",NSStringFromClass(self.class));
    }
}

@end
