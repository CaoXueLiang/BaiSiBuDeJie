//
//  PostsCommentDetailComplexLayout.h
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/15.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 评论ComplexCell布局
 */
@class PostsDetailCommentModel,YYTextLayout;
@interface PostsCommentDetailComplexLayout : NSObject
- (instancetype)initWithModel:(PostsDetailCommentModel *)commentModel;
- (void)layout;

/*------------------👇下面是数据------------------*/
//一个帖子的总数据
@property (nonatomic,strong) PostsDetailCommentModel *commentModel;



/*------------------👇下面是布局结果------------------*/
//评论上方留白
@property (nonatomic,assign) CGFloat topMargin;
//昵称高度
@property (nonatomic,assign) CGFloat nickNameHeight;
//嵌套评论上方留白
@property (nonatomic,assign) CGFloat nextCommentTopMargin;
//所有嵌套评论的高度
@property (nonatomic,assign) CGFloat allNextCommentHeight;
//文本上方留白
@property (nonatomic,assign) CGFloat textTopMargin;
//文本高度
@property (nonatomic,assign) CGFloat textHeight;
//文本布局
@property (nonatomic,strong) YYTextLayout *textLayout;
//图片上方留白
@property (nonatomic,assign) CGFloat picTopMargin;
//图片高度
@property (nonatomic,assign) CGFloat picHeight;
//视频上方留白
@property (nonatomic,assign) CGFloat videoTopMargin;
//视频高度
@property (nonatomic,assign) CGFloat videoHeight;
//语音上方留白
@property (nonatomic,assign) CGFloat audioTopMargin;
//语音的高度
@property (nonatomic,assign) CGFloat audioHeight;
//底部留白
@property (nonatomic,assign) CGFloat bottomMargin;
//评论总高度
@property (nonatomic,assign) CGFloat totalHeight;

@end
