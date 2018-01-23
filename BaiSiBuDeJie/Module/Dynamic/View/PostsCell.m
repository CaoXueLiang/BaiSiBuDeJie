//
//  PostsCell.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsCell.h"
#import "PostsProfileView.h"
#import "PostsVideoView.h"
#import "PostsImageView.h"
#import "PostsToolBarView.h"
#import "PostsCommentView.h"
#import <YYText/YYText.h>
#import "PostsLayouts.h"
#import "PostsModel.h"

@interface PostsCell()<PostsToolBarViewDelegate>
@property (nonatomic,strong) PostsProfileView *profileView;
@property (nonatomic,strong) PostsVideoView *videoView;
@property (nonatomic,strong) PostsImageView *postsImageView;
@property (nonatomic,strong) PostsToolBarView *toolbarView;
@property (nonatomic,strong) PostsCommentView *commentView;
@property (nonatomic,strong) YYLabel *contentLabel;  //帖子内容
@property (nonatomic,strong) UIButton *expendButton; //展开按钮
@property (nonatomic,strong) UILabel *animationLabel;//+1Label
@end

@implementation PostsCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)addSubViews{
    _profileView = [PostsProfileView new];
    [self.contentView addSubview:_profileView];
    
    _videoView = [PostsVideoView new];
    [self.contentView addSubview:_videoView];
    
    _postsImageView = [PostsImageView new];
    [self.contentView addSubview:_postsImageView];
    
    _toolbarView = [PostsToolBarView new];
    _toolbarView.delegate = self;
    [self.contentView addSubview:_toolbarView];
    
    _commentView = [PostsCommentView new];
    [self.contentView addSubview:_commentView];
    
    _contentLabel = [YYLabel new];
    _contentLabel.userInteractionEnabled = NO;
    _contentLabel.left = kWBCellPadding;
    _contentLabel.width = kScreenWidth - 2*kWBCellPadding;
    _contentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _contentLabel.displaysAsynchronously = NO;
    _contentLabel.ignoreCommonProperties = YES;
    _contentLabel.fadeOnAsynchronouslyDisplay = NO;
    _contentLabel.fadeOnHighlight = NO;
    [self.contentView addSubview:_contentLabel];
    
    _expendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _expendButton.size = CGSizeMake(KWBExpendButtonWidth, KWBExpendButtonHeight);
    _expendButton.left = kWBCellPadding;
    [_expendButton setTitleColor:MainNameColor forState:UIControlStateNormal];
    _expendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_expendButton addTarget:self action:@selector(expendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_expendButton];
    
    _animationLabel = [UILabel new];
    _animationLabel.text = @"+ 1";
    _animationLabel.font = [UIFont systemFontOfSize:17];
    _animationLabel.textColor = MainColor;
    _animationLabel.hidden = YES;
    _animationLabel.left = kScreenWidth/4.0 - 40;
    _animationLabel.size = CGSizeMake(70, 30);
    [self.contentView addSubview:_animationLabel];
}

#pragma mark - PostsToolBarViewDelegate
- (void)didClickedUpButton{
    
}

- (void)didClickedDownButton{
    
}

- (void)didClickedShareButton{
    
}

- (void)didClickedCommentButton{
    
}

#pragma mark - Event Response
- (void)expendButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickedExpendButton:)]) {
        [self.delegate didClickedExpendButton:_selectIndex];
    }
}

- (void)upButtonAnimation{
    
}

- (void)downButtonAnimation{
    
}

#pragma mark - Public Menthod
- (void)setLayout:(PostsLayouts *)layout{
    if (!layout) {
        return;
    }
    _layout = layout;
    
    /*进行布局*/
    CGFloat top = 0;
    top += kWBCellProfileHeight;
    top += layout.textTopMargin;
    _contentLabel.height = layout.textHeight;
    _contentLabel.textLayout = layout.textLayout;
    _contentLabel.top = top;
    top += layout.textHeight;
    
    if (layout.isShowExpendButton) {
        _expendButton.top = top;
        top += KWBExpendButtonHeight;
    }
    
    top += layout.videoTopMargin;
    _videoView.height = layout.videoHeight;
    _videoView.top = top;
    _videoView.hidden = layout.videoHeight == 0 ? YES : NO;
    top += layout.videoHeight;
    
    top += layout.picTopMargin;
    _postsImageView.height = layout.picHeight;
    _postsImageView.top = top;
    _postsImageView.hidden = layout.picHeight == 0 ? YES : NO;
    top += layout.picHeight;
    
    _toolbarView.top = top;
    _animationLabel.top = top - _animationLabel.height;
    top += KWBCellToobarHeight;
    
    _commentView.height = layout.commentHeight;
    _commentView.top = top;
    _commentView.hidden = layout.commentHeight == 0 ? YES :NO;
    
    /*进行赋值*/
    PostsModel *postsModel = layout.postsModel;
    _profileView.model = postsModel;
    _videoView.model = postsModel;
    _postsImageView.model = postsModel;
    _toolbarView.model = postsModel;
    _commentView.commentArray = postsModel.top_comments;
    [_expendButton setTitle:layout.expendButtonTitle forState:UIControlStateNormal];
}

@end
