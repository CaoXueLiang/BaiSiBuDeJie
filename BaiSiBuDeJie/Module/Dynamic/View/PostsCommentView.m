//
//  PostsCommentView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsCommentView.h"
#import "PostsCommentCell.h"
#import "PostsModel.h"

@interface PostsCommentView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *myTable;
@end

@implementation PostsCommentView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.myTable];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.myTable.frame = CGRectMake(kWBCellPadding, 0, self.bounds.size.width - 2*kWBCellPadding, self.bounds.size.height);
}


#pragma mark - Public Menthod
- (void)setCommentArray:(NSArray *)commentArray{
    self.dataArray = nil;
    for (PostsCommentModel *model in commentArray) {
        [self.dataArray addObject:model];
    }
    [self.myTable reloadData];
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsCommentModel *model = self.dataArray.count > 0 ? self.dataArray[indexPath.row] : nil;
    PostsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCommentCell" forIndexPath:indexPath];
    cell.commentModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsCommentModel *model = self.dataArray.count > 0 ? self.dataArray[indexPath.row] : nil;
    return [PostsCommentCell cellHeightWithModel:model];
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
        _myTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTable.backgroundColor = [UIColor colorWithHexString:@"f8f8f8"];
        [_myTable registerClass:[PostsCommentCell class] forCellReuseIdentifier:@"PostsCommentCell"];
        _myTable.delegate = self;
        _myTable.dataSource = self;
    }
    return _myTable;
}
@end
