//
//  XLPageProtocol.h
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/25.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XLPageController;
#pragma mark - XLPageControllerDelegate
@protocol XLPageControllerDelegate <NSObject>
@optional
/*交互切换回调*/
- (void)pageViewController:(XLPageController *)pageController willTransitionFromVC:(UIViewController *)frmoVC toVC:(UIViewController *)toVc;

- (void)pageViewController:(XLPageController *)pageController didTransitionFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC;

/*非交互式切换*/
- (void)pageViewController:(XLPageController *)pageController willLeaveFromVC:(UIViewController *)frmoVC toVC:(UIViewController *)toVc;

- (void)pageViewController:(XLPageController *)pageController didLeaveFromVC:(UIViewController *)frmoVC toVC:(UIViewController *)toVc;

/**
 横向滚动回调
 @param ratio 比率
 @param draging 是否拖拽
 */
- (void)scrollViewContentOffSetWithRatio:(CGFloat)ratio draging:(BOOL)draging;

/**
 垂直滚动回调
 @param offSet 滚动距离
 @param index 当前索引
 */
- (void)scrollWithPageOffSet:(CGFloat)offSet index:(NSInteger)index;

/**
 初始化
 */
- (void)willChangeInit;

/**
 是否能够垂直滚动
 @return Bool
 */
- (BOOL)cannotScrollWithPageOffSet;
@end

#pragma mark - XLPageControllerDataSource
@protocol XLPageControllerDataSource <NSObject>
@required

/**
 返回当前索引下的控制器
 @param index 当前索引
 @return 控制器
 */
- (UIViewController *)controllerAtIndex:(NSInteger)index;

/**
 返回控制器的个数
 @return 控制器个数
 */
- (NSInteger)numberOfControllers;

/**
 默认情况下是整个屏幕，通常情况下Cover在最上面，
 Tabar在中间，page在下面的情况不用设这个frame
 @return pageView的frame
 */
- (CGRect)preferPageFrame;

@optional
/**
 用于设置Controller的scrollView的Inset
 @param index page索引
 @return 距离
 */
- (CGFloat)pageTopAtIndex:(NSInteger)index;

/**
 解决侧滑失效问题
 @return 屏幕边缘手势
 */
- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer;

/**
 交互切换的时候，是否预加载
 @return Bool
 */
- (BOOL)isPrepareLoad;

/**
 该索引下的page是否可以滚动
 @param index page索引
 @return Bool
 */
- (BOOL)isSubPageCanScrollForIndex:(NSInteger)index;
@end


#pragma mark - XLPageSubControllerDataSource
/*如ChildController实现了这个协议，表示Tab和Cover会跟随Page纵向滑动*/
@protocol XLPageSubControllerDataSource <NSObject>
@optional
/**
 如果需要cover跟着上下滑动
 子controller需要实现这个方法
 @return scrollView
 */
- (UIScrollView *)preferScrollView;
@end
