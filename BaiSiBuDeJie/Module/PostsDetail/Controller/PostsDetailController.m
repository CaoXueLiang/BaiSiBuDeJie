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
#import "PostsCommentSectionHeaderView.h"

@interface PostsDetailController ()
<PostsDetailNavigationDelegate,UITableViewDelegate,
UITableViewDataSource,PostsCommentComplexCellDelegate>
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,strong) NSMutableArray *hotCommentArray;
@property (nonatomic,strong) NSMutableArray *normalCommentArray;
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
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)setRefresh{
    self.myTable.mj_header = [CXLCustomHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshData)];
    self.myTable.mj_footer = [CXLCustomFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - UITableView M
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotCommentArray.count;
    }else{
        return self.normalCommentArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsCommentDetailComplexLayout *layout;
    if (indexPath.section == 0) {
        layout = self.hotCommentArray[indexPath.row];
    }else{
        layout = self.normalCommentArray[indexPath.row];
    }
    PostsCommentComplexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCommentComplexCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setComplexLayout:layout];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PostsCommentSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PostsCommentSectionHeaderView"];
    if (section == 0) {
        [header setSectionTitle:@"最热评论"];
    }else if (section == 1){
        [header setSectionTitle:@"最新评论"];
    }
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN)];
    foot.backgroundColor = [UIColor clearColor];
    return foot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsCommentDetailComplexLayout *layout;
    if (indexPath.section == 0) {
        layout = self.hotCommentArray[indexPath.row];
    }else{
        layout = self.normalCommentArray[indexPath.row];
    }
    return layout.totalHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotCommentArray.count > 0 ? [PostsCommentSectionHeaderView sectionHeight] : CGFLOAT_MIN;
    }else{
       return [PostsCommentSectionHeaderView sectionHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.myTable deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSection{
    NSInteger hotNum = self.hotCommentArray.count;
    NSInteger normalNum = self.normalCommentArray.count;
    if (hotNum > 0 && normalNum > 0) {
        return 2;
    }else if (hotNum > 0 || normalNum > 0){
        return 1;
    }else{
        return 0;
    }
}

#pragma mark - PostsCommentComplexCellDelegate
- (void)didClickedComplexUpButton:(PostsDetailCommentModel *)model{
    SLog(@"顶(complexCell):%@",model.user.username);
}

- (void)didClickedComplexDownButton:(PostsDetailCommentModel *)model{
    SLog(@"踩(complexCell):%@",model.user.username);
}

- (void)didClickedComplexNickName:(PostsDetailCommentModel *)model{
    SLog(@"点击了昵称(complexCell):%@",model.user.username);
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
    self.normalCommentArray = nil;
    self.hotCommentArray = nil;
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
        
        SLog(@"%@",[responseObject yy_modelToJSONString]);
        [self.myTable.mj_header endRefreshing];
        [self.myTable.mj_footer endRefreshing];
        NSArray *normalArray = [responseObject[@"normal"] valueForKey:@"list"];
        NSArray *hotArray = [responseObject[@"hot"] valueForKey:@"list"];
        @weakify(self);
        [normalArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *tmpDic = obj;
            PostsDetailCommentModel *model = [PostsDetailCommentModel yy_modelWithJSON:tmpDic];
            PostsCommentDetailComplexLayout *layout = [[PostsCommentDetailComplexLayout alloc]initWithModel:model];
            [weak_self.normalCommentArray addObject:layout];
        }];
        
        self.hotCommentArray = nil;
        [hotArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *tmpDic = obj;
            PostsDetailCommentModel *model = [PostsDetailCommentModel yy_modelWithJSON:tmpDic];
            PostsCommentDetailComplexLayout *layout = [[PostsCommentDetailComplexLayout alloc]initWithModel:model];
            [weak_self.hotCommentArray addObject:layout];
        }];
        [self.myTable reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

#pragma mark - Setter && Getter
- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0,kNavBarHeight, kScreenWidth, kScreenHeight - kNavBarHeight) style:UITableViewStyleGrouped];
        _myTable.backgroundColor = [UIColor clearColor];
        _myTable.tableFooterView = [UIView new];
        _myTable.separatorColor = RGBLINE;
        [_myTable registerClass:[PostsCommentComplexCell class] forCellReuseIdentifier:@"PostsCommentComplexCell"];
        [_myTable registerClass:[PostsCommentSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"PostsCommentSectionHeaderView"];
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

- (NSMutableArray *)hotCommentArray{
    if (!_hotCommentArray) {
        _hotCommentArray = [[NSMutableArray alloc]init];
    }
    return _hotCommentArray;
}

- (NSMutableArray *)normalCommentArray{
    if (!_normalCommentArray) {
        _normalCommentArray = [[NSMutableArray alloc]init];
    }
    return _normalCommentArray;
}

@end
