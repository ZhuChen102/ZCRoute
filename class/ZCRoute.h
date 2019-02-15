//
//  ZCRoute.h
//  BanBanApp
//
//  Created by Zhu on 2018/4/10.
//  Copyright © 2018年 Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^BBRouteCallbackBlock)(NSDictionary *infoDict);

@interface ZCRoute : NSObject

@property (nonatomic, strong) NSDictionary *parameterDict;          //正向传值
@property (nonatomic, strong) NSMutableArray *blockArray;           //反向传值

@property (nonatomic, assign) NSInteger isHaveBlock;
@property (nonatomic, assign) NSInteger isHaveParameters;

#pragma mark - 单例
+ (instancetype)sharedInstance;
#pragma mark - 注册路由
+ (void)registerRoutes;
#pragma mark -- 注册路由方法
+ (void)registerRouteWithScheme:(NSString *)scheme;
#pragma mark -- 路由跳转 -- 不传值
+ (void)pushViewControllerWithString:(NSString *)controlerString;
#pragma mark -- 路由跳转 -- 正向传值1  反向传值0
+ (void)pushViewControllerWithString:(NSString *)controlerString andParameters:(NSDictionary *)parameters;
#pragma mark -- 路由跳转 -- 正向传值0  反向传值1
+ (void)pushViewControllerWithString:(NSString *)controlerString callbackBlcok:(BBRouteCallbackBlock)block;
#pragma mark -- 路由跳转 -- 正向传值1  反向传值1
+ (void)pushViewControllerWithString:(NSString *)controlerString andParameters:(NSDictionary *)parameters callbackBlcok:(BBRouteCallbackBlock)block;

#pragma mark - 获取控制器
#pragma mark -- 获取当前root控制器
+ (UIViewController *)currentViewController;
#pragma mark -- 获取最顶层的控制器
+ (UIViewController *)topViewController;
#pragma mark -- 获取路由控制器
+ (UIViewController *)getViewControllerWithString:(NSString *)controllerString;
@end

