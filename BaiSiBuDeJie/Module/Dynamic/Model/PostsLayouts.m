//
//  PostsLayouts.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/3.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsLayouts.h"
#import "PostsModel.h"
#import <YYText/YYText.h>
#import "PostsCommentCell.h"

@implementation PostsLayouts
#pragma mark - Init Menthod
- (instancetype)initWithModel:(PostsModel *)postsModel{
    if (!postsModel) return nil;
    self = [super init];
    if (self) {
        _postsModel = postsModel;
        [self layout];
    }
    return self;
}

- (void)layout{
    //布局个人信息
    _profileHeight = kWBCellProfileHeight;
    
    //布局文本信息
    [self _layoutText];
    
    //布局图片和视频
    switch (_postsModel.contentType) {
        case postsContentTypeText:{
            _videoHeight = 0;
            _picHeight = 0;
         }break;
        case postsContentTypeImage:{
            _videoHeight = 0;
            /*判断是长图片还是正常图片*/
            if (_postsModel.image.height >= kScreenHeight) {
              _picHeight = 300;
            }else{
              _picHeight = _postsModel.image.height * (kScreenWidth - 2*kWBCellPadding) / _postsModel.image.width;
            }
         }break;
        case postsContentTypeVideo:{
            _picHeight = 0;
            /*当视频高度大于视频宽度时，显示视频缩略图宽度的一般*/
            if (_postsModel.video.height > _postsModel.video.width) {
               _videoHeight = _postsModel.video.height * (kScreenWidth - 2*kWBCellPadding)*0.5 / _postsModel.video.width;
            }else{
               _videoHeight = _postsModel.video.height * (kScreenWidth - 2*kWBCellPadding) / _postsModel.video.width;
            }
         }break;
    }
    
    
    _textTopMargin = _textHeight == 0 ? 0 : 4;
    _picTopMargin = _picHeight >0 ? 8 : 0;
    _videoTopMargin = _videoHeight > 0 ? 8 : 0;
    
    //布局工具条
    _toolbarHeight = KWBCellToobarHeight;
    
    //布局评论视图
    _commentHeight = 0;
    for (PostsCommentModel *model in _postsModel.top_comments) {
        _commentHeight += [PostsCommentCell cellHeightWithModel:model];
    }
    _bottomMargin = _commentHeight == 0 ? 0 : 10;
    
    
    //计算单个cell的总高度
    _totalHeight = 0;
    _totalHeight += _profileHeight;
    _totalHeight += _textHeight;
    _totalHeight += _textTopMargin;
    _totalHeight += _picTopMargin;
    _totalHeight += _videoTopMargin;
    _totalHeight += _isShowExpendButton ? KWBExpendButtonHeight : 0;
    _totalHeight += _picHeight;
    _totalHeight += _videoHeight;
    _totalHeight += _toolbarHeight;
    _totalHeight += _commentHeight;
    _totalHeight += _bottomMargin;
}

- (void)_layoutText{
    _textHeight = 0;
    _textLayout = nil;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:_postsModel.text];
    text.yy_font = [UIFont systemFontOfSize:16];
    text.yy_color = [UIColor blackColor];
    text.yy_lineSpacing = 6;
    if (text.length == 0) return;
    
    /*计算文本的行数,判断显示7行，还是显示完全*/
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kScreenWidth - 2*kWBCellPadding, HUGE);
    YYTextLayout *tmpTextLayout = [YYTextLayout layoutWithContainer:container text:text];
    NSUInteger rowCount = tmpTextLayout.rowCount;
    
    /*判断是否隐藏展开按钮*/
    if (rowCount > 7) {
        _isShowExpendButton = YES;
        //判断展开或者收起状态
        if (_isExpend == NO) {
            container.maximumNumberOfRows = 7;
            _expendButtonTitle = @"全文";
        }else{
            _expendButtonTitle = @"收起";
        }
    }else{
        _isShowExpendButton = NO;
    }
    _textLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_textLayout) return;
    _textHeight = _textLayout.textBoundingSize.height;
}

@end
