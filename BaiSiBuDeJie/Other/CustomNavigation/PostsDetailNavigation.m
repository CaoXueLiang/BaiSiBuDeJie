//
//  PostsDetailNavigation.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/5.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailNavigation.h"

@interface PostsDetailNavigation()
@property (nonatomic,strong) UIView *backView;        //背景图片
@property (nonatomic,strong) UIButton *backButton;    //返回按钮
@property (nonatomic,strong) UIButton *upButton;      //赞按钮
@property (nonatomic,strong) UIButton *downButton;    //踩按钮
@property (nonatomic,strong) UIButton *shareButton;   //分享按钮
@property (nonatomic,strong) UIButton *barrageButton; //弹幕按钮
@property (nonatomic,strong) UIButton *avatarButton;  //头像按钮
@end

@implementation PostsDetailNavigation
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
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
    _barrageButton.size = CGSizeMake(buttonWidth, self.height);
    [self addSubview:_backButton];
    
    _upButton = [self createButtonWithImage:@"detail_ding_icon_24x24_" hightImage:@"detail_ding_icon_click_24x24_"];
    _upButton.size = CGSizeMake(buttonWidth, self.height);
    _upButton.left = buttonWidth;
    [self addSubview:_upButton];
    
    _downButton = [self createButtonWithImage:@"detail_cai_icon_24x24_" hightImage:@"detail_cai_icon_click_24x24_"];
    _downButton.size = CGSizeMake(buttonWidth, self.height);
    _downButton.left = buttonWidth * 2;
    [self addSubview:_downButton];
    
    _shareButton = [self createButtonWithImage:@"detail_share_icon_24x24_" hightImage:@"detail_share_icon_click_24x24_"];
    _shareButton.size = CGSizeMake(buttonWidth, self.height);
    _shareButton.left = buttonWidth * 3;
    [self addSubview:_shareButton];
    
    _barrageButton = [self createButtonWithImage:@"detail_barrage_open_all_24x24_" hightImage:@"detail_barrage_open_all_click_24x24_"];
    _barrageButton.size = CGSizeMake(buttonWidth, self.height);
    _barrageButton.left = buttonWidth * 4;
    [self addSubview:_barrageButton];
    
    _avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _avatarButton.layer.cornerRadius = 40/2.0;
    _avatarButton.layer.masksToBounds = YES;
    _avatarButton.size = CGSizeMake(buttonWidth, self.height);
    _avatarButton.left = buttonWidth * 5;
    [_avatarButton addTarget:self action:@selector(avatarClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_avatarButton];
}

- (UIButton *)createButtonWithImage:(NSString *)image hightImage:(NSString *)hightImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - Event Response
- (void)buttonClicked:(UIButton *)button{
    
}

- (void)avatarClicked{
    
}

@end

