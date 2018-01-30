//
//  CXLMemberCenterHeaderView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/26.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLMemberCenterHeaderView.h"
#import "CXLMineInfoModel.h"
#import "UIButton+Aliment.h"

@interface CXLMemberCenterHeaderView()
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
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(KbottomViewHeight);
    }];
    
    [self.bottomView addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.equalTo(self.bottomView).offset(12);
        make.top.equalTo(self.bottomView).offset(-20);
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
        make.left.equalTo(self.fansLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(1, 15));
        make.centerY.equalTo(self.detailView.mas_centerY);
    }];

    [self.detailView addSubview:self.attentionLabel];
    [self.attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fansLabel.mas_right).offset(20);
        make.centerY.equalTo(self.detailView.mas_centerY);
    }];

    [self.detailView addSubview:self.rightLine];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.attentionLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(1, 15));
        make.centerY.equalTo(self.detailView.mas_centerY);
    }];

    [self.detailView addSubview:self.levelLabel];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.attentionLabel.mas_right).offset(20);
        make.centerY.equalTo(self.detailView.mas_centerY);
    }];

    [self.bottomView addSubview:self.attentionButton];
    [self.attentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailView.mas_left);
        make.right.equalTo(self.bottomView).offset(-20);
        make.height.mas_equalTo(30);
    make.centerY.mas_equalTo(self.bottomView.mas_centerY).offset(KbottomViewHeight/4.0);
    }];

    [self insertSubview:self.backImageview belowSubview:self.bottomView];
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

#pragma mark - Public Menthod
- (void)setInfoModel:(CXLMineInfoModel *)infoModel{
    _infoModel = infoModel;
    [_backImageview sd_setImageWithURL:[NSURL URLWithString:infoModel.background_image]];
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:infoModel.profile_image]];
    NSInteger fans = [infoModel.fans_count integerValue];
    NSInteger attention = [infoModel.follow_count integerValue];
    if (fans >= 1000) {
        NSString *fansString = fans % 1000 == 0 ? [NSString stringWithFormat:@"%.0fk 粉丝",fans / 1000.0] : [NSString stringWithFormat:@"%.1fk 粉丝",fans / 1000.0];
        _fansLabel.text = fansString;
    }else{
        _fansLabel.text = [NSString stringWithFormat:@"%ld 粉丝",fans];
    }
    
    if (attention >= 1000) {
        NSString *attentionString = fans % 1000 == 0 ? [NSString stringWithFormat:@"%.0fk 关注",fans / 1000.0] : [NSString stringWithFormat:@"%.1fk 关注",fans / 1000.0];
        _attentionLabel.text = attentionString;
    }else{
        _attentionLabel.text = [NSString stringWithFormat:@"%ld 关注",attention];
    }
    _levelLabel.text = [NSString stringWithFormat:@"等级: LV%@",infoModel.level];
    [_praisedButton setTitle:infoModel.total_cmt_like_count forState:UIControlStateNormal];
    [_praisedButton layoutImageTitleHorizontalOffSet:10];
}

#pragma mark - Setter && Getter
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
        [_praisedButton setBackgroundImage:[UIImage imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.4] size:CGSizeMake(70, 30)] forState:UIControlStateNormal];
        _praisedButton.layer.borderWidth = 1;
        _praisedButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _praisedButton.layer.cornerRadius = 30/2.0;
        _praisedButton.layer.masksToBounds = YES;
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
    return _leftLine;
}

- (UIView *)rightLine{
    if (!_rightLine) {
        _rightLine = [UIView new];
        _rightLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _rightLine;
}



@end
