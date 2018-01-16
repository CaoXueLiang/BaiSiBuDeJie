//
//  PostsCommentNormalCell.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/15.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostsCommentDetailNormalLayout,PostsDetailCommentModel;
@protocol PostsCommentNormalCellDelegate <NSObject>
- (void)didClickedUpButton:(PostsDetailCommentModel *)model;
- (void)didClickedDownButton:(PostsDetailCommentModel *)model;
- (void)didClickedNickName:(PostsDetailCommentModel *)model;
@end


/**
 帖子评论详情NormalCell
 */
@interface PostsCommentNormalCell : UITableViewCell
@property (nonatomic,weak) id<PostsCommentNormalCellDelegate> delegate;
- (void)setLayout:(PostsCommentDetailNormalLayout *)layout index:(NSInteger)index;
@end

