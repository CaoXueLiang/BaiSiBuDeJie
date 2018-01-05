//
//  CXLTweetListVideoController.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/4.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostsModel,PostsVideoCollectionViewCell;
@protocol CXLTweetListVideoControllerDelegate <NSObject>
- (void)didClickedVideoCell:(PostsVideoCollectionViewCell *)cell postsModel:(PostsModel *)model;
@end

/**
 单个帖子视频View
 */
@interface CXLTweetListVideoController : UIViewController
@property (nonatomic,weak) id<CXLTweetListVideoControllerDelegate> delegate;
@end
