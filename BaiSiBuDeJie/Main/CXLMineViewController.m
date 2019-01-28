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

@interface CXLMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,strong) UIButton *switchButton;
@end

@implementation CXLMineViewController
#pragma mark - Init Menthod
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewBG);
    [self addSubViews];
    [self setNavigation];
}

- (void)addSubViews{
    [self.view addSubview:self.myTable];
}

- (void)setNavigation{
    self.navigationItem.title = @"我的";
//    UIButton *moonButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moonButton setImage:[UIImage imageNamed:@"mine-moon-icon-click_20x20_"] forState:UIControlStateNormal];
//    [moonButton setImage:[UIImage imageNamed:@"mine-sun-icon_20x20_"] forState:UIControlStateSelected];
//    [moonButton addTarget:self action:@selector(switchTheme) forControlEvents:UIControlEventTouchUpInside];
//    self.switchButton = moonButton;
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:moonButton];
//    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)switchTheme{
    self.switchButton.selected = !self.switchButton.selected;
    if (self.switchButton.selected) {
        self.dk_manager.themeVersion = DKThemeVersionNight;
    }else{
        self.dk_manager.themeVersion = DKThemeVersionNormal;
    }
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
        _myTable.dk_backgroundColorPicker = DKColorPickerWithKey(TableViewBG);
        _myTable.delegate = self;
        _myTable.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _myTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _myTable.estimatedRowHeight = 0;
            _myTable.estimatedSectionFooterHeight = 0;
            _myTable.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _myTable;
}

@end
