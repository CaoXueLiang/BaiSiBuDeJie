//
//  AppDelegate.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/27.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "XLTarBarController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

#pragma mark - Application Menthod
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*设置主控制器*/
    XLTarBarController *controller = [[XLTarBarController alloc]init];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
    /*设置网络请求*/
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    /*提示框设置*/
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setForegroundColor:[UIColor colorWithRGB:0 alpha:0.5]];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    
    /*设置键盘*/
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager]setShouldResignOnTouchOutside:YES];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
