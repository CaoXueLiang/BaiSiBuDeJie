//
//  PostsDetailHeaderLayout.h
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/13.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostsModel,YYTextLayout;
@interface PostsDetailHeaderLayout : NSObject
- (instancetype)initWithModel:(PostsModel *)postsModel;
- (void)layout;

/*------------------👇下面是数据------------------*/
//一个帖子的总数据
@property (nonatomic,strong) PostsModel *postsModel;


/*------------------👇下面是布局结果------------------*/
//个人资料高度（包括留白）
@property (nonatomic,assign) CGFloat profileHeight;
//文本上方留白
@property (nonatomic,assign) CGFloat textTopMargin;
//文本高度
@property (nonatomic,assign) CGFloat textHeight;
//文本下方留白
@property (nonatomic,assign) CGFloat textBottomMargin;
//文本布局
@property (nonatomic,strong) YYTextLayout *textLayout;
//图片高度
@property (nonatomic,assign) CGFloat picHeight;
//视频高度
@property (nonatomic,assign) CGFloat videoHeight;
//工具条高度
@property (nonatomic,assign) CGFloat toolbarHeight;
//图片详情，视频详情下方的点赞和发布时间高度
@property (nonatomic,assign) CGFloat praiseAndPublicHeight;
//帖子cell总高度
@property (nonatomic,assign) CGFloat totalHeight;

@end

