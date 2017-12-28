//
//  CXLTabBarControllerConfig.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/27.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CXLTabBarControllerConfig.h"
#import "CXLEssenceViewController.h"
#import "CXLNewestViewController.h"
#import "CXLAttentionViewController.h"
#import "CXLMineViewController.h"
#import "CXLBaseNavigationController.h"

@interface CXLTabBarControllerConfig ()<UITabBarControllerDelegate>
@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;
@end

@implementation CXLTabBarControllerConfig
#pragma mark - Load Menthod
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;
        UIOffset titlePositionAdjustment = UIOffsetZero;
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    //精华
    CXLEssenceViewController *firstViewController = [[CXLEssenceViewController alloc] init];
    UIViewController *firstNavigationController = [[CXLBaseNavigationController alloc]initWithRootViewController:firstViewController];
    
    //最新
    CXLNewestViewController *secondViewController = [[CXLNewestViewController alloc] init];
    UIViewController *secondNavigationController = [[CXLBaseNavigationController alloc]initWithRootViewController:secondViewController];
    
    //关注
    CXLAttentionViewController *thirdViewController = [[CXLAttentionViewController alloc] init];
    UIViewController *thirdNavigationController = [[CXLBaseNavigationController alloc]initWithRootViewController:thirdViewController];
    
    //我的
    CXLMineViewController *fourthViewController = [[CXLMineViewController alloc] init];
    UIViewController *fourthNavigationController = [[CXLBaseNavigationController alloc]initWithRootViewController:fourthViewController];
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"最新",
                                                 CYLTabBarItemImage : @"tabBar_essence_iconN_27x27_",
                                                 CYLTabBarItemSelectedImage : @"tabBar_essence_click_icon_27x27_",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"精华",
                                                  CYLTabBarItemImage : @"tabBar_new_iconN_26x23_",
                                                  CYLTabBarItemSelectedImage : @"tabBar_new_click_icon_27x27_",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"关注",
                                                 CYLTabBarItemImage : @"tabBar_friendTrends_iconN_27x27_",
                                                 CYLTabBarItemSelectedImage : @"tabBar_friendTrends_click_icon_27x27_",
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我",
                                                  CYLTabBarItemImage : @"tabBar_me_iconN_27x27_", CYLTabBarItemSelectedImage : @"tabBar_me_click_icon_27x27_"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 83 : 49;
    
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
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light_320x49_"]];
    [[UITabBar appearance] setBackgroundColor:[UIColor clearColor]];
    //[[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0,-2)];
  
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, kScreenWidth, CGFloatFromPixel(0.5));
    layer.backgroundColor = RGBLINE.CGColor;
    [tabBarController.tabBar.layer addSublayer:layer];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor redColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
