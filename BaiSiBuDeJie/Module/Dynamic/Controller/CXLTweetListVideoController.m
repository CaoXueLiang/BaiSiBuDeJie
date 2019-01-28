//
//  CXLTweetListVideoController.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/4.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLTweetListVideoController.h"
#import "PostsModel.h"
#import "PostsVideoCollectionViewCell.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

@interface CXLTweetListVideoController()
<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,assign) int currentPage; //当前页数
@end

@implementation CXLTweetListVideoController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.currentPage = 0;
    [self setRefresh];
    [self.view addSubview:self.myCollection];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.myCollection.frame = self.view.bounds;
}

- (void)setRefresh{
    self.myCollection.mj_header = [CXLCustomHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshData)];
    self.myCollection.mj_footer = [CXLCustomFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.myCollection.mj_header beginRefreshing];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PostsVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostsVideoCollectionViewCell" forIndexPath:indexPath];
    PostsModel *model = self.dataArray[indexPath.item];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PostsVideoCollectionViewCell *cell = (PostsVideoCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    PostsModel *model = self.dataArray[indexPath.item];
    if ([self.delegate respondsToSelector:@selector(didClickedVideoCell: postsModel:)]) {
        [self.delegate didClickedVideoCell:cell postsModel:model];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //SLog(@"开始拖拽");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    //SLog(@"开始减速--%@",NSStringFromCGPoint(velocity));
    if ([self.delegate respondsToSelector:@selector(collectionViewWillEndDraggingWithVelocity:)]) {
        [self.delegate collectionViewWillEndDraggingWithVelocity:velocity];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //SLog(@"停止");
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    PostsModel *model = self.dataArray[indexPath.item];
    return [PostsVideoCollectionViewCell cellSizeWithModel:model layout:collectionViewLayout];
}

#pragma mark - NetRequest
- (void)freshData{
    self.dataArray = nil;
    self.currentPage = 0;
    [self sendRequest];
}

- (void)loadMoreData{
    self.currentPage += 1;
    [self sendRequest];
}

- (void)sendRequest{
    NSString *urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/list/jingxuan/41/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
    [MLNetWorkHelper GET:urlString parameters:@{} responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        [self.myCollection.mj_header endRefreshing];
        [self.myCollection.mj_footer endRefreshing];
        SLog(@"%@",[responseObject yy_modelToJSONString]);
        NSArray *array = responseObject[@"list"];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PostsModel *model = [PostsModel yy_modelWithJSON:obj];
            [self.dataArray addObject:model];
        }];
        [self.myCollection reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

#pragma mark - Setter && Getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UICollectionView *)myCollection{
    if (!_myCollection) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.headerHeight = 10;
        layout.footerHeight = 10;
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        //_myCollection.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
        _myCollection.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewBG);
        [_myCollection registerClass:[PostsVideoCollectionViewCell class] forCellWithReuseIdentifier:@"PostsVideoCollectionViewCell"];
        _myCollection.delegate = self;
        _myCollection.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _myCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _myCollection;
}

@end
