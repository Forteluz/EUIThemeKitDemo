//
//  EUIDynamicAppearance.m
//  FrameworksDemoProject
//
//  Created by Lux on 2019/10/24.
//  Copyright © 2019 Lux. All rights reserved.
//

#import "EUIAppearance.h"
#import "EUIHelper.h"

#pragma mark - ---| EUIDynamicAppearance Access |---

#define EUI_APPEARANCE_REGISTER(_CLASS_, _INVOCATION_) \
    [_EUIDynamicAppearanceRegister bindClass:_CLASS_ invocation:_INVOCATION_]

#define EUI_APPEARANCE_SETTERS(_CLASS_) \
    [_EUIDynamicAppearanceRegister invocations:_CLASS_]

#define EUI_APPEARANCE_REMOVE(_CLASS_) \
    [_EUIDynamicAppearanceRegister removeInvocations:_CLASS_]

#define EUI_APPEARANCE_IS_REGISTERED(_CLASS_) \
    [_EUIDynamicAppearanceRegister isRegistered:_CLASS_]

#define EUILock() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER);
#define EUIUnlock() dispatch_semaphore_signal(self->_lock);

#pragma mark - ---| EUIDynamicAppearance |---

@interface _EUIDynamicAppearanceRegister : NSObject
@property (nonatomic, strong) NSMutableDictionary *setters;
@property (nonatomic, strong) NSMutableDictionary *settersByIDs;
@end
@implementation _EUIDynamicAppearanceRegister {
    dispatch_semaphore_t _lock;
}

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
        _lock = dispatch_semaphore_create(1);
        _setters = @{}.mutableCopy;
    }
    return self;
}

+ (void)bindClass:(Class)class invocation:(NSInvocation *)invocation {
    [[self sharedInstance] p_bindClass:class invocation:invocation];
}

- (void)p_bindClass:(Class)class invocation:(NSInvocation *)invocation {
    /*! 基础结构为：
       @{ cls : @{ @"sel" : invocation,
                  },
        }
     */
    EUILock()
    NSString *sel = NSStringFromSelector(invocation.selector);
    NSString *cls = NSStringFromClass(class);
    NSMutableDictionary *setterInfo = self.setters[cls];
    if (setterInfo == nil) {
        setterInfo = @{}.mutableCopy;
        self.setters[cls] = setterInfo;
    }
    [setterInfo setObject:invocation forKey:sel];
    EUIUnlock()
}

+ (NSArray <NSInvocation *> *)invocations:(Class)cls {
    return [[self sharedInstance] p_invocations:cls];
}

- (NSArray <NSInvocation *> *)p_invocations:(Class)cls {
    NSArray <NSInvocation *> *one = nil;
    NSString *key = NSStringFromClass(cls);
    EUILock()
    NSMutableDictionary *setterInfo = self.setters[key];
    if (!!setterInfo) {
        one = [setterInfo allValues];
    }
    EUIUnlock()
    return one;
}

+ (void)removeInvocations:(Class)cls {
    [[self sharedInstance] p_removeInvocations:cls];
}

- (void)p_removeInvocations:(Class)cls {
    NSString *key = NSStringFromClass(cls);
    EUILock()
    [self.setters removeObjectForKey:key];
    EUIUnlock()
}

+ (BOOL)isRegistered:(Class)cls {
    return [[self sharedInstance] isRegistered:cls];
}

- (BOOL)isRegistered:(Class)cls {
    NSString *key = NSStringFromClass(cls);
    EUILock()
    BOOL one = !!self.setters[key];
    EUIUnlock()
    return one;
}

@end

#pragma mark - ---| _EUIDynamicAppearanceInfo |---

@interface _EUIDynamicAppearanceInfo : NSObject
@property (nonatomic, weak) NSObject *object;
@property (nonatomic, assign) Class appearanceClass;
@end
@implementation _EUIDynamicAppearanceInfo
@end

#pragma mark - ---| NSObject(EUIDynamicAppearance) |---

static const void *kEUIAppearanceKey = &kEUIAppearanceKey;
static const void *kEUIAppearanceInfoKey = &kEUIAppearanceInfoKey;
static const void *kEUIAppearanceIdentifierKey = &kEUIAppearanceIdentifierKey;
NSString *const kEUIAppearanceDynamicGlobalKey = @"kEUIAppearanceDynamicGlobalKey";

@implementation NSObject(EUIAppearance)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [EUIHelper hookClass:NSClassFromString(@"_UIAppearance")
                fromSelector:@selector(forwardInvocation:)
                  toSelector:@selector(eui_forwardInvocation:)];
    });
}

+ (instancetype)eui_appearance {
    Class cls = [self class];
    if (![cls isSubclassOfClass:UIView.class]) {
        NSAssert(NO, @"❌ 错误 ：eui_appearance 仅支持 UIView 及其子类！");
        return nil;
    }

    id /*_UIAppearance*/ appearance = [cls appearance];
    _EUIDynamicAppearanceInfo *one = [appearance eui_dynamicAppearanceInfo];
    if ([appearance eui_dynamicAppearanceInfo] == nil) {
        [appearance set_euiDynamicAppearanceInfo:({
            one = [_EUIDynamicAppearanceInfo new]; one;
        })];
    }
    one.object = one;
    one.appearanceClass = cls;
    return appearance;
}

- (BOOL)eui_forwardInvocation:(NSInvocation *)anInvocation {
    if (self.isDynamicAppearance) {
        _EUIDynamicAppearanceInfo *dynamic = [self eui_dynamicAppearanceInfo];
        if (!!dynamic) EUI_APPEARANCE_REGISTER(dynamic.appearanceClass, anInvocation);
    }
    return [self eui_forwardInvocation:anInvocation];
}

- (NSArray <NSInvocation *> *)eui_registeredSetters {
    if (!self.isDynamicAppearance) return nil;
    Class cls = self.class;
    _EUIDynamicAppearanceInfo *dynamic = [self eui_dynamicAppearanceInfo];
    if (!!dynamic) {
        NSAssert(NO, @"⚠️ 警告，应该避免使用 appearance 的实例调用此接口，因为通常情况下这个逻辑是无效的");
        cls = dynamic.appearanceClass;
    }
    return EUI_APPEARANCE_SETTERS(cls);
}

- (void)eui_invokeSelectors {
    NSAssert([NSThread isMainThread], @"❌ 错误：需要在主线程调用!");
    if (![self isKindOfClass:UIView.class]) return;
    if (![self isDynamicAppearance]) return;
    _EUIDynamicAppearanceInfo *dynamic = [self eui_dynamicAppearanceInfo];
    if (!!dynamic) {
        NSCAssert(NO, @"❌ 错误：eui_invokeSelectors 方法应该由 UIView 及其子类实例调用，当前类是%@",
                  NSStringFromClass(self.class));
        return;
    }
    if (!EUI_APPEARANCE_IS_REGISTERED(self.class)) return;
    NSArray <NSInvocation *> *setters = [self eui_registeredSetters];
    if ( setters ) {
        [setters enumerateObjectsUsingBlock:^(NSInvocation *obj, NSUInteger idx, BOOL *stop) {
            [obj invokeWithTarget:self];///< 原 target 是 _UIAppearance 实例，重绑定为自己
        }];
    }
}

#pragma mark - ---| SETTER & GETTER |---

- (void)set_euiDynamicAppearanceInfo:(_EUIDynamicAppearanceInfo *)one {
    objc_setAssociatedObject(self, kEUIAppearanceInfoKey, one, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (_EUIDynamicAppearanceInfo *)eui_dynamicAppearanceInfo {
    return objc_getAssociatedObject(self, kEUIAppearanceInfoKey);
}

- (void)setDynamicAppearance:(BOOL)one {
    objc_setAssociatedObject(self, kEUIAppearanceKey, @(one), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isDynamicAppearance {
    NSNumber *one = objc_getAssociatedObject(self, kEUIAppearanceKey);
    return one ? one.boolValue : [self.class isDynamicAppearance];
}

- (void)setAppearanceIdentifier:(NSString *)one {
    objc_setAssociatedObject(self, kEUIAppearanceIdentifierKey, one, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)appearanceIdentifier {
    return objc_getAssociatedObject(self, kEUIAppearanceIdentifierKey);
}

+ (void)setDynamicAppearance:(BOOL)dynamicAppearance {
    [[NSUserDefaults standardUserDefaults] setObject:@(dynamicAppearance) forKey:kEUIAppearanceDynamicGlobalKey];
}

+ (BOOL)isDynamicAppearance {
    NSNumber *one = [[NSUserDefaults standardUserDefaults] objectForKey:kEUIAppearanceDynamicGlobalKey];
    if (one) {
        return one.boolValue;
    }
    return YES;
}

@end
