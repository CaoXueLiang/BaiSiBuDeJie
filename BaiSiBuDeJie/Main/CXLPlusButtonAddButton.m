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

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 控件大小,间距大小
    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
    NSLog(@"%@",NSStringFromCGRect(self.bounds));
    CGFloat const imageViewEdgeWidth   = self.bounds.size.width;
    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth;
    
    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;
    
    // imageView 和 titleLabel 中心的 Y 值
    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark - CYLPlusButtonSubclassing Methods
/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
+ (id)plusButton{
    UIImage *buttonImage = [UIImage imageNamed:@"tabBar_publish_icon_38x38_"];
    UIImage *highlightImage = [UIImage imageNamed:@"tabBar_publish_click_icon_38x38_"];

    CXLPlusButtonAddButton* button = [CXLPlusButtonAddButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor blueColor];
    return button;
}

//+ (id)plusButton {
//    CYLPlusButtonSubclass *button = [[CYLPlusButtonSubclass alloc] init];
//    UIImage *buttonImage = [UIImage imageNamed:@"tabBar_publish_icon_38x38_"];
//    UIImage *highlightImage = [UIImage imageNamed:@"tabBar_publish_click_icon_38x38_"];
//
//    [button setImage:buttonImage forState:UIControlStateNormal];
//    [button setTitle:@"发布" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//
//    [button setTitle:@"发布" forState:UIControlStateSelected];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//
//    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
//    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
//    //    button.frame = CGRectMake(0.0, 0.0, 250, 100);
//    //    button.backgroundColor = [UIColor redColor];
//
//    // if you use `+plusChildViewController` , do not addTarget to plusButton.
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}

#pragma mark - Event Response
- (void)clickPublish {
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
    [actionSheet showInView:viewController.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %@", @(buttonIndex));
}

#pragma mark - CYLPlusButtonSubclassing
//+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
//    return  0.5;
//}
//
//+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
//    return  0.0;
//}

@end
