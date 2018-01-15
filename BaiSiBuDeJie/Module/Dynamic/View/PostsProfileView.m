//
//  PostsProfileView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsProfileView.h"
#import "PostsModel.h"

@interface PostsProfileView()
@property (nonatomic,strong) UIImageView *avatar;        //头像
@property (nonatomic,strong) UIImageView *vipImageView;  //vip图标
@property (nonatomic,strong) UILabel *nameLabel;         //昵称
@property (nonatomic,strong) UILabel *dateLabel;         //发布日期
@end

@implementation PostsProfileView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellProfileHeight;
    }
    self = [super initWithFrame:frame];
    [self addSubViews];
    return self;
}

- (void)addSubViews{
    _avatar = [UIImageView new];
    _avatar.clipsToBounds = YES;
    [self addSubview:_avatar];
    _avatar.layer.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
    _avatar.layer.cornerRadius = 30.0 / 2;
    _avatar.layer.borderWidth = CGFloatFromPixel(1);
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self).offset(kWBCellPadding);
        make.top.equalTo(self).offset(kWBCellPadding);
    }];
    
    _vipImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Profile_AddV_authen_14x14_"]];
    _vipImageView.hidden = YES;
    [self addSubview:_vipImageView];
    [_vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.right.equalTo(_avatar.mas_right);
        make.bottom.equalTo(_avatar.mas_bottom);
    }];
    
    _nameLabel = [UILabel new];
    _nameLabel.textColor = MainNameColor;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(kWBCellPadding);
        make.top.equalTo(_avatar.mas_top);
        make.right.equalTo(self).offset(-kWBCellPadding);
        make.bottom.equalTo(_avatar.mas_centerY);
    }];
    
    _dateLabel = [UILabel new];
    _dateLabel.textColor = MainGrayTextColor;
    _dateLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar.mas_right).offset(kWBCellPadding);
        make.top.equalTo(_avatar.mas_centerY);
        make.right.equalTo(self).offset(-kWBCellPadding);
        make.bottom.equalTo(_avatar.mas_bottom);
    }];
}

#pragma mark - Public Menthod
- (void)setModel:(PostsModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    PostsUserModel *userModel = model.u;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:userModel.headerArray[0]] placeholderImage:[UIImage imageNamed:@"headerPlaceholder"]];
    _nameLabel.text = userModel.name;
    _dateLabel.text = model.passtime;
    
    if (userModel.is_vip) {
        _vipImageView.hidden = NO;
    }else{
        _vipImageView.hidden = YES;
    }
}

@end
