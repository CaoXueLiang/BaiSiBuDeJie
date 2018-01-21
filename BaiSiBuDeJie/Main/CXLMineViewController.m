//
//  CXLMineViewController.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/27.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CXLMineViewController.h"
#import "CXLMineLoginCell.h"
#import "CXLMineItermCell.h"

@interface CXLMineViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTable;
@end

@implementation CXLMineViewController
#pragma mark - Init Menthod
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
    [self setNavigation];
}

- (void)addSubViews{
    [self.view addSubview:self.myTable];
}

- (void)setNavigation{
    self.navigationItem.title = @"我的";
}

#pragma mark - UITableView M
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CXLMineLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXLMineLoginCell" forIndexPath:indexPath];
        return cell;
    }else{
        CXLMineItermCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CXLMineItermCell" forIndexPath:indexPath];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN)];
    header.backgroundColor = [UIColor clearColor];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    header.backgroundColor = [UIColor clearColor];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [CXLMineLoginCell cellHeight];
    }else{
        return [CXLMineItermCell cellHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Setter && Getter
- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - KTopHeight) style:UITableViewStyleGrouped];
        [_myTable registerClass:[CXLMineLoginCell class] forCellReuseIdentifier:@"CXLMineLoginCell"];
        [_myTable registerClass:[CXLMineItermCell class] forCellReuseIdentifier:@"CXLMineItermCell"];
        _myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTable.delegate = self;
        _myTable.dataSource = self;
    }
    return _myTable;
}

@end
