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

#define EUI_APPEARANCE_REGISTER(_CLASS_, _INVOCATION_, _ID_) \
    [_EUIDynamicAppearanceRegister bindClass:_CLASS_ invocation:_INVOCATION_ identifier:_ID_]

#define EUI_APPEARANCE_SETTERS(_CLASS_, _ID_) \
    [_EUIDynamicAppearanceRegister invocations:_CLASS_ identifier:_ID_]

#define EUI_APPEARANCE_REMOVE(_CLASS_, _ID_) \
    [_EUIDynamicAppearanceRegister removeInvocations:_CLASS_ identifier:_ID_]

#define EUI_APPEARANCE_IS_REGISTERED(_CLASS_, _ID_) \
    [_EUIDynamicAppearanceRegister isRegistered:_CLASS_ identifier:_ID_]

#pragma mark - ---| EUIDynamicAppearance |---

@interface _EUIDynamicAppearanceRegister : NSObject
@property (atomic, strong) NSMutableDictionary *classInfos;
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
        _classInfos = @{}.mutableCopy;
    }
    return self;
}

+ (void)bindClass:(Class)class invocation:(NSInvocation *)invocation identifier:(NSString *)identifier {
    [[self sharedInstance] p_bindClass:class invocation:invocation identifier:identifier];
}

- (void)p_bindClass:(Class)class invocation:(NSInvocation *)invocation identifier:(NSString *)identifer {
    /*! 基本大部分关系用 cls + x(identifer) 两层维度可以做好绑定，基础结构为：
        {
        cls : @{ "x" : @{ @"sel" : invacation, @"sel" : invacation},
                 "x" : @{ @"sel" : invacation },
               }
        }
     */
    NSString *sel = NSStringFromSelector(invocation.selector);
    NSString *cls = NSStringFromClass(class);
    NSMutableDictionary *clsInfo = self.classInfos[cls];
    if (clsInfo == nil) {
        clsInfo = @{}.mutableCopy;
        self.classInfos[cls] = clsInfo;
    }
    NSMutableDictionary *invocations = clsInfo[identifer];
    if (invocations == nil) {
        invocations = @{}.mutableCopy;
        clsInfo[identifer] = invocations;
    }
    [invocations setObject:invocation forKey:sel];
}

+ (NSArray <NSInvocation *> *)invocations:(Class)cls identifier:(NSString *)identifier {
    return [[self sharedInstance] p_invocations:cls identifier:identifier];
}

- (NSArray <NSInvocation *> *)p_invocations:(Class)cls identifier:(NSString *)identifier {
    NSArray <NSInvocation *> *one = nil;
    NSString *key = NSStringFromClass(cls);
    NSMutableDictionary *clsInfo = self.classInfos[key];
    if (!!clsInfo) one =[clsInfo[identifier] allValues];
    return one;
}

+ (void)removeInvocations:(Class)cls identifier:(NSString *)identifier {
    [[self sharedInstance] p_removeInvocations:cls identifier:identifier];
}

- (void)p_removeInvocations:(Class)cls identifier:(NSString *)identifier {
    NSString *key = NSStringFromClass(cls);
    NSMutableDictionary *one = self.classInfos[key];
    if (one.allKeys.count == 1) {
        [self.classInfos removeObjectForKey:key];
    } else {
        [one removeObjectForKey:identifier];
    }
}

+ (BOOL)isRegistered:(Class)cls identifier:(NSString *)identifier {
    return [[self sharedInstance] isRegistered:cls identifier:identifier];
}

- (BOOL)isRegistered:(Class)cls identifier:(NSString *)identifier {
    NSString *key = NSStringFromClass(cls);
    NSMutableDictionary *clsInfo = self.classInfos[key];
    BOOL isRegister = !clsInfo ? NO : !!clsInfo[identifier];
    return isRegister;
}

@end

#pragma mark - ---| _EUIDynamicAppearanceInfo |---

@interface _EUIDynamicAppearanceInfo : NSObject
@property (nonatomic, weak) NSObject *object;
@property (nonatomic, assign) Class appearanceClass;
@property (nonatomic, copy) NSArray <NSString *> *identifiers;
@end
@implementation _EUIDynamicAppearanceInfo
@end

#pragma mark - ---| NSObject(EUIDynamicAppearance) |---

static const void *kEUIAppearanceKey = &kEUIAppearanceKey;
static const void *kEUIAppearanceInfoKey = &kEUIAppearanceInfoKey;
static const void *kEUIAppearanceIdentifierKey = &kEUIAppearanceIdentifierKey;
NSString *const kEUIAppearanceDynamicGlobalKey = @"kEUIAppearanceDynamicGlobalKey";
NSString *const kEUIAppearanceDefaultID = @"default_appearance_id";

@implementation NSObject(EUIAppearance)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [EUIHelper hookClass:NSClassFromString(@"_UIAppearance")
                fromSelector:@selector(forwardInvocation:)
                  toSelector:@selector(eui_appearanceforwardInvocation:)];
        [EUIHelper hookClass:UIView.class
                fromSelector:@selector(didMoveToWindow)
                  toSelector:@selector(eui_appearanceDidMoveToWindow)];
    });
}

+ (instancetype)eui_appearance {
    return [self eui_appearanceByIDs:@[kEUIAppearanceDefaultID]];
}

+ (instancetype)eui_appearanceByIDs:(NSArray <NSString *> *)ids {
    Class cls = [self class];
    if (![cls isSubclassOfClass:UIView.class]) {
        NSAssert(NO, @"❌ 错误 ：eui_appearance 仅支持 UIView 及其子类！");
        return nil;
    }

    id appearance = [cls appearance];
    
    _EUIDynamicAppearanceInfo *one = [appearance eui_dynamicAppearanceInfo];
    if (!one) {
        [appearance set_euiDynamicAppearanceInfo:({
            one = [_EUIDynamicAppearanceInfo new]; one;
        })];
    }
    one.object = one;
    one.appearanceClass = cls;
    one.identifiers = ids;
    return appearance;
}

- (void)eui_appearanceDidMoveToWindow {
    [self eui_appearanceDidMoveToWindow];
    NSLog(@"eui_appearanceDidMoveToWindow%@",self);
    [self eui_makeDynamicAppearance];
}

- (void)eui_appearanceforwardInvocation:(NSInvocation *)anInvocation {
    NSAssert([NSThread isMainThread], @"❌ 错误：需要在主线程调用!");
    if (self.eui_isDynamicAppearance) {
        /*!
         ⚠️ 系统的 _UIAppearance 每次 forwardInvocation 时，会往 _appearanceInvocations 数组中持续添加 anInvocation。
         需要关注接口的调用风险；
        */
        _EUIDynamicAppearanceInfo *dynamic = [self eui_dynamicAppearanceInfo];
        if (!!dynamic) {
            for (NSString *identifier in dynamic.identifiers) {
                EUI_APPEARANCE_REGISTER(dynamic.appearanceClass,
                                        anInvocation,
                                        identifier);
            }
        }
    }
    [self eui_appearanceforwardInvocation:anInvocation];
}

- (NSArray <NSInvocation *> *)eui_registeredSetters {
    if (!self.eui_isDynamicAppearance) return nil;
    Class cls = self.class;
    _EUIDynamicAppearanceInfo *dynamic = [self eui_dynamicAppearanceInfo];
    if (!!dynamic) {
        NSLog(@"⚠️ 警告，应该避免使用 appearance 的实例调用此接口，因为通常情况下这个逻辑是无效的");
        cls = dynamic.appearanceClass;
    }
    return EUI_APPEARANCE_SETTERS(cls, self.eui_appearanceIdentifier);
}

- (void)eui_makeDynamicAppearance {
    NSAssert([NSThread isMainThread], @"❌ 错误：需要在主线程调用!");
    if (![self isKindOfClass:UIView.class]) return;
    if (![self eui_isDynamicAppearance]) return;
    
    _EUIDynamicAppearanceInfo *dynamic = [self eui_dynamicAppearanceInfo];
    if (!!dynamic) {
        ///< dynamic 对象应该只存在于「_UIAppearance」 实例中
        NSCAssert(NO, @"❌ 错误：当前类 [%@] 不应该持有 _EUIDynamicAppearanceInfo 对象，请检查！",
                  NSStringFromClass(self.class));
        return;
    }
    
    BOOL isRegisted = EUI_APPEARANCE_IS_REGISTERED(self.class, self.eui_appearanceIdentifier);
    if (!isRegisted) return;

    NSArray <NSInvocation *> *setters = [self eui_registeredSetters];
    if ( setters ) {
        [setters enumerateObjectsUsingBlock:^(NSInvocation *obj, NSUInteger idx, BOOL *stop) {
            BOOL isResponds = [self respondsToSelector:obj.selector];
            if ( isResponds ) {
                ///< 原 target 是 _UIAppearance 实例，重绑定为自己
                [obj setTarget:self];
                [obj invoke];
            } else {
                NSLog(@"⚠️ 警告，target：%@ 无法响应 setter ：%@ 的调用，请检查逻辑！", self, obj);
            }
        }];
    }
}

#pragma mark - ---| Associated SETTER & GETTER |---

- (void)set_euiDynamicAppearanceInfo:(_EUIDynamicAppearanceInfo *)one {
    objc_setAssociatedObject(self, kEUIAppearanceInfoKey, one, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (_EUIDynamicAppearanceInfo *)eui_dynamicAppearanceInfo {
    return objc_getAssociatedObject(self, kEUIAppearanceInfoKey);
}

- (NSString *)eui_appearanceIdentifier {
    NSString *identifier = objc_getAssociatedObject(self, kEUIAppearanceIdentifierKey);
    return identifier ?: kEUIAppearanceDefaultID;
}

- (void)eui_setAppearanceIdentifier:(NSString *)one {
    BOOL isIgnoreInternalClass = [self isKindOfClass:_EUIDynamicAppearanceInfo.class];
    if (![self isKindOfClass:UIView.class] && !isIgnoreInternalClass) {
        NSCAssert(NO, @"❌ 错误：eui_setAppearanceIdentifier 方法应该由 UIView 及其子类实例调用，当前类是%@",
        NSStringFromClass(self.class));
    }
    if (!one || one.length == 0) one = kEUIAppearanceDefaultID;
    objc_setAssociatedObject(self, kEUIAppearanceIdentifierKey, one, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)eui_setDynamicAppearance:(BOOL)one {
    objc_setAssociatedObject(self, kEUIAppearanceKey, @(one), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)eui_isDynamicAppearance {
    NSNumber *one = objc_getAssociatedObject(self, kEUIAppearanceKey);
    return one ? one.boolValue : [self.class eui_isDynamicAppearance];
}

+ (void)eui_setDynamicAppearance:(BOOL)dynamicAppearance {
    [[NSUserDefaults standardUserDefaults] setObject:@(dynamicAppearance) forKey:kEUIAppearanceDynamicGlobalKey];
}

+ (BOOL)eui_isDynamicAppearance {
    NSNumber *one = [[NSUserDefaults standardUserDefaults] objectForKey:kEUIAppearanceDynamicGlobalKey];
    if (one) return one.boolValue;
    return YES;
}

@end
