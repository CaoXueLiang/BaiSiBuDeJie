//
//  CXLPlusButtonAddButton.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/27.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CXLPlusButtonAddButton.h"
@interface CXLPlusButtonAddButton ()<UIActionSheetDelegate> {
    CGFloat _buttonImageHeight;
}
@end

@implementation CXLPlusButtonAddButton
#pragma mark - Life Cycle
+ (void)load {
    //请在 `-[AppDelegate application:didFinishLaunchingWithOptions:]` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

#pragma mark - CYLPlusButtonSubclassing Methods
/*
 * 创建不带文字的按钮
 */
+ (id)plusButton{
    UIImage *buttonImage = [UIImage imageNamed:@"tabBar_publish_icon_38x38_"];
    UIImage *highlightImage = [UIImage imageNamed:@"tabBar_publish_iconN_38x38_"];

    CXLPlusButtonAddButton* button = [CXLPlusButtonAddButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, kScreenWidth/5.0, 49);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - Event Response
- (void)clickPublish {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    NSLog(@"点击了中间的按钮");
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight{
    return 0.5;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight{
    return kDevice_Is_iPhoneX ? (49/2.0 - 0.5*83) : 0;
}

@end

