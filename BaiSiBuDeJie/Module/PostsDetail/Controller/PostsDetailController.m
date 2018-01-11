//
//  PostsDetailController.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/5.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailController.h"
#import "PostsModel.h"

@interface PostsDetailController ()
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) int currentPage;
@property (nonatomic,strong) PostsModel *postsModel;
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
    self.currentPage = 0;
    [self setRefresh];
    [self freshData];
}

- (void)setRefresh{
    self.myTable.mj_header = [CXLCustomHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshData)];
    self.myTable.mj_footer = [CXLCustomFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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

        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

#pragma mark - Setter && Getter
- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTable.backgroundColor = [UIColor clearColor];
        _myTable.tableFooterView = [UIView new];
        _myTable.separatorColor = RGBLINE;
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
