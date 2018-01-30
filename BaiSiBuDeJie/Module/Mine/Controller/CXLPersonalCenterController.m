//
//  CXLPersonalCenterController.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/24.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLPersonalCenterController.h"
#import "PostsModel.h"
#import "PostsMemberCenterNavigation.h"
#import "CXLMemberCenterHeaderView.h"
#import "CXLMineInfoModel.h"
#import "CXLMemberCenterFootView.h"
#import "CXLTableView.h"

static CGFloat const KHeaderViewHeight = 260;
static CGFloat const KMaxImageOffSet = 100;
@interface CXLPersonalCenterController ()
<UITableViewDelegate,PostsMemberCenterNavigationDelegate>
@property (nonatomic,strong) PostsModel *postModel;
@property (nonatomic,strong) PostsMemberCenterNavigation *customNavigation;
@property (nonatomic,strong) CXLMemberCenterHeaderView *headerView;
@property (nonatomic,strong) CXLMemberCenterFootView *footView;
@property (nonatomic,strong) CXLTableView *myTable;
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

    [self getUserInfo];
    self.myTable.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.myTable.contentInset = UIEdgeInsetsMake(KHeaderViewHeight, 0, 0, 0);
    [self.view addSubview:self.myTable];
    [self.view addSubview:self.customNavigation];
    [self.myTable addSubview:self.headerView];
    self.myTable.tableFooterView = self.footView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //改变导航栏的透明度
    [self.customNavigation setAttributesWithOffSet:offsetY + KHeaderViewHeight];
    
    //下拉时改变图片的高度和初始的Y值
    if (offsetY < -KHeaderViewHeight) {
        self.headerView.top = offsetY;
        self.headerView.height = fabs(offsetY);
    }
    
    //限制最大下拉高度
    if (offsetY < -(KHeaderViewHeight + KMaxImageOffSet)) {
        [self.myTable setContentOffset:CGPointMake(0, -(KHeaderViewHeight + KMaxImageOffSet))];
    }
}

#pragma mark - PostsMemberCenterNavigationDelegate
- (void)didClickBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickMoreButton{
    NSLog(@"点击了更多");
}

#pragma mark - NetRequest
- (void)getUserInfo{
    NSString *url = [NSString stringWithFormat:@"http://d.api.budejie.com/user/profile?appname=bs0315&asid=91344335-9305-4C86-881F-56E9C333D8BA&client=iphone&device=iPhone205S&from=ios&jbk=1&market=&openudid=26a043f8294d182c9ca9d4665eb74d69ca6b8ee3&sex=m&t=1516956353&udid=&uid=21665716&userid=%@&ver=4.5.7",_postModel.u.uid];
    [MLNetWorkHelper GET:url parameters:@{} success:^(id responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        CXLMineInfoModel *model = [CXLMineInfoModel yy_modelWithJSON:dict];
        self.headerView.infoModel = model;
       
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

#pragma mark - Setter && Getter
- (CXLTableView *)myTable{
    if (!_myTable) {
        _myTable = [[CXLTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTable.backgroundColor = [UIColor clearColor];
        _myTable.separatorColor = RGBLINE;
        _myTable.delegate = self;
    }
    return _myTable;
}

- (PostsMemberCenterNavigation *)customNavigation{
    if (!_customNavigation) {
        _customNavigation = [PostsMemberCenterNavigation new];
        _customNavigation.delegate = self;
    }
    return _customNavigation;
}

- (CXLMemberCenterHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[CXLMemberCenterHeaderView alloc]initWithFrame:CGRectMake(0, -KHeaderViewHeight, kScreenWidth, KHeaderViewHeight)];
    }
    return _headerView;
}

- (CXLMemberCenterFootView *)footView{
    if (!_footView) {
        _footView = [[CXLMemberCenterFootView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _footView.member_id = _postModel.u.uid;
    }
    return _footView;
}

@end
