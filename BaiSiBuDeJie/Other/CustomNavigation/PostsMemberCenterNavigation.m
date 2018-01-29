//
//  PostsMemberCenterNavigation.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/26.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsMemberCenterNavigation.h"
#import "UIButton+Aliment.h"
#import "PostsModel.h"

@interface PostsMemberCenterNavigation()
@property (nonatomic,strong) UIView   *contentView;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIButton *moreButton;
@property (nonatomic,strong) UILabel  *nameLabel;
@end

@implementation PostsMemberCenterNavigation
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = KTopHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = MainColor;
    _contentView.alpha = 0;
    _contentView.frame = self.bounds;
    [self addSubview:_contentView];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"capture_nav_back_normal_480_44x44_"] forState:UIControlStateNormal];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backButton];
    [_backButton layoutImageTitleHorizontalOffSet:5];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self.mas_top).offset(kStatusBarHeight + kNavBarHeight/2.0);
    }];
    
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton setImage:[UIImage imageNamed:@"cellmorebtnnormal_24x20_"] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_moreButton];
    [_moreButton layoutImageTitleHorizontalOffSet:5];
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-12);
        make.centerY.equalTo(self.mas_top).offset(kStatusBarHeight + kNavBarHeight/2.0);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(80);
        make.right.equalTo(self).offset(-80);
        make.top.equalTo(self).offset(kStatusBarHeight);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - Public Menthod
- (void)setModel:(PostsModel *)model{
    _model = model;
    _nameLabel.text = model.u.name;
}

- (void)setAttributesWithOffSet:(CGFloat)offset{
    CGFloat ratio = MIN(MAX(0, offset / (300 - KTopHeight)), 1);
    self.contentView.alpha = ratio;
}

#pragma mark - Event Response
- (void)back{
    if ([self.delegate respondsToSelector:@selector(didClickBackButton)]) {
        [self.delegate didClickBackButton];
    }
}

- (void)moreButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickMoreButton)]) {
        [self.delegate didClickMoreButton];
    }
}

@end
