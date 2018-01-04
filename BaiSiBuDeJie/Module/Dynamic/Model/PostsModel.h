//
//  PostsModel.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/*发布的帖子的类型*/
typedef NS_ENUM(NSInteger,postsContentType) {
    postsContentTypeText,
    postsContentTypeImage,
    postsContentTypeVideo,
};

/**
 单个图片
 */
@interface PostsImageModel : NSObject
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,strong) NSArray *downloadArray;
@property (nonatomic,strong) NSArray *thumbnailArray;
@property (nonatomic,strong) NSArray *bigArray;
@end

/**
 单个视频
 */
@interface PostsVideoModel : NSObject
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat playfcount;
@property (nonatomic,assign) NSInteger playcount;
@property (nonatomic,assign) NSInteger duration;
@property (nonatomic,strong) NSArray *thumbnailArray;
@property (nonatomic,strong) NSArray *downloadArray;
@property (nonatomic,strong) NSArray *thumbnailSmallArray;
@property (nonatomic,strong) NSArray *videoArray;
@end

/**
 单个标签
 */
@interface PostsTagModel : NSObject
@property (nonatomic,assign) NSInteger forum_sort;
@property (nonatomic,assign) NSInteger forum_status;
@property (nonatomic,assign) NSInteger tagId;
@property (nonatomic,assign) NSInteger post_number;
@property (nonatomic,assign) NSInteger sub_number;
@property (nonatomic,assign) NSInteger colum_set;
@property (nonatomic,assign) NSInteger display_level;
@property (nonatomic,copy) NSString *image_list;
@property (nonatomic,copy) NSString *tail;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *info;
@end

/**
 用户
 */
@interface PostsUserModel : NSObject
@property (nonatomic,strong) NSArray *headerArray;
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *room_url;
@property (nonatomic,copy) NSString *room_name;
@property (nonatomic,copy) NSString *room_role;
@property (nonatomic,copy) NSString *room_icon;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) BOOL is_vip;
@property (nonatomic,assign) BOOL is_v;
@end

/**
 评论
 */
@interface PostsCommentModel : NSObject
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *passtime;
@property (nonatomic,copy) NSString *cmt_type;
@property (nonatomic,copy) NSString *voiceuri;
@property (nonatomic,assign) NSInteger commentId;
@property (nonatomic,assign) NSInteger hate_count;
@property (nonatomic,assign) NSInteger voicetime;
@property (nonatomic,assign) NSInteger like_count;
@property (nonatomic,assign) NSInteger preuid;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) NSInteger precid;
@property (nonatomic,strong) PostsUserModel *u;
@end


/**
 单个帖子数据
 */
@interface PostsModel : NSObject
@property (nonatomic,copy) NSString *up;
@property (nonatomic,copy) NSString *down;
@property (nonatomic,copy) NSString *forward;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *bookmark;
@property (nonatomic,copy) NSString *postsId;
@property (nonatomic,copy) NSString *passtime;
@property (nonatomic,copy) NSString *comment;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *share_url;
@property (nonatomic,assign) postsContentType contentType;
@property (nonatomic,strong) PostsVideoModel *video;
@property (nonatomic,strong) PostsImageModel *image;
@property (nonatomic,strong) PostsUserModel *u;
@property (nonatomic,strong) NSArray<PostsTagModel *> *tags;
@property (nonatomic,strong) NSArray<PostsCommentModel *> *top_comments;
@end

