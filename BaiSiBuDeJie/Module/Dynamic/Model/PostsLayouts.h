//
//  PostsLayouts.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/3.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 布局结果
 */
@class PostsModel,YYTextLayout;
@interface PostsLayouts : NSObject
- (instancetype)initWithModel:(PostsModel *)postsModel;
- (void)layout;

/*------------------👇下面是数据------------------*/
//一个帖子的总数据
@property (nonatomic,strong) PostsModel *postsModel;
//当前选中的帖子的索引
@property (nonatomic,assign) NSInteger *selectIndex;
//是否是展开状态
@property (nonatomic,assign) BOOL isExpend;
//是否显示展开按钮
@property (nonatomic,assign) BOOL isShowExpendButton;
//展开按钮名称
@property (nonatomic,copy)   NSString *expendButtonTitle;


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
//评论视图高度
@property (nonatomic,assign) CGFloat commentHeight;
//底部留白
@property (nonatomic,assign) CGFloat bottomMargin;
//帖子cell总高度
@property (nonatomic,assign) CGFloat totalHeight;
@end
