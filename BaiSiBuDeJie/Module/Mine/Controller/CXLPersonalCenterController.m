//
//  CXLPersonalCenterController.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/24.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLPersonalCenterController.h"
#import "PostsModel.h"
#import "PostsLayouts.h"
#import "PostsCell.h"
#import "PostsToolBarView.h"
#import "PostsProfileView.h"
#import "PostsMemberCenterNavigation.h"
#import "CXLMemberCenterHeaderView.h"

@interface CXLPersonalCenterController ()
<UITableViewDelegate,UITableViewDataSource,PostsCellDelegate>
@property (nonatomic,strong) PostsModel *postModel;
@property (nonatomic,strong) PostsMemberCenterNavigation *customNavigation;
@property (nonatomic,strong) CXLMemberCenterHeaderView *headerView;
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,copy)   NSString *URLString;
@end

@implementation CXLPersonalCenterController
#pragma mark - Init Menthod
+ (instancetype)initWithModel:(PostsModel *)model{
    CXLPersonalCenterController *controller = [[CXLPersonalCenterController alloc]init];
    controller.postModel = model;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.currentPage = 0;
    self.URLString = [NSString stringWithFormat:@"http://s.budejie.com/topic/user-topic/%@/1/desc/bs0315-iphone-4.5.7/0-20.json",_postModel.u.uid];
    [self setRefresh];
    [self getUserInfo];
    self.myTable.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:self.myTable];
    [self.view addSubview:self.customNavigation];
}

- (void)setRefresh{
    self.myTable.mj_footer = [CXLCustomFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self sendRequest];
}
//
//#pragma mark - UITableView M
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    PostsLayouts *layout = self.dataArray[indexPath.row];
//    PostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCell" forIndexPath:indexPath];
//    cell.selectIndex = indexPath.row;
//    cell.layout = layout;
//    cell.delegate = self;
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    PostsLayouts *layout = self.dataArray[indexPath.row];
//    return layout.totalHeight;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PostsLayouts *layout = self.dataArray[indexPath.row];
//    PostsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.]
//}
//
//#pragma mark - PostsCellDelegate
///**点击展开，收起按钮*/
//- (void)didClickedExpendButton:(NSInteger)index{
//    PostsLayouts *layout = self.dataArray[index];
//    layout.isExpend = !layout.isExpend;
//    [layout layout];
//    [self.myTable reloadRow:index inSection:0 withRowAnimation:UITableViewRowAnimationFade];
//}
//
///**点击了赞*/
//- (void)didClickedUpButon:(NSInteger)index{
//    PostsCell *cell = [self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//    PostsLayouts *layout = self.dataArray[index];
//    NSInteger upNum = [layout.postsModel.up integerValue];
//    layout.postsModel.up = [NSString stringWithFormat:@"%ld",upNum + 1];
//    layout.postsModel.isUp = YES;
//    [cell upButtonAnimation];
//    [cell.profileView thanksAnimation];
//    cell.toolbarView.model = layout.postsModel;
//}
//
///**点击了踩*/
//- (void)didClickedDownButton:(NSInteger)index{
//    PostsCell *cell = [self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//    PostsLayouts *layout = self.dataArray[index];
//    NSInteger downNum = [layout.postsModel.down integerValue];
//    layout.postsModel.down = [NSString stringWithFormat:@"%ld",downNum + 1];
//    layout.postsModel.isDown = YES;
//    [cell downButtonAnimation];
//    cell.toolbarView.model = layout.postsModel;
//}
//
//- (void)didClickedUser:(NSInteger)index{
//    PostsLayouts *layout = self.dataArray[index];
//    if ([self.delegate respondsToSelector:@selector(didClickedUserWithPostsModel:)]) {
//        [self.delegate didClickedUserWithPostsModel:layout.postsModel];
//    }
//}

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
    [MLNetWorkHelper GET:self.URLString parameters:@{} responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        [self.myTable.mj_header endRefreshing];
        [self.myTable.mj_footer endRefreshing];
        SLog(@"%@",[responseObject yy_modelToJSONString]);
        NSArray *array = responseObject[@"list"];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PostsModel *model = [PostsModel yy_modelWithJSON:obj];
            PostsLayouts *layout = [[PostsLayouts alloc]initWithModel:model];
         //   [self.dataArray addObject:layout];
        }];
        [self.myTable reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)getUserInfo{
    NSString *url = [NSString stringWithFormat:@"http://d.api.budejie.com/user/profile?appname=bs0315&asid=91344335-9305-4C86-881F-56E9C333D8BA&client=iphone&device=iPhone205S&from=ios&jbk=1&market=&openudid=26a043f8294d182c9ca9d4665eb74d69ca6b8ee3&sex=m&t=1516956353&udid=&uid=21665716&userid=%@&ver=4.5.7",_postModel.u.uid];
    [MLNetWorkHelper GET:url parameters:@{} success:^(id responseObject) {
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
        [_myTable registerClass:[PostsCell class] forCellReuseIdentifier:@"PostsCell"];
//        _myTable.delegate = self;
//        _myTable.dataSource = self;
    }
    return _myTable;
}

- (PostsMemberCenterNavigation *)customNavigation{
    if (!_customNavigation) {
        _customNavigation = [PostsMemberCenterNavigation new];
    }
    return _customNavigation;
}

- (CXLMemberCenterHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[CXLMemberCenterHeaderView alloc]init];
    }
    return _headerView;
}

@end
