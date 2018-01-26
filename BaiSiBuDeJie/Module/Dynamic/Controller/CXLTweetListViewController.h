//
//  CXLTweetListViewController.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/28.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/*帖子内容*/
typedef NS_ENUM(NSUInteger,PostsType) {
    PostsTypeEssence = 0,
    PostsTypeVideo,
    PostsTypeImage,
    PostsTypeJoke,
    PostsTypeRank,
    PostsTypeSocial,
    PostsTypeMovieShare,
    PostsTypeGame,
    PostsType8090,
    PostsTypeInteractive,
};

@class PostsModel,PostsCell;
@protocol CXLTweetListViewControllerDelegate <NSObject>
- (void)didClickedCell:(PostsCell *)cell postsModel:(PostsModel *)model;
- (void)scrollViewWillEndDraggingWithVelocity:(CGPoint)velocity;
- (void)didClickedUserWithPostsModel:(PostsModel *)model;
@end

/**
 单个帖子ListView
 */
@interface CXLTweetListViewController : UIViewController
@property (nonatomic,weak) id<CXLTweetListViewControllerDelegate> delegate;
+ (instancetype)initWithType:(PostsType)type;
@end

/*
 * 推荐：
 * http://s.budejie.com/topic/list/jingxuan/1/bs0315-iphone-4.5.7/0-20.json
 * 视频：
 * http://s.budejie.com/topic/list/jingxuan/41/bs0315-iphone-4.5.7/0-20.json
 * 图片：
 * http://s.budejie.com/topic/list/jingxuan/10/bs0315-iphone-4.5.7/0-20.json
 * 段子：
 * http://s.budejie.com/topic/tag-topic/64/hot/bs0315-iphone-4.5.7/0-20.json
 * 排行：
 * http://s.budejie.com/topic/list/remen/1/bs0315-iphone-4.5.7/0-20.json
 * 社会：
 * http://s.budejie.com/topic/tag-topic/473/hot/bs0315-iphone-4.5.7/0-20.json
 * 影视分享：
 * http://s.budejie.com/topic/tag-topic/407/hot/bs0315-iphone-4.5.7/0-20.json
 * 游戏：
 * http://s.budejie.com/topic/tag-topic/164/hot/bs0315-iphone-4.5.7/0-20.json
 * 8090：
 * http://s.budejie.com/topic/tag-topic/5170/hot/bs0315-iphone-4.5.7/0-20.json
 * 互动区：
 * http://s.budejie.com/topic/tag-topic/44289/hot/bs0315-iphone-4.5.7/0-20.json
 */

