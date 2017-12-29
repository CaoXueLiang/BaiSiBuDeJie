//
//  CXLTweetListViewController.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/28.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CXLTweetListViewController.h"
@interface CXLTweetListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,assign) NSInteger currentPage;
@end

@implementation CXLTweetListViewController
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

#pragma mark - NetRequest
- (void)freshData{
    self.currentPage = 0;
    [self sendRequest];
}

- (void)loadMoreData{
    self.currentPage += 1;
    [self sendRequest];
}

- (void)sendRequest{
    NSString *URLString = @"http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.5.7/0-20.json";
    [MLNetWorkHelper GET:URLString parameters:@{} responseCache:^(id responseCache) {
        
        
    } success:^(id responseObject) {
        
        [self.myTable.mj_header endRefreshing];
        SLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Setter && Getter
- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTable.backgroundColor = [UIColor clearColor];
        _myTable.tableFooterView = [UIView new];
        _myTable.delegate = self;
        _myTable.dataSource = self;
    }
    return _myTable;
}

@end
