//
//  PostsProfileView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsProfileView.h"

@interface PostsProfileView()
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UIImageView *vipImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@end

@implementation PostsProfileView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    _avatar = [UIImageView new];
    _avatar.clipsToBounds = YES;
    _avatar.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.equalTo(self).offset(kWBCellPadding);
        make.top.equalTo(self).offset(kWBCellPadding + 3);
    }];
    
    CALayer *avatarBorder = [CALayer layer];
    avatarBorder.frame = _avatar.bounds;
    avatarBorder.borderWidth = CGFloatFromPixel(1);
    avatarBorder.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
    avatarBorder.cornerRadius = _avatar.height / 2;
    avatarBorder.shouldRasterize = YES;
    avatarBorder.rasterizationScale = kScreenScale;
    [_avatar.layer addSublayer:avatarBorder];
    
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

@end
