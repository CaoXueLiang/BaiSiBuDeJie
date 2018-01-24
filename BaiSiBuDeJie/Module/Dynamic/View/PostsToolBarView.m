//
//  PostsToolBarView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsToolBarView.h"
#import "PostsModel.h"
#import "UIButton+Aliment.h"

@interface PostsToolBarView()
@property (nonatomic,strong) UIButton *upButton;         //顶按钮
@property (nonatomic,strong) UIButton *downButton;       //踩按钮
@property (nonatomic,strong) UIButton *transpondButton;  //转发按钮
@property (nonatomic,strong) UIButton *commentButton;    //评论按钮
@end

@implementation PostsToolBarView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = KWBCellToobarHeight;
    }
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _upButton.size = CGSizeMake(CGFloatPixelRound(self.width / 4.0), self.height);
    [_upButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    [_upButton setImage:[UIImage imageNamed:@"mainCellDing_17x17_"] forState:UIControlStateNormal];
    [_upButton setImage:[UIImage imageNamed:@"mainCellDingClick_17x17_"] forState:UIControlStateHighlighted];
    [_upButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_upButton setTitleColor:MainColor forState:UIControlStateHighlighted];
    _upButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_upButton addTarget:self action:@selector(upButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _downButton.size = CGSizeMake(CGFloatPixelRound(self.width / 4.0), self.height);
    _downButton.left = CGFloatPixelRound(self.width / 4.0);
    [_downButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    [_downButton setImage:[UIImage imageNamed:@"mainCellCai_17x17_"] forState:UIControlStateNormal];
    [_downButton setImage:[UIImage imageNamed:@"mainCellCaiClick_17x17_"] forState:UIControlStateHighlighted];
    [_downButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_downButton setTitleColor:MainColor forState:UIControlStateHighlighted];
    _downButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_downButton addTarget:self action:@selector(downButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _transpondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _transpondButton.size = CGSizeMake(CGFloatPixelRound(self.width / 4.0), self.height);
    _transpondButton.left = CGFloatPixelRound(self.width / 4.0 * 2.0);
    [_transpondButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    [_transpondButton setImage:[UIImage imageNamed:@"mainCellShare_17x17_"] forState:UIControlStateNormal];
    [_transpondButton setImage:[UIImage imageNamed:@"mainCellShareClick_17x17_"] forState:UIControlStateHighlighted];
    [_transpondButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_transpondButton setTitleColor:MainColor forState:UIControlStateHighlighted];
    _transpondButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_transpondButton addTarget:self action:@selector(transpondButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentButton.size = CGSizeMake(CGFloatPixelRound(self.width / 4.0), self.height);
    _commentButton.left = CGFloatPixelRound(self.width / 4.0 * 3.0);
    [_commentButton setBackgroundImage:[UIImage imageWithColor:kWBCellHighlightColor] forState:UIControlStateHighlighted];
    [_commentButton setImage:[UIImage imageNamed:@"mainCellComment_17x17_"] forState:UIControlStateNormal];
    [_commentButton setImage:[UIImage imageNamed:@"mainCellCommentClick_17x17_"] forState:UIControlStateHighlighted];
    [_commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_commentButton setTitleColor:MainColor forState:UIControlStateHighlighted];
    _commentButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_commentButton addTarget:self action:@selector(commentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.upButton];
    [self addSubview:self.downButton];
    [self addSubview:self.transpondButton];
    [self addSubview:self.commentButton];
    [_upButton layoutImageTitleHorizontalOffSet:5];
    [_downButton layoutImageTitleHorizontalOffSet:5];
    [_transpondButton layoutImageTitleHorizontalOffSet:5];
    [_commentButton layoutImageTitleHorizontalOffSet:5];
}

#pragma mark - Event Response
- (void)upButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickedUpButton)]) {
        [self.delegate didClickedUpButton];
    }
}

- (void)downButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickedDownButton)]) {
        [self.delegate didClickedDownButton];
    }
}

- (void)transpondButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickedShareButton)]) {
        [self.delegate didClickedShareButton];
    }
}

- (void)commentButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickedCommentButton)]) {
        [self.delegate didClickedCommentButton];
    }
}

#pragma mark - Public Menthod
- (void)setModel:(PostsModel *)model{
    NSString *up = model.up.integerValue ? model.up : @"顶";
    NSString *down = model.down.integerValue ? model.down : @"踩";
    NSString *share = model.forward.integerValue ? model.forward : @"转发";
    NSString *comment = model.comment.integerValue ? model.comment : @"评论";
    [_upButton setTitle:up forState:UIControlStateNormal];
    [_downButton setTitle:down forState:UIControlStateNormal];
    [_transpondButton setTitle:share forState:UIControlStateNormal];
    [_commentButton setTitle:comment forState:UIControlStateNormal];
    
    UIImage *normalUpImage = model.isUp ? [UIImage imageNamed:@"mainCellDingClick_17x17_"] : [UIImage imageNamed:@"mainCellDing_17x17_"];
    UIImage *normalDownImage = model.isDown ? [UIImage imageNamed:@"mainCellCaiClick_17x17_"] : [UIImage imageNamed:@"mainCellCai_17x17_"];
    UIColor *normalUpColor = model.isUp ? MainColor : [UIColor lightGrayColor];
    UIColor *normalDownColor = model.isDown ? MainColor : [UIColor lightGrayColor];
    [_upButton setImage:normalUpImage forState:UIControlStateNormal];
    [_upButton setTitleColor:normalUpColor forState:UIControlStateNormal];
    [_downButton setImage:normalDownImage forState:UIControlStateNormal];
    [_downButton setTitleColor:normalDownColor forState:UIControlStateNormal];
}

@end
