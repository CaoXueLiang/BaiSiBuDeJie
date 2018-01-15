//
//  PostsDetailHeaderView.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/14.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailHeaderView.h"
#import "PostsDetailHeaderLayout.h"
#import "PostsProfileView.h"
#import "PostsToolBarView.h"
#import "PostsDetailImageView.h"
#import "PostsDetailVideoView.h"
#import <YYText/YYText.h>
#import "PostsModel.h"

@interface PostsDetailHeaderView()
@property (nonatomic,strong) PostsProfileView *profileView;
@property (nonatomic,strong) PostsToolBarView *toolBarView;
@property (nonatomic,strong) YYLabel *contentLabel;
@property (nonatomic,strong) PostsDetailImageView *detailImageView;
@property (nonatomic,strong) PostsDetailVideoView *videoView;
@property (nonatomic,strong) UILabel *publishLabel;
@end

@implementation PostsDetailHeaderView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    _profileView = [PostsProfileView new];
    [self addSubview:_profileView];
    
    _toolBarView = [PostsToolBarView new];
    [self addSubview:_toolBarView];
    
    _detailImageView = [PostsDetailImageView new];
    [self addSubview:_detailImageView];
    
    _videoView = [PostsDetailVideoView new];
    [self addSubview:_videoView];
    
    _publishLabel = [UILabel new];
    _publishLabel.textColor = MainGrayTextColor;
    _publishLabel.font = [UIFont systemFontOfSize:14];
    _publishLabel.left = kWBCellPadding;
    _publishLabel.size = CGSizeMake(kScreenWidth - 2*kWBCellPadding, 40);
    [self addSubview:_publishLabel];
    
    _contentLabel = [YYLabel new];
    _contentLabel.userInteractionEnabled = NO;
    _contentLabel.left = kWBCellPadding;
    _contentLabel.width = kScreenWidth - 2*kWBCellPadding;
    _contentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _contentLabel.displaysAsynchronously = NO;
    _contentLabel.ignoreCommonProperties = YES;
    _contentLabel.fadeOnAsynchronouslyDisplay = NO;
    _contentLabel.fadeOnHighlight = NO;
    [self addSubview:_contentLabel];
}

#pragma mark - Public Menthod
- (void)setLayout:(PostsDetailHeaderLayout *)layout{
    PostsModel *postModel = layout.postsModel;
    /*下面进行布局*/
    CGFloat top = 0;
    self.height = layout.totalHeight;
    _profileView.hidden = !layout.profileHeight;
    
    top += layout.profileHeight;
    _detailImageView.height = layout.picHeight;
    _detailImageView.hidden = !layout.picHeight;
    
    top += layout.picHeight;
    _videoView.height = layout.videoHeight;
    _videoView.hidden = !layout.videoHeight;
    
    
    top += layout.videoHeight;
    top += layout.textTopMargin;
    _contentLabel.top = top;
    _contentLabel.height = layout.textHeight;
    top += layout.textBottomMargin;
    
    top += layout.textHeight;
    _toolBarView.top = top;
    _toolBarView.hidden = !layout.toolbarHeight;
    
    top += layout.toolbarHeight;
    _publishLabel.top = top;
    _publishLabel.height = layout.praiseAndPublicHeight;
    _publishLabel.hidden = !layout.praiseAndPublicHeight;
    
    /*下面是赋值*/
    _profileView.model = postModel;
    _detailImageView.postsModel = postModel;
    _videoView.postsModel = postModel;
    _contentLabel.textLayout = layout.textLayout;
    _toolBarView.model = postModel;
    _publishLabel.text = [NSString stringWithFormat:@"%@赞 • %@",postModel.up,postModel.passtime];
}

@end
