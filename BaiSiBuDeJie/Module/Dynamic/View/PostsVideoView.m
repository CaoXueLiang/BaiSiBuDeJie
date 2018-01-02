//
//  PostsVideoView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsVideoView.h"

@interface PostsVideoView()
@property (nonatomic,strong) UIImageView *thumbnailView;
@property (nonatomic,strong) UIImageView *startImageView;
@property (nonatomic,strong) UILabel *playCountLabel;
@property (nonatomic,strong) UILabel *durationLabel;
@end

@implementation PostsVideoView
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
    }
    self = [super initWithFrame:frame];
    
    _thumbnailView = [UIImageView new];
    _thumbnailView.origin = CGPointMake(kWBCellPadding, 0);
    _thumbnailView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailView.clipsToBounds = YES;
    [self addSubview:_thumbnailView];
    
    _startImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"capture_pre_play_normal_90x90_"]];
    _startImageView.size = CGSizeMake(90, 90);
    [self addSubview:_startImageView];
    
    _playCountLabel = [UILabel new];
    _playCountLabel.font = [UIFont systemFontOfSize:13];
    _playCountLabel.textColor = [UIColor whiteColor];
    _playCountLabel.left = _thumbnailView.left + kWBCellPadding;
    _playCountLabel.height = 20;
    [self addSubview:_playCountLabel];
    
    _durationLabel = [UILabel new];
    _durationLabel.font = [UIFont systemFontOfSize:13];
    _durationLabel.textColor = [UIColor whiteColor];
    _durationLabel.right = _thumbnailView.right - kWBCellPadding;
    _durationLabel.height = 20;
    [self addSubview:_durationLabel];
    
    return self;
}

@end

