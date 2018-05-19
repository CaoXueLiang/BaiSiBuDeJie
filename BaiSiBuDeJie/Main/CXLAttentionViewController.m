//
//  CXLAttentionViewController.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/27.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CXLAttentionViewController.h"
#import "PostsThemeCell.h"
#import "PostsCommunityModel.h"

@interface CXLAttentionViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *myTable;
@end

@implementation CXLAttentionViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"社区";
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewBG);
    [self addSubViews];
    [self sendRequest];
}

- (void)addSubViews{
    [self.view addSubview:self.myTable];
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsCommunityModel *model = self.dataArray[indexPath.row];
    PostsThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsThemeCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PostsThemeCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Setter && Getter
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - KTopHeight) style:UITableViewStylePlain];
        [_myTable registerClass:[PostsThemeCell class] forCellReuseIdentifier:@"PostsThemeCell"];
        _myTable.delegate = self;
        _myTable.dataSource = self;
        _myTable.dk_separatorColorPicker = DKColorPickerWithKey(SeparatorLineColor);
        _myTable.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewBG);
        _myTable.tableFooterView = [UIView new];
    }
    return _myTable;
}

#pragma mark - Net Request
- (void)sendRequest{
    [MLNetWorkHelper GET:@"http://d.api.budejie.com/forum/subscribe/bs0315-iphone-4.5.7.json" parameters:@{} success:^(id responseObject) {
  
        NSArray *listArray = responseObject[@"list"];
        [listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PostsCommunityModel *model = [PostsCommunityModel yy_modelWithJSON:obj];
            [self.dataArray addObject:model];
        }];
        [self.myTable reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

@end
