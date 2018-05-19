//
//  CXLBaseNavigationController.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/27.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CXLBaseNavigationController.h"

@interface CXLBaseNavigationController ()

@end

@implementation CXLBaseNavigationController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(NavigationBarColor);
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:17],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
    [self.navigationBar setTitleTextAttributes:textAttributes];
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
