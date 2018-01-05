//
//  PostsPublishView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/4.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsPublishView.h"
#import "UIButton+Aliment.h"

@interface PostsPublishView()
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIImageView *titleImageView;
@property (nonatomic,strong) UIButton *videpButton;
@property (nonatomic,strong) UIButton *picButton;
@property (nonatomic,strong) UIButton *jokeButton;
@property (nonatomic,strong) UIButton *voiceButton;
@property (nonatomic,strong) UIButton *linkButton;
@property (nonatomic,strong) UIButton *ablumButton;
@property (nonatomic,strong) UIButton *cancleButton;
@end

@implementation PostsPublishView
#pragma mark - Init Menthod
- (instancetype)initWithDoneBlock:(void(^)(NSString *itermString))block{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _doneBlock = block;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.backImageView];
    self.backImageView.frame = self.bounds;
    
    [self addSubview:self.titleImageView];
    self.titleImageView.top = 100;
    self.titleImageView.centerX = self.centerX;
    
    [self addSubview:self.cancleButton];
    self.cancleButton.frame = CGRectMake(0, 0, kScreenWidth, 45);
    self.cancleButton.bottom = self.bottom;
    
    _videpButton = [self createButtonWithImage:@"publish-video_75x75_" title:@"发视频"];
    _picButton = [self createButtonWithImage:@"publish-picture_75x75_" title:@"发图片"];
    _jokeButton = [self createButtonWithImage:@"publish-text_75x75_" title:@"发段子"];
    _voiceButton = [self createButtonWithImage:@"publish-audio_75x75_" title:@"发声音"];
    _linkButton = [self createButtonWithImage:@"publish-link_75x75_" title:@"发链接"];
    _ablumButton = [self createButtonWithImage:@"publish-review_75x75_" title:@"音乐相册"];
    
    [self addSubview:_videpButton];
    [self addSubview:_picButton];
    [self addSubview:_jokeButton];
    [self addSubview:_voiceButton];
    [self addSubview:_linkButton];
    [self addSubview:_ablumButton];
    
    _videpButton.centerX = kScreenWidth / 6.0;
    _voiceButton.centerX = kScreenWidth / 6.0;
    _picButton.centerX = kScreenWidth / 2.0;
    _linkButton.centerX = kScreenWidth / 2.0;
    _jokeButton.centerX = kScreenWidth / 6.0 *5;
    _ablumButton.centerX = kScreenWidth / 6.0 *5;
    
    _videpButton.centerY = - 100;
    _voiceButton.centerY = - 100;
    _picButton.centerY = - 100;
    _linkButton.centerY = - 100;
    _jokeButton.centerY = - 100;
    _ablumButton.centerY = - 100;
    _titleImageView.top = -100;
}

- (UIButton *)createButtonWithImage:(NSString *)imageName title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    [button layoutImageTitleVerticalOffSet:12];
    return button;
}

#pragma mark - Event Response
- (void)buttonClicked:(UIButton *)button{
    NSString *titleString = [button titleForState:UIControlStateNormal];
    [self dismiss];
    if (_doneBlock) {
        _doneBlock(titleString);
    }
}

- (void)dismiss{
    CGFloat finalDistance = kScreenHeight + 100;
    for (int i = 0; i < 6; i++) {
        [UIView animateWithDuration:0.5 delay:i *0.1 usingSpringWithDamping:0.8 initialSpringVelocity:12 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (i == 0) {
                _linkButton.centerY = finalDistance;
                _cancleButton.top = finalDistance;
            }else if (i == 1){
                _ablumButton.centerY = finalDistance;
            }else if (i == 2){
                _voiceButton.centerY = finalDistance;
            }else if (i == 3){
                _picButton.centerY = finalDistance;
            }else if (i == 4){
                _jokeButton.centerY = finalDistance;
            }else if (i == 5){
                _videpButton.centerY = finalDistance;
                _titleImageView.top = finalDistance;
                self.alpha = 0;
            }
        } completion:^(BOOL finished) {
            if (i == 5) {
                [self removeFromSuperview];
            }
        }];
    }
}

- (void)showPickerView{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGFloat topCenterY = kScreenHeight / 2.0 - 70;
    CGFloat bottomCneterY = kScreenHeight / 2.0 + 70;
    
    for (int i = 0; i < 6; i++) {
        [UIView animateWithDuration:0.5 delay:i *0.1 usingSpringWithDamping:0.8 initialSpringVelocity:12 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (i == 0) {
                _linkButton.centerY = bottomCneterY;
            }else if (i == 1){
                _ablumButton.centerY = bottomCneterY;
            }else if (i == 2){
                _voiceButton.centerY = bottomCneterY;
            }else if (i == 3){
                _picButton.centerY = topCenterY;
            }else if (i == 4){
                _jokeButton.centerY = topCenterY;
            }else if (i == 5){
                _videpButton.centerY = topCenterY;
                _titleImageView.top = 90;
            }
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - Setter && Getter
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shareBottomBackground_320x343_"]];
    }
    return _backImageView;
}

- (UIImageView *)titleImageView{
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan_245x25_"]];
    }
    return _titleImageView;
}

- (UIButton *)cancleButton{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancleButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f8f8f8"]] forState:UIControlStateNormal];
        [_cancleButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"f8f8f8"]] forState:UIControlStateHighlighted];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancleButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

@end

