//
//  PostsDetailNavigation.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/5.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailNavigation.h"
#import "PostsModel.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface PostsDetailNavigation()
@property (nonatomic,strong) UIView *backView;        //背景图片
@property (nonatomic,strong) UIButton *backButton;    //返回按钮
@property (nonatomic,strong) UIButton *upButton;      //赞按钮
@property (nonatomic,strong) UIButton *downButton;    //踩按钮
@property (nonatomic,strong) UIButton *shareButton;   //分享按钮
@property (nonatomic,strong) UIButton *barrageButton; //弹幕按钮
@property (nonatomic,strong) UIButton *avatarButton;  //头像按钮
@property (nonatomic,strong) UIView *bottomLayer;
@end

@implementation PostsDetailNavigation
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kNavBarHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    _backView = [[UIView alloc]initWithFrame:self.bounds];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    CGFloat buttonWidth = kScreenWidth / 6.0;
    _backButton = [self createButtonWithImage:@"detail_back_icon_20x20_" hightImage:@"detail_back_icon_click_20x20_"];
    _backButton.size = CGSizeMake(buttonWidth, kNavBarHeight);
    _backButton.tag = 1;
    [self addSubview:_backButton];
    
    _upButton = [self createButtonWithImage:@"detail_ding_icon_24x24_" hightImage:@"detail_ding_icon_click_24x24_"];
    _upButton.size = CGSizeMake(buttonWidth, kNavBarHeight);
    _upButton.left = buttonWidth;
    _upButton.tag = 2;
    [self addSubview:_upButton];
    
    _downButton = [self createButtonWithImage:@"detail_cai_icon_24x24_" hightImage:@"detail_cai_icon_click_24x24_"];
    _downButton.size = CGSizeMake(buttonWidth, kNavBarHeight);
    _downButton.left = buttonWidth * 2;
    _downButton.tag = 3;
    [self addSubview:_downButton];
    
    _shareButton = [self createButtonWithImage:@"detail_share_icon_24x24_" hightImage:@"detail_share_icon_click_24x24_"];
    _shareButton.size = CGSizeMake(buttonWidth, kNavBarHeight);
    _shareButton.left = buttonWidth * 3;
    _shareButton.tag = 4;
    [self addSubview:_shareButton];
    
    _barrageButton = [self createButtonWithImage:@"detail_barrage_open_all_24x24_" hightImage:@"detail_barrage_open_all_click_24x24_"];
    _barrageButton.size = CGSizeMake(buttonWidth, kNavBarHeight);
    _barrageButton.left = buttonWidth * 4;
    _barrageButton.tag = 5;
    [self addSubview:_barrageButton];
    
    _avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _avatarButton.layer.cornerRadius = 30/2.0;
    _avatarButton.layer.masksToBounds = YES;
    _avatarButton.size = CGSizeMake(30, 30);
    _avatarButton.left = buttonWidth * 5 + 10;
    _avatarButton.centerY = self.centerY;
    _avatarButton.tag = 6;
    [_avatarButton addTarget:self action:@selector(avatarClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_avatarButton];
    
    _bottomLayer = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, kScreenWidth, 0.5)];
    _bottomLayer.backgroundColor = RGBLINE;
    [self addSubview:_bottomLayer];
}

- (UIButton *)createButtonWithImage:(NSString *)image hightImage:(NSString *)hightImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - Setter Menthod
- (void)setModel:(PostsModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    [_avatarButton sd_setImageWithURL:_model.u.headerArray[0] forState:UIControlStateNormal];
}

#pragma mark - Event Response
- (void)buttonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didClickedButton:)]) {
        [self.delegate didClickedButton:button.tag];
    }
}

- (void)avatarClicked{
    
}

@end

