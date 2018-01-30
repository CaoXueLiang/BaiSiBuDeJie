//
//  CXLMineCenterListView.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/30.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLMineCenterListView.h"
#import "PostsModel.h"
#import "PostsLayouts.h"
#import "PostsCell.h"
#import "PostsToolBarView.h"
#import "PostsProfileView.h"

@interface CXLMineCenterListView()
<UITableViewDelegate,UITableViewDataSource,PostsCellDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,assign) int currentPage; //当前页数
@property (nonatomic,assign) MemberListType type;
@property (nonatomic,copy)   NSString *userId;
@property (nonatomic,copy)   NSString *URLString;
@end

@implementation CXLMineCenterListView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame type:(MemberListType)type memberId:(NSString *)uid{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        self.currentPage = 0;
        [self addSubview:self.myTable];
        self.myTable.frame = self.bounds;
        [self setRefresh];
        [self freshData];
    }
    return self;
}

- (void)setRefresh{
    self.myTable.mj_footer = [CXLCustomFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - PostsCellDelegate
/**点击展开，收起按钮*/
- (void)didClickedExpendButton:(NSInteger)index{
    PostsLayouts *layout = self.dataArray[index];
    layout.isExpend = !layout.isExpend;
    [layout layout];
    [self.myTable reloadRow:index inSection:0 withRowAnimation:UITableViewRowAnimationFade];
}

/**点击了赞*/
- (void)didClickedUpButon:(NSInteger)index{
    PostsCell *cell = [self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    PostsLayouts *layout = self.dataArray[index];
    NSInteger upNum = [layout.postsModel.up integerValue];
    layout.postsModel.up = [NSString stringWithFormat:@"%ld",upNum + 1];
    layout.postsModel.isUp = YES;
    [cell upButtonAnimation];
    [cell.profileView thanksAnimation];
    cell.toolbarView.model = layout.postsModel;
}

/**点击了踩*/
- (void)didClickedDownButton:(NSInteger)index{
    PostsCell *cell = [self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    PostsLayouts *layout = self.dataArray[index];
    NSInteger downNum = [layout.postsModel.down integerValue];
    layout.postsModel.down = [NSString stringWithFormat:@"%ld",downNum + 1];
    layout.postsModel.isDown = YES;
    [cell downButtonAnimation];
    cell.toolbarView.model = layout.postsModel;
}

- (void)didClickedUser:(NSInteger)index{
  
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
    self.URLString = @"http://s.budejie.com/topic/user-topic/21062946/1/desc/bs0315-iphone-4.5.7/0-20.json";
//    if (self.type == MemberListTypePosts) {
//        self.URLString = [NSString stringWithFormat:@"http://s.budejie.com/topic/user-topic/%@/1/desc/bs0315-iphone-4.5.7/%d-20.json",_userId,_currentPage];
//
//    }else if (self.type == MemberListTypeShare){
//        self.URLString = [NSString stringWithFormat:@"http://s.budejie.com/topic/share-topic/%@/bs0315-iphone-4.5.7/%d-20.json",_userId,_currentPage];
//    }else{
//        self.URLString = [NSString stringWithFormat:@"http://s.budejie.com/comment/user-comment/%@/bs0315-iphone-4.5.7/%d-20.json",_userId,_currentPage];
//    }
    
    [MLNetWorkHelper GET:self.URLString parameters:@{} responseCache:^(id responseCache) {
        
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

#pragma mark - Setter && Getter
- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTable.backgroundColor = [UIColor clearColor];
        _myTable.tableFooterView = [UIView new];
        _myTable.separatorColor = RGBLINE;
        _myTable.bounces = NO;
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
