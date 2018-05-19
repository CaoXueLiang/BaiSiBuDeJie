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

@interface PostsCell()<PostsToolBarViewDelegate,PostsProfileViewDelegate>
@property (nonatomic,strong) PostsVideoView *videoView;
@property (nonatomic,strong) PostsImageView *postsImageView;
@property (nonatomic,strong) PostsCommentView *commentView;
@property (nonatomic,strong) YYLabel *contentLabel;  //帖子内容
@property (nonatomic,strong) UIButton *expendButton; //展开按钮
@property (nonatomic,strong) UILabel *animationLabel;//+1Label
@property (nonatomic,assign) BOOL labelIsAnimation;
@end

@implementation PostsCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.dk_backgroundColorPicker = DKColorPickerWithKey(CellBG);
    }
    return self;
}

- (void)addSubViews{
    _profileView = [PostsProfileView new];
    _profileView.delegate = self;
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
    _animationLabel.font = [UIFont systemFontOfSize:30];
    _animationLabel.textColor = [UIColor orangeColor];
    _animationLabel.hidden = YES;
    [_animationLabel sizeToFit];
    [self.contentView addSubview:_animationLabel];
}

#pragma mark - PostsProfileViewDelegate
- (void)didClickUser{
    if ([self.delegate respondsToSelector:@selector(didClickedUser:)]) {
        [self.delegate didClickedUser:_selectIndex];
    }
}

#pragma mark - PostsToolBarViewDelegate
- (void)didClickedUpButton{
    if ([self.delegate respondsToSelector:@selector(didClickedUpButon:)]) {
        [self.delegate didClickedUpButon:_selectIndex];
    }
}

- (void)didClickedDownButton{
    if ([self.delegate respondsToSelector:@selector(didClickedDownButton:)]) {
        [self.delegate didClickedDownButton:_selectIndex];
    }
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

- (void)startAnimationLabelIsUp:(BOOL)isUp{
    _animationLabel.left = isUp ? kScreenWidth/8.0 : kScreenWidth/8.0 *3.0;
    _animationLabel.top = _toolbarView.top - _animationLabel.height + 10;
    _animationLabel.transform = CGAffineTransformIdentity;
    _animationLabel.hidden = NO;
    _animationLabel.alpha = 1;
}

- (void)endAnimationLabelIsUp:(BOOL)isUp{
    _animationLabel.left = isUp ? kScreenWidth/8.0 + 10 : kScreenWidth/8.0 *3.0 + 10;
    _animationLabel.top = _toolbarView.top - _animationLabel.height - 10;
    _animationLabel.alpha = 0;
    _animationLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
    _labelIsAnimation = YES;
}

- (void)upButtonAnimation{
    if (_labelIsAnimation) {
        return;
    }
    [self startAnimationLabelIsUp:YES];
    [UIView animateWithDuration:0.8 animations:^{
        [self endAnimationLabelIsUp:YES];
    } completion:^(BOOL finished) {
        _animationLabel.hidden = YES;
        _labelIsAnimation = NO;
    }];
}

- (void)downButtonAnimation{
    if (_labelIsAnimation) {
        return;
    }
    [self startAnimationLabelIsUp:NO];
    [UIView animateWithDuration:0.8 animations:^{
        [self endAnimationLabelIsUp:NO];
    } completion:^(BOOL finished) {
        _animationLabel.hidden = YES;
        _labelIsAnimation = NO;
    }];
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
