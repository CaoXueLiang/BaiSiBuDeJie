//
//  PostsDetailVideoView.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/14.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZFPlayer.h"
#import "PostsModel.h"

@interface PostsDetailVideoView()<ZFPlayerDelegate>
/** 离开页面时候是否在播放 */
@property (nonatomic,assign) BOOL isPlaying;
@property (nonatomic,strong) UIView *fatherView;
@property (nonatomic,strong) ZFPlayerView *playerView;
@property (nonatomic,strong) ZFPlayerModel *playerModel;
@end

@implementation PostsDetailVideoView
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
    _fatherView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:_fatherView];
    [_fatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - ZFPlayerDelegate
- (void)zf_playerBackAction {
    
}

- (void)zf_playerDownload:(NSString *)url {
    
}

- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen {

}

- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    
}

#pragma mark - Setter && Getter
- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel = [[ZFPlayerModel alloc] init];
        _playerModel.title = @"这里设置视频标题";
        _playerModel.fatherView = _fatherView;
    }
    return _playerModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        [_playerView playerControlView:nil playerModel:self.playerModel];
        _playerView.delegate = self;
        //设置视频的填充模式
        _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
        //打开预览图
        _playerView.hasPreviewView = YES;
        
    }
    return _playerView;
}

- (void)setPostsModel:(PostsModel *)postsModel{
    if (!postsModel) return;
    NSURL *videoURL = [NSURL URLWithString:postsModel.video.videoArray[0]];
    self.playerModel.videoURL = videoURL;
    self.playerModel.placeholderImageURLString = postsModel.video.thumbnailArray[0];
    self.playerModel.placeholderImage = [UIImage imageNamed:@"post_placeholderImage_145x30_"];
    //自动播放，默认不自动播放
    [self.playerView autoPlayTheVideo];
}

@end
