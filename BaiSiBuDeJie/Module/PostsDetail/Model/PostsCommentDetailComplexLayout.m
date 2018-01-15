//
//  PostsCommentDetailComplexLayout.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/15.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsCommentDetailComplexLayout.h"
#import "PostsDetailCommentModel.h"
#import <YYText/YYText.h>
#import "PostsCommentDetailNormalLayout.h"

@implementation PostsCommentDetailComplexLayout
#pragma mark - Init Menthod
- (instancetype)initWithModel:(PostsDetailCommentModel *)commentModel{
    if (!commentModel) return nil;
    self = [super init];
    if (self) {
        _commentModel = commentModel;
        [self layout];
    }
    return self;
}

- (void)layout{
    _topMargin = 8;
    _nickNameHeight = 35;
    [self p_layoutText];
    [self p_layoutNextComment];
    _textTopMargin = _textHeight > 0 ? 8 : 0;
    
    switch (_commentModel.commentType) {
        case postsCommentTypeText:{
            _picHeight = 0;
            _videoHeight = 0;
            _audioHeight = 0;
        } break;
        case postsCommentTypeImage:{
            _videoHeight = 0;
            _audioHeight = 0;
            _picHeight = KWBDetailCommentImageHeight;
        } break;
        case postsCommentTypeVideo:{
            _picHeight = 0;
            _audioHeight = 0;
            _videoHeight = KWBDetailCommentVideoHeight;
        } break;
        case postsCommentTypeAudio:{
            _picHeight = 0;
            _videoHeight = 0;
            _audioHeight = KWBDetailCommentAudioHeight;
        } break;
    }
    
    _picTopMargin = _picHeight > 0 ? 8 : 0;
    _videoTopMargin = _videoHeight > 0 ? 8 : 0;
    _audioTopMargin = _audioHeight > 0 ? 8 : 0;
    _bottomMargin = 8;
    
    _totalHeight += _topMargin;
    _totalHeight += _nickNameHeight;
    _totalHeight += _textTopMargin;
    _totalHeight += _textHeight;
    _totalHeight += _picTopMargin;
    _totalHeight += _picHeight;
    _totalHeight += _videoTopMargin;
    _totalHeight += _videoHeight;
    _totalHeight += _audioTopMargin;
    _totalHeight += _audioHeight;
    _totalHeight += _bottomMargin;
    _totalHeight += _nextCommentTopMargin;
    _totalHeight += _allNextCommentHeight;
}

- (void)p_layoutText{
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc]initWithString:_commentModel.content];
    commentString.yy_lineSpacing = 6;
    commentString.yy_color = [UIColor blackColor];
    commentString.yy_font = [UIFont systemFontOfSize:15];
    _textLayout = [YYTextLayout layoutWithContainerSize:CGSizeMake(KWBCommentNormalWidth - 30 - 2*kWBCellPaddingText, HUGE) text:commentString];
    _textHeight = _textLayout.textBoundingSize.height;
}

- (void)p_layoutNextComment{
    _allNextCommentHeight = 0;
    for (PostsDetailCommentModel *model in _commentModel.precmtsArray) {
        PostsCommentDetailNormalLayout *layout = [[PostsCommentDetailNormalLayout alloc]initWithModel:model];
        _allNextCommentHeight += layout.totalHeight;
    }
    _nextCommentTopMargin = _allNextCommentHeight > 0 ? 8 : 0;
}

@end
