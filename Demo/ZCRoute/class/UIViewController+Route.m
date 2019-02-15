//
//  UIViewController+Route.m
//  BanBanApp
//
//  Created by Zhu on 2018/4/16.
//  Copyright © 2018年 Zhu. All rights reserved.
//

#import "UIViewController+Route.h"
#import <objc/runtime.h>

@implementation UIViewController (Route)

static RouteCallbackBlock onceBlock;
static NSDictionary *onceDict;
- (void)setReturnBlock:(RouteCallbackBlock)returnBlock {
    objc_setAssociatedObject(self, &onceBlock, returnBlock, OBJC_ASSOCIATION_COPY);
}
- (RouteCallbackBlock)returnBlock {
    return objc_getAssociatedObject(self, &onceBlock);
}
- (void)setParameters:(NSDictionary *)parameters {
    objc_setAssociatedObject(self, &onceDict, parameters, OBJC_ASSOCIATION_COPY);
}
- (NSDictionary *)parameters {
    return objc_getAssociatedObject(self, &onceDict);
}


@end



