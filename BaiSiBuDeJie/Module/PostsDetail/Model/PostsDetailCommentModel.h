//
//  PostsDetailCommentModel.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/11.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/*评论的类型*/
typedef NS_ENUM(NSInteger,postsCommentType) {
    postsCommentTypeText,
    postsCommentTypeImage,
    postsCommentTypeVideo,
    postsCommentTypeAudio,
};


/**
 帖子详情评论用户信息
 */
@interface PostsDetailUserModel : NSObject
@property (nonatomic,copy) NSString *room_url;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *qq_uid;
@property (nonatomic,copy) NSString *room_role;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *room_name;
@property (nonatomic,copy) NSString *total_cmt_like_count;
@property (nonatomic,copy) NSString *profile_image;
@property (nonatomic,copy) NSString *personal_page;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *qzone_uid;
@property (nonatomic,copy) NSString *room_icon;
@property (nonatomic,copy) NSString *weibo_uid;
@property (nonatomic,assign) BOOL is_vip;
@end

/**
 图片评论Model
 */
@interface PostsImageCommentModel : NSObject
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,strong) NSArray *downloadArray;
@property (nonatomic,strong) NSArray *thumbnailArray;
@property (nonatomic,strong) NSArray *imagesArray;
@end

/**
 语音评论Model
 */
@interface PostsAudioCommentModel : NSObject
@property (nonatomic,copy) NSString *duration;
@property (nonatomic,strong) NSArray *audioArray;
@end

/**
 帖子详情评论
 */
@class PostsVideoModel;
@interface PostsDetailCommentModel : NSObject
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *ctime;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *like_count;
@property (nonatomic,copy) NSString *hate_count;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *commentId;
@property (nonatomic,copy) NSString *data_id;
@property (nonatomic,assign) postsCommentType commentType;
@property (nonatomic,strong) PostsDetailUserModel *user;
@property (nonatomic,strong) PostsImageCommentModel *image;
@property (nonatomic,strong) PostsVideoModel *video;
@property (nonatomic,strong) PostsAudioCommentModel *audio;
@property (nonatomic,strong) NSArray<PostsDetailCommentModel *> *precmtsArray;

@end

