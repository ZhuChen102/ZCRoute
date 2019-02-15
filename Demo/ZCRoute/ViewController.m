//
//  ViewController.m
//  ZCRoute
//
//  Created by 祝晨 on 15/02/19.
//  Copyright © 2019年 祝晨. All rights reserved.
//

#import "ViewController.h"
#import "class/ZCRoute.h"
#import "class/BBManagerRoutes.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark - 点击事件
- (void)rightItemClick {
    [ZCRoute pushViewControllerWithString:Login_NextViewController];
}

@end
