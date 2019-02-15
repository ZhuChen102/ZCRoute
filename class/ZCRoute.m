//
//  ZCRoute.m
//  BanBanApp
//
//  Created by Zhu on 2018/4/10.
//  Copyright © 2018年 Zhu. All rights reserved.
//

#import "ZCRoute.h"
#import <JLRoutes/JLRoutes.h>
#import "UIViewController+Route.h"

@implementation ZCRoute
+ (instancetype)sharedInstance {
    static ZCRoute *route;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        route = [[ZCRoute alloc]init];
    });
    return route;
}
#pragma mark - 注册路由
+ (void)registerRoutes {
    [self registerRouteWithScheme:@"zcroutedemo"];
}

#pragma mark -- 注册路由方法ID
+ (void)registerRouteWithScheme:(NSString *)scheme {
    //建议以此格式    APP唯一标识(用于其他APP打开)/:模块名/:控制器名称
    [[JLRoutes routesForScheme:scheme] addRoute:@"/:Modular/:Controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        //反射
        Class class = NSClassFromString(parameters[@"Controller"]);

        UIViewController *vc = [[class alloc]init];
        if ([ZCRoute sharedInstance].isHaveBlock) {
            vc.returnBlock = ^(NSDictionary *infoDict) {
                BBRouteCallbackBlock callBlock = [[ZCRoute sharedInstance].blockArray lastObject];
                if (callBlock) {
                    callBlock(infoDict);
                    [[ZCRoute sharedInstance].blockArray removeLastObject];
                }
            };
        }
        if ([ZCRoute sharedInstance].parameterDict) {
            vc.parameters = [ZCRoute sharedInstance].parameterDict;
        }
        [[ZCRoute topViewController].navigationController pushViewController:vc animated:YES];

        return YES;
    }];
}

#pragma mark -- 路由跳转 -- 正向传值0  反向传值0
+ (void)pushViewControllerWithString:(NSString *)controlerString {
    [ZCRoute sharedInstance].isHaveBlock = NO;
    [ZCRoute sharedInstance].parameterDict = nil;
    
    [ZCRoute openURLWithURLString:controlerString];
}
#pragma mark -- 路由跳转 -- 正向传值1  反向传值0
+ (void)pushViewControllerWithString:(NSString *)controlerString andParameters:(NSDictionary *)parameters {
    [ZCRoute sharedInstance].isHaveBlock = NO;
    [ZCRoute sharedInstance].parameterDict = parameters;
    
    [ZCRoute openURLWithURLString:controlerString];
}
#pragma mark -- 路由跳转 -- 正向传值0  反向传值1
+ (void)pushViewControllerWithString:(NSString *)controlerString callbackBlcok:(BBRouteCallbackBlock)block {
    [[ZCRoute sharedInstance].blockArray addObject:block];
    [ZCRoute sharedInstance].isHaveBlock = YES;
    [ZCRoute sharedInstance].parameterDict = nil;
    
    [ZCRoute openURLWithURLString:controlerString];
}
#pragma mark -- 路由跳转 -- 正向传值1  反向传值1
+ (void)pushViewControllerWithString:(NSString *)controlerString andParameters:(NSDictionary *)parameters callbackBlcok:(BBRouteCallbackBlock)block {

    [[ZCRoute sharedInstance].blockArray addObject:block];
    [ZCRoute sharedInstance].isHaveBlock = YES;
    [ZCRoute sharedInstance].parameterDict = parameters;
    
    [ZCRoute openURLWithURLString:controlerString];
}
+ (void)openURLWithURLString:(NSString *)controlerString {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:controlerString] options:@{} completionHandler:nil];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:controlerString]];
    }
}
#pragma mark - 获取控制器
#pragma mark -- 获取当前控制器
+ (UIViewController *)currentViewController {
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [UIApplication sharedApplication].keyWindow.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    return currVC;
}
#pragma mark -- 获取最顶层的控制器
+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
#pragma mark -- 获取路由控制器
+ (UIViewController *)getViewControllerWithString:(NSString *)controllerString {
    NSArray *array = [controllerString componentsSeparatedByString:@"/"];
    controllerString = [array lastObject];
    Class class = NSClassFromString(controllerString);
    UIViewController *vc = [[class alloc]init];
    return vc;
}

#pragma mark - 懒加载
- (NSMutableArray *)blockArray {
    if (!_blockArray) {
        _blockArray = [NSMutableArray array];
    }
    return _blockArray;
}
@end

