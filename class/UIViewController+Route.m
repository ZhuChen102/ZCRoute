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

static NSString *onceBlock;
static char paramsKey;
- (void)setReturnBlock:(RouteCallbackBlock)returnBlock {
    onceBlock = NSStringFromClass(self.class);
    objc_setAssociatedObject(self, &onceBlock, returnBlock, OBJC_ASSOCIATION_COPY);
}
- (RouteCallbackBlock)returnBlock {
    onceBlock = NSStringFromClass(self.class);
    return objc_getAssociatedObject(self, &onceBlock);
}
- (void)setParameters:(NSDictionary *)parameters {
    objc_setAssociatedObject(self, &paramsKey, parameters, OBJC_ASSOCIATION_COPY);
}
- (NSDictionary *)parameters {
    return objc_getAssociatedObject(self, &paramsKey);
}


@end



