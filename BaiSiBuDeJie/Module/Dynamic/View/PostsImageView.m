//
//  PostsImageView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsImageView.h"
#import "DALabeledCircularProgressView.h"

@interface PostsImageView()
@property (nonatomic,strong) UIImageView *thumbnailView;
@property (nonatomic,strong) UIImageView *typeGifView;
@property (nonatomic,strong) UIImageView *placeHolderView;
@property (nonatomic,strong) UIButton *checkBigButton;
@property (nonatomic,strong) DALabeledCircularProgressView *progressView;
@end

@implementation PostsImageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addsubViews];
    }
    return self;
}

- (void)addsubViews{
    _thumbnailView = [UIImageView new];
    _thumbnailView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_thumbnailView];
    [_thumbnailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(kWBCellPadding);
        make.right.equalTo(self).offset(-kWBCellPadding);
    }];
    
    _typeGifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common-gif"]];
    [self addSubview:_typeGifView];
    [_typeGifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(31, 31));
        make.left.equalTo(_thumbnailView.mas_left);
        make.top.equalTo(self);
    }];
    
    _placeHolderView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imageBackground_75x15_"]];
    [self addSubview:_placeHolderView];
    [_placeHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    
    _progressView = [[DALabeledCircularProgressView alloc] init];
    _progressView.roundedCorners = YES;
    [self addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerY.equalTo(self);
    }];
    
    
    _checkBigButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkBigButton setBackgroundImage:[UIImage imageNamed:@"see-big-picture-background_285x43_"] forState:UIControlStateNormal];
    [_checkBigButton setImage:[UIImage imageNamed:@"see-big-picture_19x19_"] forState:UIControlStateNormal];
    [_checkBigButton setTitle:@"点击查看大图" forState:UIControlStateNormal];
    [_checkBigButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _checkBigButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_checkBigButton];
    [_checkBigButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(60);
    }];
}

@end

