//
//  CXLMemberCenterFootView.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/30.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLMemberCenterFootView.h"
#import "CXLMineCenterListView.h"
#import "TYPagerView.h"
#import "TYTabPagerBar.h"

static CGFloat const KtabBarHeight = 45;
@interface CXLMemberCenterFootView()<TYPagerViewDataSource, TYPagerViewDelegate,TYTabPagerBarDataSource,TYTabPagerBarDelegate>
@property (nonatomic,strong) NSArray *itermArray;
@property (nonatomic,strong) TYTabPagerBar *tabBar;
@property (nonatomic,strong) TYPagerView *pageView;
@property (nonatomic,strong) CXLMineCenterListView *postsView;
@property (nonatomic,strong) CXLMineCenterListView *shareView;
@property (nonatomic,strong) CXLMineCenterListView *commentView;
@end

@implementation CXLMemberCenterFootView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.tabBar];
    [self addSubview:self.pageView];
    self.tabBar.frame = CGRectMake(0, 0, kScreenWidth, KtabBarHeight);
    self.pageView.frame = CGRectMake(0, KtabBarHeight, kScreenWidth, CGRectGetHeight(self.bounds) - KtabBarHeight);
    
    [self.tabBar reloadData];
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
    return (kScreenWidth - 20)/3.0;
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pageView scrollToViewAtIndex:index animate:YES];
}

#pragma mark - TYPagerViewDataSource
- (NSInteger)numberOfViewsInPagerView {
    return 3;
}

- (UIView *)pagerView:(TYPagerView *)pagerView viewForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index == 0) {
        return self.postsView;
    }else if (index == 1){
        return self.shareView;
    }else{
        return self.commentView;
    }
}

#pragma mark - TYPagerViewDelegate
- (void)pagerView:(TYPagerView *)pagerView willAppearView:(UIView *)view forIndex:(NSInteger)index {
    //NSLog(@"+++++++++willAppearViewIndex:%ld",index);
}

- (void)pagerView:(TYPagerView *)pagerView willDisappearView:(UIView *)view forIndex:(NSInteger)index {
    //NSLog(@"---------willDisappearView:%ld",index);
}

- (void)pagerView:(TYPagerView *)pagerView transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    NSLog(@"fromIndex:%ld, toIndex:%ld",fromIndex,toIndex);
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

- (void)pagerView:(TYPagerView *)pagerView transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

#pragma mark - Setter && Getter
- (NSArray *)itermArray{
    if (!_itermArray) {
        _itermArray = @[@"帖子",@"分享",@"评论"];
    }
    return _itermArray;
}

- (TYPagerView *)pageView{
    if (!_pageView) {
        _pageView = [[TYPagerView alloc]init];
        _pageView.layout.autoMemoryCache = NO;
        _pageView.dataSource = self;
        _pageView.delegate = self;
        [_pageView.layout registerClass:[UIView class] forItemWithReuseIdentifier:@"cellId"];
    }
    return _pageView;
}

- (TYTabPagerBar *)tabBar{
    if (!_tabBar) {
        _tabBar = [[TYTabPagerBar alloc]init];
        _tabBar.layout.barStyle = TYPagerBarStyleProgressView;
        _tabBar.dataSource = self;
        _tabBar.delegate = self;
        _tabBar.backgroundColor = [UIColor whiteColor];
        _tabBar.layout.normalTextColor = [UIColor grayColor];
        _tabBar.layout.selectedTextColor = MainColor;
        _tabBar.layout.progressColor = MainColor;
        _tabBar.layout.progressWidth = 60;
        _tabBar.layout.normalTextFont = [UIFont systemFontOfSize:16];
        _tabBar.layout.selectedTextFont = [UIFont systemFontOfSize:19];
        [_tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    }
    return _tabBar;
}

- (CXLMineCenterListView *)postsView{
    if (!_postsView) {
        _postsView = [[CXLMineCenterListView alloc]initWithFrame:self.bounds type:MemberListTypePosts memberId:_member_id];
    }
    return _postsView;
}

- (CXLMineCenterListView *)shareView{
    if (!_shareView) {
        _shareView = [[CXLMineCenterListView alloc]initWithFrame:self.bounds type:MemberListTypeShare memberId:_member_id];
    }
    return _shareView;
}

- (CXLMineCenterListView *)commentView{
    if (!_commentView) {
       _commentView = [[CXLMineCenterListView alloc]initWithFrame:self.bounds type:MemberListTypeComment memberId:_member_id];
    }
    return _commentView;
}

@end
