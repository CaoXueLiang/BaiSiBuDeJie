//
//  PostsDetailHeaderLayout.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/13.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailHeaderLayout.h"
#import "PostsModel.h"
#import <YYText/YYText.h>

@implementation PostsDetailHeaderLayout
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
    _profileHeight = _postsModel.contentType == postsContentTypeText ? kWBCellProfileHeight : 0;
    
    //布局文本信息
    [self _layoutText];
    _textTopMargin = _textHeight == 0 ? 0 : 5;
    _textBottomMargin = _textHeight == 0 ? 0 : 5;
    
    //布局图片和视频
    switch (_postsModel.contentType) {
        case postsContentTypeText:{
            _videoHeight = 0;
            _picHeight = 0;
            _praiseAndPublicHeight = 0;
        }break;
        case postsContentTypeImage:{
            _videoHeight = 0;
            _praiseAndPublicHeight = 40.0f;
            _picHeight = _postsModel.image.height * kScreenWidth / _postsModel.image.width;
        }break;
        case postsContentTypeVideo:{
            _picHeight = 0;
            _praiseAndPublicHeight = 40.0f;
            _videoHeight = MIN(_postsModel.video.height * kScreenWidth / _postsModel.video.width, kScreenHeight);
        }break;
    }
    
    //布局工具条
    _toolbarHeight = _postsModel.contentType == postsContentTypeText ? KWBCellToobarHeight : 0;

    //计算单个cell的总高度
    _totalHeight = 0;
    _totalHeight += _profileHeight;
    _totalHeight += _textHeight;
    _totalHeight += _textTopMargin;
    _totalHeight += _textBottomMargin;
    _totalHeight += _picHeight;
    _totalHeight += _videoHeight;
    _totalHeight += _toolbarHeight;
    _totalHeight += _praiseAndPublicHeight;
}

- (void)_layoutText{
    _textHeight = 0;
    _textLayout = nil;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:_postsModel.text];
    text.yy_font = [UIFont systemFontOfSize:16];
    text.yy_color = [UIColor blackColor];
    text.yy_lineSpacing = 6;
    if (text.length == 0) return;
    
    /*段子详情，将文字显示完全*/
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kScreenWidth - 2*kWBCellPadding, HUGE);
    _textLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_textLayout) return;
    _textHeight = _textLayout.textBoundingSize.height;
}

@end
