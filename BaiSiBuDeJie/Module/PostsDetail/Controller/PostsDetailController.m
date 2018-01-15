//
//  PostsDetailController.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/5.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailController.h"
#import "PostsModel.h"
#import "PostsDetailHeaderView.h"
#import "PostsDetailHeaderLayout.h"
#import "PostsDetailNavigation.h"
#import "PostsCommentComplexCell.h"
#import "PostsCommentDetailComplexLayout.h"
#import "PostsDetailCommentModel.h"

@interface PostsDetailController ()
<PostsDetailNavigationDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) int currentPage;
@property (nonatomic,strong) PostsModel *postsModel;
@property (nonatomic,strong) PostsDetailHeaderView *headerView;
@property (nonatomic,strong) PostsDetailNavigation *customNavigation;
@end

@implementation PostsDetailController
#pragma mark - Init Menthod
+ (instancetype)initWithPostsModel:(PostsModel *)model{
    PostsDetailController *controller = [[PostsDetailController alloc]init];
    controller.postsModel = model;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.myTable];
    
    _headerView = [PostsDetailHeaderView new];
    PostsDetailHeaderLayout *layout = [[PostsDetailHeaderLayout alloc]initWithModel:_postsModel];
    _headerView.height = layout.totalHeight;
    [_headerView setLayout:layout];
    self.myTable.tableHeaderView = _headerView;
    
    self.customNavigation.model = _postsModel;
    self.customNavigation.delegate = self;
    [self.view addSubview:self.customNavigation];
    
    if (@available(iOS 11.0, *)){
        self.myTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.currentPage = 0;
    [self setRefresh];
    [self freshData];
}

- (void)setRefresh{
    self.myTable.mj_header = [CXLCustomHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshData)];
    self.myTable.mj_footer = [CXLCustomFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsCommentDetailComplexLayout *layout = self.dataArray[indexPath.row];
    PostsCommentComplexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCommentComplexCell" forIndexPath:indexPath];
    [cell setComplexLayout:layout];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsCommentDetailComplexLayout *layout = self.dataArray[indexPath.row];
    return layout.totalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.myTable deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - PostsDetailNavigationDelegate
- (void)didClickedButton:(NSInteger)index{
    switch (index) {
        case 1:
            [self.navigationController popViewControllerAnimated:YES];
            break;
    }
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
    NSString *URLString = [NSString stringWithFormat:@"http://c.api.budejie.com/topic/comment_list/%@/0/bs0315-iphone-4.5.7/%d-20.json",_postsModel.postsId,_currentPage];
    [MLNetWorkHelper GET:URLString parameters:@{} responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        
        [self.myTable.mj_header endRefreshing];
        [self.myTable.mj_footer endRefreshing];
        SLog(@"%@",[responseObject yy_modelToJSONString]);
        NSArray *normalArray = [responseObject[@"normal"] valueForKey:@"list"];
        @weakify(self);
        [normalArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *tmpDic = obj;
            PostsDetailCommentModel *model = [PostsDetailCommentModel yy_modelWithJSON:tmpDic];
            PostsCommentDetailComplexLayout *layout = [[PostsCommentDetailComplexLayout alloc]initWithModel:model];
            [weak_self.dataArray addObject:layout];
        }];
        [self.myTable reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

#pragma mark - Setter && Getter
- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0,kNavBarHeight, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStylePlain];
        _myTable.backgroundColor = [UIColor clearColor];
        _myTable.tableFooterView = [UIView new];
        _myTable.separatorColor = RGBLINE;
        [_myTable registerClass:[PostsCommentComplexCell class] forCellReuseIdentifier:@"PostsCommentComplexCell"];
        _myTable.delegate = self;
        _myTable.dataSource = self;
    }
    return _myTable;
}

- (PostsDetailNavigation *)customNavigation{
    if (!_customNavigation) {
        _customNavigation = [PostsDetailNavigation new];
    }
    return _customNavigation;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
