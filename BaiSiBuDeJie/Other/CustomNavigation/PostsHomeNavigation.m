//
//  PostsHomeNavigation.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/22.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsHomeNavigation.h"

@interface PostsHomeNavigation()
@property (nonatomic,strong) UIView *statusView;
@property (nonatomic,strong) UIView *navigationBarView;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIImageView *titleView;
@end

@implementation PostsHomeNavigation
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
    [self addSubview:self.navigationBarView];
    [self addSubview:self.statusView];
    [self.navigationBarView addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kNavBarHeight, kNavBarHeight));
        make.centerY.equalTo(self.navigationBarView);
        make.left.equalTo(self.navigationBarView);
    }];
    
    [self.navigationBarView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kNavBarHeight, kNavBarHeight));
        make.centerY.equalTo(self.navigationBarView);
        make.right.equalTo(self.navigationBarView);
    }];
    
    [self.navigationBarView addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.navigationBarView);
    }];
}

#pragma mark - Public Menthod
- (void)scrollAnimationWithVelocity:(CGPoint)velocity{
    /*隐藏导航栏*/
    if (velocity.y > 1.0) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.navigationBarView.top = kStatusBarHeight - kNavBarHeight;
        } completion:nil];
    }
    
    /*显示导航栏*/
    if (velocity.y < -1.0) {
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.navigationBarView.top = kStatusBarHeight;
        } completion:nil];
    }
}

#pragma mark - Setter && Getter
- (UIView *)statusView{
    if (!_statusView) {
        _statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight)];
        //_statusView.backgroundColor = MainColor;
        _statusView.dk_backgroundColorPicker = DKColorPickerWithKey(NavigationBarColor);
    }
    return _statusView;
}

- (UIView *)navigationBarView{
    if (!_navigationBarView) {
        _navigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kNavBarHeight)];
        //_navigationBarView.backgroundColor = MainColor;
        _navigationBarView.dk_backgroundColorPicker = DKColorPickerWithKey(NavigationBarColor);
    }
    return _navigationBarView;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *normalImage = [UIImage imageNamed:@"nav_item_game_icon_20x20_"];
        UIImage *hightImage = [UIImage imageNamed:@"nav_item_game_click_icon_20x20_"];
        [_leftButton setImage:normalImage forState:UIControlStateNormal];
        [_leftButton setImage:hightImage forState:UIControlStateHighlighted];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *normalImage = [UIImage imageNamed:@"RandomAcrossClickN_20x16_"];
        UIImage *hightImage = [UIImage imageNamed:@"RandomAcrossN_20x16_"];
        [_rightButton setImage:normalImage forState:UIControlStateNormal];
        [_rightButton setImage:hightImage forState:UIControlStateHighlighted];
    }
    return _rightButton;
}

- (UIImageView *)titleView{
    if (!_titleView) {
        _titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle_107x19_"]];
    }
    return _titleView;
}

@end
