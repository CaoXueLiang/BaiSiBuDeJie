//
//  PostsVideoView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsVideoView.h"
#import "PostsModel.h"

@interface PostsVideoView()
@property (nonatomic,strong) UIImageView *thumbnailView;   //视频缩略图
@property (nonatomic,strong) UIImageView *startImageView;  //开始按钮
@property (nonatomic,strong) UILabel *playCountLabel;      //播放次数
@property (nonatomic,strong) UILabel *durationLabel;       //视频时长
@property (nonatomic,strong) CAGradientLayer *shadowLayer; //黑色渐变
@end

@implementation PostsVideoView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    _shadowLayer = [CAGradientLayer layer];
    _shadowLayer.frame = CGRectMake(kWBCellPadding, 0, kScreenWidth - 2*kWBCellPadding, 40);
    _shadowLayer.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0].CGColor,
                            (__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.4].CGColor];
    [self.layer addSublayer:_shadowLayer];
    
    _thumbnailView = [UIImageView new];
    _thumbnailView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_thumbnailView];
    [_thumbnailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWBCellPadding);
        make.right.equalTo(self).offset(-kWBCellPadding);
        make.top.bottom.equalTo(self);
    }];
    
    _startImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"capture_pre_play_normal_90x90_"]];
    [_thumbnailView addSubview:_startImageView];
    [_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.center.equalTo(_thumbnailView);
    }];
    
    _playCountLabel = [UILabel new];
    _playCountLabel.font = [UIFont systemFontOfSize:13];
    _playCountLabel.textColor = [UIColor whiteColor];
    [_thumbnailView addSubview:_playCountLabel];
    [_playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_thumbnailView).offset(4);
        make.bottom.equalTo(_thumbnailView).offset(-4);
        make.height.mas_equalTo(20);
    }];
    
    _durationLabel = [UILabel new];
    _durationLabel.font = [UIFont systemFontOfSize:13];
    _durationLabel.textColor = [UIColor whiteColor];
    [_thumbnailView addSubview:_durationLabel];
    [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_thumbnailView).offset(-4);
        make.right.equalTo(_thumbnailView).offset(-4);
        make.height.mas_equalTo(20);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _shadowLayer.bottom = _thumbnailView.bottom;
}

#pragma mark - Public Menthod
- (void)setModel:(PostsModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    PostsVideoModel *videoModel = model.video;
    [_thumbnailView  sd_setImageWithURL:[NSURL URLWithString:videoModel.thumbnailArray[0]] placeholderImage:[UIImage imageNamed:@"post_placeholderImageN_145x30_"]];
    _playCountLabel.text = [NSString stringWithFormat:@"%ld播放",(long)videoModel.playcount];
    _durationLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", videoModel.duration / 60, videoModel.duration % 60];
}

@end

