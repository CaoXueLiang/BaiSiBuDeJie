//
//  CXLEssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/27.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CXLEssenceViewController.h"
#import "TYTabPagerBar.h"
#import "TYPagerController.h"
#import "CXLTweetListViewController.h"
#import "CXLTweetListVideoController.h"
#import "PostsDetailController.h"
#import "PostsHomeNavigation.h"

/*TarBar高度*/
static const CGFloat KTarBarHeight = 50;
@interface CXLEssenceViewController()
<TYTabPagerBarDataSource,TYTabPagerBarDelegate,
TYPagerControllerDataSource,TYPagerControllerDelegate,
CXLTweetListVideoControllerDelegate,CXLTweetListViewControllerDelegate>

@property (nonatomic,weak) TYTabPagerBar *tabBar;
@property (nonatomic,weak) TYPagerController *pagerController;
@property (nonatomic,strong) NSArray *itermArray;
@property (nonatomic,strong) PostsHomeNavigation *homeNavigation;
@end

@implementation CXLEssenceViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.homeNavigation];
    [self addTabPageBar];
    [self addPagerController];
    [self reloadData];
    self.fd_prefersNavigationBarHidden = YES;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)addTabPageBar {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
    tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    tabBar.dataSource = self;
    tabBar.delegate = self;
    tabBar.backgroundColor = MainColor;
    tabBar.layout.normalTextColor = [UIColor whiteColor];
    tabBar.layout.selectedTextColor = [UIColor whiteColor];
    tabBar.layout.progressColor = [UIColor whiteColor];
    tabBar.layout.normalTextFont = [UIFont systemFontOfSize:16];
    tabBar.layout.selectedTextFont = [UIFont systemFontOfSize:19];
    [tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    [self.view addSubview:tabBar];
    _tabBar = tabBar;
}

- (void)addPagerController {
    TYPagerController *pagerController = [[TYPagerController alloc]init];
    pagerController.layout.prefetchItemCount = 1;
    //pagerController.layout.autoMemoryCache = NO;
    // 只有当scroll滚动动画停止时才加载pagerview，用于优化滚动时性能
    pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
    pagerController.dataSource = self;
    pagerController.delegate = self;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tabBar.frame = CGRectMake(0, KTopHeight, CGRectGetWidth(self.view.frame), KTarBarHeight);
    _pagerController.view.frame = CGRectMake(0, KTarBarHeight + KTopHeight, CGRectGetWidth(self.view.frame), kScreenHeight - KTopHeight - KTarBarHeight - KTarbarHeight);
}

- (NSArray *)itermArray{
    if (!_itermArray) {
        _itermArray = @[@"推荐",@"视频",@"图片",@"段子",@"排行",@"社会",@"影视分享",@"游戏",@"8090",@"互动区",];
    }
    return _itermArray;
}

#pragma mark - ListDelegate
- (void)didClickedCell:(PostsCell *)cell postsModel:(PostsModel *)model{
    PostsDetailController *controller = [PostsDetailController initWithPostsModel:model];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)scrollViewWillEndDraggingWithVelocity:(CGPoint)velocity{
    [self.homeNavigation scrollAnimationWithVelocity:velocity];
    
    /*隐藏导航栏*/
    if (velocity.y > 1.0) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _tabBar.top = KTopHeight - kNavBarHeight;
            _pagerController.view.frame = CGRectMake(0, KTarBarHeight + KTopHeight - kNavBarHeight, CGRectGetWidth(self.view.frame), kScreenHeight - KTopHeight - KTarBarHeight - KTarbarHeight + kNavBarHeight);
        } completion:nil];
    }
    
    /*显示导航栏*/
    if (velocity.y < -1.0) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _tabBar.top = KTopHeight;
            _pagerController.view.frame = CGRectMake(0, KTarBarHeight + KTopHeight, CGRectGetWidth(self.view.frame), kScreenHeight - KTopHeight - KTarBarHeight - KTarbarHeight);
        } completion:nil];
    }
}

- (void)didClickedVideoCell:(PostsVideoCollectionViewCell *)cell postsModel:(PostsModel *)model{
    PostsDetailController *controller = [PostsDetailController initWithPostsModel:model];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)collectionViewWillEndDraggingWithVelocity:(CGPoint)velocity{
    [self.homeNavigation scrollAnimationWithVelocity:velocity];
    
    /*隐藏导航栏*/
    if (velocity.y > 1.0) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _tabBar.top = KTopHeight - kNavBarHeight;
            _pagerController.view.frame = CGRectMake(0, KTarBarHeight + KTopHeight - kNavBarHeight, CGRectGetWidth(self.view.frame), kScreenHeight - KTopHeight - KTarBarHeight - KTarbarHeight + kNavBarHeight);
        } completion:nil];
    }
    
    /*显示导航栏*/
    if (velocity.y < -1.0) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            _tabBar.top = KTopHeight;
            _pagerController.view.frame = CGRectMake(0, KTarBarHeight + KTopHeight, CGRectGetWidth(self.view.frame), kScreenHeight - KTopHeight - KTarBarHeight - KTarbarHeight);
        } completion:nil];
    }
}

#pragma mark - TYTabPagerBarDataSource
- (NSInteger)numberOfItemsInPagerTabBar {
    return self.itermArray.count;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = self.itermArray[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate
- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSString *title = self.itermArray[index];
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pagerController scrollToControllerAtIndex:index animate:YES];
}

#pragma mark - TYPagerControllerDataSource
- (NSInteger)numberOfControllersInPagerController {
    return 20;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index == 1) {
        CXLTweetListVideoController *controller = [[CXLTweetListVideoController alloc]init];
        controller.delegate = self;
        return controller;
    }else{
        CXLTweetListViewController *controller = [CXLTweetListViewController initWithType:index];\
        controller.delegate = self;
        return controller;
    }
}

#pragma mark - TYPagerControllerDelegate
- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

- (void)reloadData {
    [_tabBar reloadData];
    [_pagerController reloadData];
}

#pragma mark - Setter && Getter
- (PostsHomeNavigation *)homeNavigation{
    if (!_homeNavigation) {
        _homeNavigation = [PostsHomeNavigation new];
    }
    return _homeNavigation;
}

@end
