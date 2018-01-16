//
//  PostsCommentComplexCell.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/15.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostsCommentDetailComplexLayout,PostsDetailCommentModel;
@protocol PostsCommentComplexCellDelegate <NSObject>
- (void)didClickedComplexUpButton:(PostsDetailCommentModel *)model;
- (void)didClickedComplexDownButton:(PostsDetailCommentModel *)model;
- (void)didClickedComplexNickName:(PostsDetailCommentModel *)model;
@end

/**
 帖子评论详情complexCell
 */
@interface PostsCommentComplexCell : UITableViewCell
@property (nonatomic,weak) id<PostsCommentComplexCellDelegate> delegate;
- (void)setComplexLayout:(PostsCommentDetailComplexLayout *)layout;
@end
