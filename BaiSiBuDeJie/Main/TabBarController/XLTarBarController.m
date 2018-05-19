//
//  XLTarBarController.m
//  NormalProject
//
//  Created by 曹学亮 on 2018/5/14.
//  Copyright © 2018年 Cao Xueliang. All rights reserved.
//

#import "XLTarBarController.h"
#import "XLTarBar.h"
#import "CXLEssenceViewController.h"
#import "CXLNewestViewController.h"
#import "CXLAttentionViewController.h"
#import "CXLMineViewController.h"
#import "CXLBaseNavigationController.h"

@interface XLTarBarController ()

@end

@implementation XLTarBarController
#pragma mark - Init Menthod
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTabBar];
    [self setUpViewControllers];
    [self customTarBar];
    [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
}

/**
 *  利用 KVC 把系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar {
    XLTarBar *tabBar = [[XLTarBar alloc] init];
    tabBar.dk_barTintColorPicker = DKColorPickerWithKey(TabBarColor);
    [self setValue:tabBar forKey:@"tabBar"];
}


- (void)setUpViewControllers{
    //精华
    CXLEssenceViewController *firstViewController = [[CXLEssenceViewController alloc] init];
    UIViewController *firstNavigationController = [[CXLBaseNavigationController alloc]initWithRootViewController:firstViewController];
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTitle:@"精华" image:[[UIImage imageNamed:@"tabBar_essence_icon_27x27_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar_essence_click_icon_27x27_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    firstNavigationController.tabBarItem = firstItem;
    firstViewController.title = @"精华";
    
    //最新
    CXLNewestViewController *secondViewController = [[CXLNewestViewController alloc] init];
    UIViewController *secondNavigationController = [[CXLBaseNavigationController alloc]initWithRootViewController:secondViewController];
    UITabBarItem *secondItem = [[UITabBarItem alloc] initWithTitle:@"最新" image:[[UIImage imageNamed:@"tabBar_new_icon_27x27_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar_new_click_icon_27x27_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    secondNavigationController.tabBarItem = secondItem;
    secondViewController.title = @"最新";
    
    //关注
    CXLAttentionViewController *thirdViewController = [[CXLAttentionViewController alloc] init];
    UIViewController *thirdNavigationController = [[CXLBaseNavigationController alloc]initWithRootViewController:thirdViewController];
    UITabBarItem *thirditem = [[UITabBarItem alloc] initWithTitle:@"社区" image:[[UIImage imageNamed:@"tabBar_friendTrends_icon_27x27_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar_friendTrends_click_icon_27x27_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    thirdNavigationController.tabBarItem = thirditem;
    thirdViewController.title = @"社区";
    
    //我的
    CXLMineViewController *fourthViewController = [[CXLMineViewController alloc] init];
    UIViewController *fourthNavigationController = [[CXLBaseNavigationController alloc]initWithRootViewController:fourthViewController];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"tabBar_me_icon_27x27_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar_me_click_icon_27x27_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    fourthNavigationController.tabBarItem = item;
    fourthViewController.title = @"我的";
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController
                                 ];
    self.viewControllers = viewControllers;
}

- (void)customTarBar{
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = MainGrayTextColor;
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = MainColor;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor clearColor]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    //[[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0,-2)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, kScreenWidth, CGFloatFromPixel(0.5));
    layer.backgroundColor = RGBLINE.CGColor;
    [self.tabBar.layer addSublayer:layer];
}

#pragma mark - NSNotificationCenter
- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        [self tabBarItemWidthDidUpdate];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceOrientationDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)tabBarItemWidthDidUpdate {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
        NSLog(@"Landscape Left or Right !");
    } else if (orientation == UIDeviceOrientationPortrait){
        NSLog(@"Landscape portrait!");
    }
}


@end
