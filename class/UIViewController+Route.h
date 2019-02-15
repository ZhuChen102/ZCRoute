//
//  UIViewController+Route.h
//  BanBanApp
//
//  Created by Zhu on 2018/4/16.
//  Copyright © 2018年 Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChildControllerModel;
typedef void (^RouteCallbackBlock)(NSDictionary *infoDict);
@interface UIViewController (Route)
//反向传值用
@property (nonatomic, copy) RouteCallbackBlock returnBlock;
//正向传值用
@property (nonatomic, strong) NSDictionary *parameters;

@end
