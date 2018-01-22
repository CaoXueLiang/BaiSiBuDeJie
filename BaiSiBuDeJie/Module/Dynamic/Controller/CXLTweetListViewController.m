//
//  CXLTweetListViewController.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/28.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CXLTweetListViewController.h"
#import "PostsModel.h"
#import "PostsLayouts.h"
#import "PostsCell.h"

@interface CXLTweetListViewController()
<UITableViewDelegate,UITableViewDataSource,PostsCellDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,assign) int currentPage; //当前页数
@property (nonatomic,assign) PostsType type;  //帖子类型
@end

@implementation CXLTweetListViewController
#pragma mark - Init Menthod
+ (instancetype)initWithType:(PostsType)type{
    CXLTweetListViewController *controller = [[CXLTweetListViewController alloc]init];
    controller.type = type;
    return controller;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.currentPage = 0;
    [self setRefresh];
    [self.view addSubview:self.myTable];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.myTable.frame = self.view.bounds;
}

- (void)setRefresh{
    self.myTable.mj_header = [CXLCustomHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshData)];
    self.myTable.mj_footer = [CXLCustomFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.myTable.mj_header beginRefreshing];
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsLayouts *layout = self.dataArray[indexPath.row];
    PostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCell" forIndexPath:indexPath];
    cell.selectIndex = indexPath.row;
    cell.layout = layout;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsLayouts *layout = self.dataArray[indexPath.row];
    return layout.totalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsLayouts *layout = self.dataArray[indexPath.row];
    PostsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.delegate respondsToSelector:@selector(didClickedCell: postsModel:)]) {
        [self.delegate didClickedCell:cell postsModel:layout.postsModel];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    SLog(@"开始拖拽");
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    SLog(@"开始减速--%@",NSStringFromCGPoint(velocity));
    /*隐藏导航栏*/
    if (velocity.y > 1.0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:CXLHideNavigationNotification object:nil];
    }
    
    /*显示导航栏*/
    if (velocity.y < -1.0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:CXLShowNavigationNotification object:nil];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    SLog(@"停止");
}

#pragma mark - PostsCellDelegate
- (void)didClickedExpendButton:(NSInteger)index{
    PostsLayouts *layout = self.dataArray[index];
    layout.isExpend = !layout.isExpend;
    [layout layout];
    [self.myTable reloadData];
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
    [MLNetWorkHelper GET:[self urlString] parameters:@{} responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        [self.myTable.mj_header endRefreshing];
        [self.myTable.mj_footer endRefreshing];
        SLog(@"%@",[responseObject yy_modelToJSONString]);
        NSArray *array = responseObject[@"list"];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PostsModel *model = [PostsModel yy_modelWithJSON:obj];
            PostsLayouts *layout = [[PostsLayouts alloc]initWithModel:model];
            [self.dataArray addObject:layout];
        }];
        [self.myTable reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (NSString *)urlString{
    NSString *urlString = @"";
    switch (self.type) {
        case PostsTypeEssence:
            urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
            break;
        case PostsTypeVideo:
            urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/list/jingxuan/41/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
            break;
        case PostsTypeImage:
            urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/list/jingxuan/10/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
            break;
        case PostsTypeJoke:
            urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/tag-topic/64/hot/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
            break;
        case PostsTypeRank:
            urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/list/remen/1/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
            break;
        case PostsTypeSocial:
            urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/tag-topic/473/hot/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
            break;
        case PostsTypeMovieShare:
            urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/tag-topic/407/hot/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
            break;
        case PostsTypeGame:
            urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/tag-topic/164/hot/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
            break;
        case PostsType8090:
            urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/tag-topic/5170/hot/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
            break;
        case PostsTypeInteractive:
            urlString = [NSString stringWithFormat:@"http://s.budejie.com/topic/tag-topic/44289/hot/bs0315-iphone-4.5.7/%d-20.json",_currentPage];
            break;
    }
    return urlString;
}

#pragma mark - Setter && Getter
- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTable.backgroundColor = [UIColor clearColor];
        _myTable.tableFooterView = [UIView new];
        _myTable.separatorColor = RGBLINE;
        [_myTable registerClass:[PostsCell class] forCellReuseIdentifier:@"PostsCell"];
        _myTable.delegate = self;
        _myTable.dataSource = self;
    }
    return _myTable;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end

