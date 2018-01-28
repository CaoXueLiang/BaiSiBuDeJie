//
//  CXLMemberCenterHeaderView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/26.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLMemberCenterHeaderView.h"
#import "TYTabPagerBar.h"
#import "CXLMineInfoModel.h"
#import "UIButton+Aliment.h"

@interface CXLMemberCenterHeaderView()
<TYTabPagerBarDataSource,TYTabPagerBarDelegate>
@property (nonatomic,strong) UIImageView *backImageview;
@property (nonatomic,strong) UIButton *praisedButton;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIImageView *avatarView;
@property (nonatomic,strong) UIImageView *vipImageView;
@property (nonatomic,strong) UIButton *attentionButton;
@property (nonatomic,strong) UIView *detailView;
@property (nonatomic,strong) UILabel *fansLabel;
@property (nonatomic,strong) UILabel *attentionLabel;
@property (nonatomic,strong) UILabel *levelLabel;
@property (nonatomic,strong) UIView *leftLine;
@property (nonatomic,strong) UIView *rightLine;
@property (nonatomic,strong) TYTabPagerBar *tabBar;
@property (nonatomic,strong) NSArray *itermArray;
@end

static CGFloat const KtabBarHeight = 45;
static CGFloat const KbottomViewHeight = 100;
@implementation CXLMemberCenterHeaderView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.tabBar];
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(KtabBarHeight);
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.tabBar.mas_bottom);
        make.height.mas_equalTo(KbottomViewHeight);
    }];
    
    [self.bottomView addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.equalTo(self.bottomView).offset(12);
        make.top.equalTo(self.bottomView).offset(-30);
    }];
    
    [self.bottomView addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).offset(12);
        make.top.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView);
        make.bottom.equalTo(self.bottomView.mas_centerY);
    }];
    
    [self.detailView addSubview:self.fansLabel];
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailView);
        make.centerY.equalTo(self.detailView.mas_centerY);
    }];
    
    [self.detailView addSubview:self.leftLine];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.levelLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.centerY.equalTo(self.detailView.mas_centerY);
    }];
    
    [self.detailView addSubview:self.attentionLabel];
    [self.attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLine.mas_right).offset(10);
        make.centerY.equalTo(self.detailView.mas_centerY);
    }];
    
    [self.detailView addSubview:self.rightLine];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.attentionLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.centerY.equalTo(self.detailView.mas_centerY);
    }];
    
    [self.detailView addSubview:self.levelLabel];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightLine.mas_right).offset(10);
        make.centerY.equalTo(self.detailView.mas_centerY);
    }];
    
    [self.bottomView addSubview:self.attentionButton];
    [self.attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailView.mas_left);
        make.right.equalTo(self.bottomView).offset(-20);
        make.height.mas_equalTo(35);
        make.centerY.mas_equalTo(KbottomViewHeight/2.0 + KbottomViewHeight/4.0);
    }];
    
    [self addSubview:self.backImageview];
    [self.backImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.backImageview addSubview:self.praisedButton];
    [self.praisedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backImageview).offset(-12);
        make.bottom.equalTo(self.backImageview).offset(-12);
    }];
}


#pragma mark - TYTabPagerBarDataSource
- (NSInteger)numberOfItemsInPagerTabBar {
    return self.itermArray.count;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = self.itermArray[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate
- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSString *title = self.itermArray[index];
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    
}

#pragma mark - Setter && Getter
- (NSArray *)itermArray{
    if (!_itermArray) {
        _itermArray = @[@"帖子",@"分享",@"评论"];
    }
    return _itermArray;
}

- (UIImageView *)backImageview{
    if (!_backImageview) {
        _backImageview = [[UIImageView alloc]init];
        _backImageview.contentMode = UIViewContentModeScaleAspectFill;
        _backImageview.clipsToBounds = YES;
    }
    return _backImageview;
}

- (UIButton *)praisedButton{
    if (!_praisedButton) {
        _praisedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praisedButton setImage:[UIImage imageNamed:@"profile-praise_15x15_"] forState:UIControlStateNormal];
        [_praisedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _praisedButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _praisedButton.userInteractionEnabled = NO;
        _praisedButton.layer.cornerRadius = 50/2.0;
        _praisedButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _praisedButton.layer.borderWidth = 1.0f;
    }
    return _praisedButton;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (UIImageView *)avatarView{
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc]init];
        _avatarView.layer.cornerRadius = 80/2.0;
        _avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
        _avatarView.layer.borderWidth = 2;
        _avatarView.clipsToBounds = YES;
    }
    return _avatarView;
}

- (UIImageView *)vipImageView{
    if (!_vipImageView) {
        _vipImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tag_user_vip_icon_14x14_"]];
    }
    return _vipImageView;
}

- (UIButton *)attentionButton{
    if (!_attentionButton) {
        _attentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_attentionButton setImage:[UIImage imageNamed:@"tagAddIconClick_17x17_"] forState:UIControlStateNormal];
        [_attentionButton setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionButton setTitleColor:MainColor forState:UIControlStateNormal];
        _attentionButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_attentionButton layoutImageTitleHorizontalOffSet:5];
        _attentionButton.layer.cornerRadius = 5;
        _attentionButton.layer.borderWidth = 1;
        _attentionButton.layer.borderColor = MainColor.CGColor;
    }
    return _attentionButton;
}

- (UIView *)detailView{
    if (!_detailView) {
        _detailView = [UIView new];
    }
    return _detailView;
}

- (UILabel *)fansLabel{
    if (!_fansLabel) {
        _fansLabel = [UILabel new];
        _fansLabel.font = [UIFont systemFontOfSize:14];
        _fansLabel.textColor = [UIColor grayColor];
        _fansLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _fansLabel;
}

- (UILabel *)attentionLabel{
    if (!_attentionLabel) {
        _attentionLabel = [UILabel new];
        _attentionLabel.font = [UIFont systemFontOfSize:14];
        _attentionLabel.textColor = [UIColor grayColor];
        _attentionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _attentionLabel;
}

- (UILabel *)levelLabel{
    if (!_levelLabel) {
        _levelLabel = [UILabel new];
        _levelLabel.font = [UIFont systemFontOfSize:14];
        _levelLabel.textColor = [UIColor grayColor];
        _levelLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _levelLabel;
}

- (UIView *)leftLine{
    if (!_leftLine) {
        _leftLine = [UIView new];
        _leftLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _rightLine;
}

- (UIView *)rightLine{
    if (!_rightLine) {
        _rightLine = [UIView new];
        _rightLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _rightLine;
}

- (TYTabPagerBar *)tabBar{
    if (!_tabBar) {
        _tabBar = [[TYTabPagerBar alloc]init];
        _tabBar.layout.barStyle = TYPagerBarStyleProgressView;
        _tabBar.dataSource = self;
        _tabBar.delegate = self;
        _tabBar.backgroundColor = [UIColor whiteColor];
        _tabBar.layout.normalTextColor = [UIColor grayColor];
        _tabBar.layout.selectedTextColor = MainColor;
        _tabBar.layout.progressColor = [UIColor whiteColor];
        _tabBar.layout.normalTextFont = [UIFont systemFontOfSize:16];
        _tabBar.layout.selectedTextFont = [UIFont systemFontOfSize:19];
        [_tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    }
    return _tabBar;
}



@end
